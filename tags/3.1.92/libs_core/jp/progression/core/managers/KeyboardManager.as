/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
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
	
	/**
	 * @private
	 */
	public class KeyboardManager extends EventIntegrator {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">キーボードショートカットを使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
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
		
		/**
		 * <span lang="ja">ブラウザの更新機能をキーボードショートカットから使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get useReloadKey():Boolean { return _useReloadKey; }
		public function set useReloadKey( value:Boolean ):void { _useReloadKey = value; }
		private var _useReloadKey:Boolean = true;
		
		/**
		 * <span lang="ja">ブラウザの印刷機能をキーボードショートカットから使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get usePrintKey():Boolean { return _usePrintKey; }
		public function set usePrintKey( value:Boolean ):void { _usePrintKey = value; }
		private var _usePrintKey:Boolean = true;
		
		/**
		 * <span lang="ja">ブラウザのフルスクリーン機能をキーボードショートカットから使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get useFullScreenKey():Boolean { return _useFullScreenKey; }
		public function set useFullScreenKey( value:Boolean ):void { _useFullScreenKey = value; }
		private var _useFullScreenKey:Boolean = true;
		
		/**
		 * Stage インスタンスを取得します。
		 */
		private var _stage:Stage;
		
		
		
		
		
		/**
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
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __createInstance( stage:Stage ):KeyboardManager {
			_internallyCalled = true;
			return new KeyboardManager( stage );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return "[object KeyboardManager]";
		}
		
		
		
		
		
		/**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			// フォーカスが TextField に存在している場合は終了する
			if ( _stage.focus is TextField ) { return; }
			
			switch ( e.keyCode ) {
				// 履歴
				case 8		: {
					if ( e.shiftKey || e.ctrlKey ) { return; }
					HistoryManager.back();
					break;
				}
				case 37		: {
					if ( e.shiftKey || !e.ctrlKey ) { return; }
					HistoryManager.back();
					break;
				}
				case 39		: {
					if ( e.shiftKey || !e.ctrlKey ) { return; }
					HistoryManager.forward();
					break;
				}
				
				// 更新する
				case 82		: {
					if ( !_useReloadKey || e.shiftKey || !e.ctrlKey ) { return; }
					BrowserInterface.reload();
				}
				case 116	: {
					if ( !_useReloadKey || e.shiftKey || e.ctrlKey ) { return; }
					BrowserInterface.reload();
				}
				
				// 印刷ダイアログを表示する
				case 80		: {
					if ( !_usePrintKey || e.shiftKey || !e.ctrlKey ) { return; }
					BrowserInterface.print();
				}
				
				// フルスクリーン表示する
				case 122	: {
					if ( !_useFullScreenKey || e.shiftKey || e.ctrlKey ) { return; }
					_stage.displayState = StageDisplayState.FULL_SCREEN;
				}
			}
		}
	}
}
