/*======================================================================*//**
 * 
 * Progression
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://progression.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.progression.core.managers {
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.external.BrowserInterface;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.utils.SceneIdUtil;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * @private
	 */
	public class SyncManager extends EventIntegrator {
		
		/*======================================================================*//**
		 * 必要な JavaScript の存在を確認するコードを取得します。
		 */
		private static const _CHECK_JS_LIBRARY:String = ''
			+ 'function() {'
			+ '		switch ( undefined ) {'
			+ '			case deconcept.util				:'
			+ '			case deconcept.SWFObjectUtil	:'
			+ '			case com.asual.util.Browser		:'
			+ '			case com.asual.util.Events		:'
			+ '			case SWFAddress					:'
			+ '			case SWFAddressEvent			: { return false; }'
			+ '			default							: { return true; }'
			+ '		}'
			+ '}'
		
		
		
		
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		/*======================================================================*//**
		 * SyncManager インスタンスを格納したリストを取得します。
		 */
		private static var _instances:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 
		 */
		private static var _lock:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ブラウザ同期が可能かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enabled():Boolean { return _enabled; }
		private var _enabled:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ブラウザ同期を行うかどうかを取得します。
		 * この値は必ず同期処理が行われることを保障するものではありません。
		 * 処理が有効になっているかどうかを調べるには enabled プロパティを使用してください。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get sync():Boolean { return _sync; }
		public function set sync( value:Boolean ):void {
			if ( _sync = value ) {
				// 他の SyncManager を無効化する
				for each ( var manager:SyncManager in _instances ) {
					if ( manager == this ) { continue; }
					
					// 無効化する
					manager.sync = false;
				}
				
				// プレイヤータイプで処理を分岐する
				switch ( Capabilities.playerType ) {
					case "StandAlone"	:
					case "External"		: { break; }
					case "PlugIn"		:
					case "ActiveX"		: {
						// SWF ファイルを実行中の html 上に swfobject.js と swfaddress.js が読み込まれていなければ終了する
						if ( !BrowserInterface.call( _CHECK_JS_LIBRARY ) ) {
							Verbose.warning( this, VerboseMessageConstants.getMessage( "VERBOSE_0014" ) );
							return;
						}
						
						// SWFAddress のストリクトモードを無効化する
						BrowserInterface.call( "SWFAddress.setStrict", false );
						SWFAddress.setStrict( false );
						
						// ストリクトモードが有効化されていれば終了する
						if ( SWFAddress.getStrict() ) {
							Verbose.warning( this, VerboseMessageConstants.getMessage( "VERBOSE_0015" ) );
							return;
						}
						
						// 同期を有効化する
						_enabled = true;
						
						// イベントリスナーを登録する
						SWFAddress.addEventListener( SWFAddressEvent.CHANGE, _change );
						break;
					}
				}
				
				// イベントリスナーを登録する
				_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete, false, int.MAX_VALUE, true );
			}
			else {
				// 同期を無効化する
				_enabled = false;
				
				// イベントリスナーを解除する
				SWFAddress.removeEventListener( SWFAddressEvent.CHANGE, _change );
				_sceneManager.completelyRemoveEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete );
			}
		}
		private var _sync:Boolean = false;
		
		/*======================================================================*//**
		* 
		*/
		private var _trackEnabled:Boolean = true;
		
		/*======================================================================*//**
		* SceneObject インスタンスを取得します。
		*/
		private var _scene:SceneObject;
		
		/*======================================================================*//**
		 * SceneManager インスタンスを取得します。
		 */
		private var _sceneManager:SceneManager;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function SyncManager( sceneManager:SceneManager ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "SyncManager" ) ); };
			
			// 引数を設定する
			_sceneManager = sceneManager;
			
			// インスタンスリストに登録する
			_instances[_sceneManager] = this;
			
			// 初期化する
			_internallyCalled = false;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance( sceneManager:SceneManager ):SyncManager {
			_internallyCalled = true;
			return new SyncManager( sceneManager );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>オブジェクトのストリング表現です。</p>
		 * 	<p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return "[object SyncManager]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * シーン移動処理が完了した場合に送出されます。
		 */
		private function _processComplete( e:ProcessEvent ):void {
			// イベントリスナーを解除する
			if ( _scene ) {
				_scene.completelyRemoveEventListener( SceneEvent.SCENE_TITLE, _sceneTitle );
			}
			
			// 現在のシーンを設定する
			_scene = e.scene;
			
			// イベントリスナーを登録する
			if ( _scene ) {
				// タイトルを設定する
				SWFAddress.setTitle( _scene.title );
				
				_scene.addEventListener( SceneEvent.SCENE_TITLE, _sceneTitle, false, int.MAX_VALUE, true );
			}
		}
		
		/*======================================================================*//**
		 * 
		 */
		private function _change( e:SWFAddressEvent ):void {
			// SWFAddress の値を取得する
			var value:String = SWFAddress.getValue();
			
			// ルートシーン識別子を取得する
			var sceneId:SceneId = _sceneManager.root.sceneId.clone();
			
			try {
				// SceneId を作成する
				if ( value ) {
					sceneId = new SceneId( sceneId.path + value );
				}
			}
			catch ( e:Error ) {
				// エラーを送出して終了する
				Verbose.warning( this, VerboseMessageConstants.getMessage( "VERBOSE_0007", value ) );
				_sceneManager.interrupt( true );
				_sceneManager.dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_ERROR, false, false, _sceneManager.current, _sceneManager.eventType ) );
				return;
			}
			
			// ログを送出する
			if ( _trackEnabled ) {
				_trackEnabled = BrowserInterface.call( 'function( id ) {'
					+ '		if ( urchinTracker ) { urchinTracker( id ); return true; }'
					+ '		if ( pageTracker && pageTracker._trackPageview ) { pageTracker._trackPageview( id ); return true; }'
					+ '		return false'
					+ '}', sceneId.path );
			}
			
			// シーンを移動する
			_sceneManager.goto( sceneId );
		}
		
		/*======================================================================*//**
		* シーンオブジェクトのタイトルが変更された場合に送出されます。
		*/
		private function _sceneTitle( e:SceneEvent ):void {
			// タイトルを設定する
			SWFAddress.setTitle( e.scene.title );
		}
	}
}









