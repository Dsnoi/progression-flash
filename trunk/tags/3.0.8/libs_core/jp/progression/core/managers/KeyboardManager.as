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
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.external.BrowserInterface;
	import jp.progression.core.managers.HistoryManager;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * @private
	 */
	public class KeyboardManager extends EventIntegrator {
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>キーボードショートカットを使用するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void {
			if ( _enabled = value ) {
				_stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp, false, int.MAX_VALUE, true );
			}
			else {
				_stage.removeEventListener( KeyboardEvent.KEY_UP, _keyUp );
			}
		}
		private var _enabled:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ブラウザの更新機能をキーボードショートカットから使用するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get useReloadKey():Boolean { return _useReloadKey; }
		public function set useReloadKey( value:Boolean ):void { _useReloadKey = value; }
		private var _useReloadKey:Boolean = true;
		
		/*======================================================================*//**
		 * <p>ブラウザの印刷機能をキーボードショートカットから使用するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get usePrintKey():Boolean { return _usePrintKey; }
		public function set usePrintKey( value:Boolean ):void { _usePrintKey = value; }
		private var _usePrintKey:Boolean = true;
		
		/*======================================================================*//**
		 * <p>ブラウザのフルスクリーン機能をキーボードショートカットから使用するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get useFullScreenKey():Boolean { return _useFullScreenKey; }
		public function set useFullScreenKey( value:Boolean ):void { _useFullScreenKey = value; }
		private var _useFullScreenKey:Boolean = true;
		
		/*======================================================================*//**
		 * Stage インスタンスを取得します。
		 */
		private var _stage:Stage;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function KeyboardManager( stage:Stage ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "KeyboardManager" ) ); };
			
			// 引数を設定する
			_stage = stage;
			
			// 初期化する
			enabled = true;
			_internallyCalled = false;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance( stage:Stage ):KeyboardManager {
			_internallyCalled = true;
			return new KeyboardManager( stage );
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
			return "[object KeyboardManager]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			// フォーカスが TextField に存在している場合は終了する
			if ( _stage.focus is TextField ) { return; }
			
			switch ( e.keyCode ) {
				// 履歴
				case 8		: {
					if ( e.shiftKey ) { return; }
					if ( e.ctrlKey ) { return; }
					HistoryManager.back();
					break;
				}
				case 37		: {
					if ( e.shiftKey ) { return; }
					if ( !e.ctrlKey ) { return; }
					HistoryManager.back();
					break;
				}
				case 39		: {
					if ( e.shiftKey ) { return; }
					if ( !e.ctrlKey ) { return; }
					HistoryManager.forward();
					break;
				}
				
				// 更新する
				case 82		: {
					if ( !_useReloadKey ) { return; }
					if ( e.shiftKey ) { return; }
					if ( !e.ctrlKey ) { return; }
					BrowserInterface.reload();
				}
				case 116	: {
					if ( !_useReloadKey ) { return; }
					if ( e.shiftKey ) { return; }
					if ( e.ctrlKey ) { return; }
					BrowserInterface.reload();
				}
				
				// 印刷ダイアログを表示する
				case 80		: {
					if ( !_usePrintKey ) { return; }
					if ( e.shiftKey ) { return; }
					if ( !e.ctrlKey ) { return; }
					BrowserInterface.print();
				}
				
				// フルスクリーン表示する
				case 122	: {
					if ( !_useFullScreenKey ) { return; }
					if ( e.shiftKey ) { return; }
					if ( e.ctrlKey ) { return; }
					_stage.displayState = StageDisplayState.FULL_SCREEN;
				}
			}
		}
	}
}









