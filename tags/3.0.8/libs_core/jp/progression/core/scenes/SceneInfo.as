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
package jp.progression.core.scenes {
	import flash.display.LoaderInfo;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.net.Query;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.SceneEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>ロード操作が開始したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.OPEN
	 */
	[Event( name="open", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>データが正常にロードされたときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>ロードされたオブジェクトが Loader オブジェクトの unload() メソッドを使用して削除されるたびに、LoaderInfo オブジェクトによって送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.UNLOAD
	 */
	[Event( name="unload", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/*======================================================================*//**
	 * <p>ネットワーク要求が HTTP を介して行われ、Flash Player が HTTP 状況コードを検出できる場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
	 */
	[Event( name="httpStatus", type="flash.events.HTTPStatusEvent" )]
	
	/*======================================================================*//**
	 * <p>入出力エラーが発生してロード処理が失敗したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	/*======================================================================*//**
	 * <p>query の値が更新された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.SceneEvent.SCENE_QUERY
	 */
	[Event( name="sceneQuery", type="jp.progression.events.SceneEvent" )]
	
	/*======================================================================*//**
	 * <p>SceneObject インスタンスに関する情報を提供します。
	 * SceneInfo クラスを直接インスタンス化することはできません。
	 * new SceneInfo() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneInfo extends EventIntegrator {
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * SceneObject インスタンスを取得します。
		 */
		private var _target:SceneObject;
		
		/*======================================================================*//**
		 * <p>この SceneInfo オブジェクトに関係したロードされたオブジェクトです。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get content():SceneObject {
			// 自身に値が設定されていればそのまま返す
			if ( _content ) { return _content; }
			
			// 親が存在すれば、親の値を返す
			if ( _target.parent ) { return _target.parent.sceneInfo.content; }
			
			// ルートが存在すれば、ルートの値を返す
			if ( _target.root ) { return _target.root.sceneInfo.content; }
			
			return null;
		}
		private var _content:SceneObject;
		
		/*======================================================================*//**
		 * <p>この SceneInfo オブジェクトによって記述されるメディアのロードを開始した SWF ファイルの URL です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get loaderURL():String {
			// 自身に値が設定されていればそのまま返す
			if ( _loaderURL ) { return _loaderURL; }
			
			// 親が存在すれば、親の値を返す
			if ( _target.parent ) { return _target.parent.sceneInfo.loaderURL; }
			
			// ルートが存在すれば、ルートの値を返す
			if ( _target.root ) { return _target.root.sceneInfo.loaderURL; }
			
			return null;
		}
		private var _loaderURL:String;
		
		/*======================================================================*//**
		 * <p>ロードされるメディアの URL です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get url():String {
			// 自身に値が設定されていればそのまま返す
			if ( _url ) { return _url; }
			
			// 親が存在すれば、親の値を返す
			if ( _target.parent ) { return _target.parent.sceneInfo.url; }
			
			// ルートが存在すれば、ルートの値を返す
			if ( _target.root ) { return _target.root.sceneInfo.url; }
			
			return null;
		}
		private var _url:String;
		
		/*======================================================================*//**
		 * <p>PRMLLoader クラスや addChildFromXML() メソッドなどで追加されたシーンオブジェクトに設定されていた XML データを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get data():XMLList { return _data.copy(); }
		private var _data:XMLList = new XMLList();
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __data():XMLList { return _data; }
		progression_internal function set __data( value:XMLList ):void { _data = value; }
		
		/*======================================================================*//**
		 * <p>Progression.goto() メソッドの引数の SceneId インスタンスに設定されていた Query データを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get query():Query { return _query; }
		private var _query:Query = new Query( true );
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __query():Query { return _query; }
		progression_internal function set __query( value:Query ):void {
			// 同一のクエリではなければ
			if ( !_query.equals( value ) ) {
				// クエリを更新する
				_query = value;
				
				// イベントを送出する
				dispatchEvent( new SceneEvent( SceneEvent.SCENE_QUERY, false, false, _target, _target.progression.eventType ) );
			}
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function SceneInfo( target:SceneObject ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "SceneInfo" ) ); };
			
			// 引数を設定する
			_target = target;
			
			// 初期化する
			_internallyCalled = false;
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( SceneEvent.LOAD, _load, false, int.MAX_VALUE, true );
			_target.addExclusivelyEventListener( SceneEvent.SCENE_ADDED_TO_ROOT, _sceneAddedToRoot, false, int.MAX_VALUE, true );
			_target.addExclusivelyEventListener( SceneEvent.SCENE_REMOVED_FROM_ROOT, _sceneRemovedFromRoot, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance( target:SceneObject ):SceneInfo {
			_internallyCalled = true;
			return new SceneInfo( target );
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
			return "[object SceneInfo]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * シーン移動時に目的地がシーンオブジェクト自身もしくは子階層だった場合に、階層が変更された瞬間に送出されます。
		 */
		private function _load( e:SceneEvent ):void {
			// 対象が目的地であれば
			if ( _target.sceneId.equals( _target.progression.destinedSceneId ) ) {
				// クエリを更新する
				progression_internal::__query = new Query( true, _target.progression.destinedSceneId.query );
			}
		}
		
		/*======================================================================*//**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの追加により、ルートシーン上のシーンリストに追加されたときに送出されます。
		 */
		private function _sceneAddedToRoot( e:SceneEvent ):void {
			var loaderInfo:LoaderInfo = _target.progression.stage.loaderInfo;
			
			_content = null;
			_loaderURL = loaderInfo.loaderURL;
			_url = loaderInfo.url;
		}
		
		/*======================================================================*//**
		 * シーンオブジェクトが直接、またはシーンオブジェクトを含むサブツリーの削除により、ルートシーン上のシーンリストから削除されようとしているときに送出されます。
		 */
		private function _sceneRemovedFromRoot( e:SceneEvent ):void {
			_content = null;
			_loaderURL = null;
			_url = null;
		}
	}
}









