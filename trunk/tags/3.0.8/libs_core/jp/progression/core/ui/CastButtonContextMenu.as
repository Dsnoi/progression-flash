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
package jp.progression.core.ui {
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.external.BrowserInterface;
	import jp.nium.lang.Locale;
	import jp.progression.casts.CastButton;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.ICastContextMenu;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>CastButtonContextMenu クラスは、ContextMenu クラスの基本機能を拡張した jp.progression パッケージで使用される基本的なボタンメニュークラスです。
	 * CastButtonContextMenu クラスを直接インスタンス化することはできません。
	 * new CastButtonContextMenu() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastButtonContextMenu implements ICastContextMenu {
		
		/*======================================================================*//**
		 * <p>コンテクストメニューを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void { _enabled = value; }
		private static var _enabled:Boolean = true;
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		/*======================================================================*//**
		 * 初期化されたかどうかを取得します。
		 */
		private static var _initialized:Boolean = function():Boolean {
			Locale.setString( "開く" ,"ja", "開く" );
			Locale.setString( "開く" ,"en", "Open" );
			
			Locale.setString( "メールアドレスをコピーする" ,"ja", "メールアドレスをコピーする" );
			Locale.setString( "メールアドレスをコピーする" ,"en", "Copy Mail Address" );
			
			return true;
		}.apply();
		
		
		
		
		
		/*======================================================================*//**
		 * <p>コンテクストメニューを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void { _enabled = value; }
		private var _enabled:Boolean = true;
		
		/*======================================================================*//**
		 * <p>ユーザー定義の ContextMenuItem を含む配列を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get customItems():Array { return _customItems; }
		private var _customItems:Array = [];
		
		/*======================================================================*//**
		 * <p>[開く] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideOpen():Boolean { return _hideOpen; }
		public function set hideOpen( value:Boolean ):void { _hideOpen = value; }
		private var _hideOpen:Boolean = false;
		
		/*======================================================================*//**
		 * <p>[新規ウィンドウで開く] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideOpenNewWindow():Boolean { return _hideOpenNewWindow; }
		public function set hideOpenNewWindow( value:Boolean ):void { _hideOpenNewWindow = value; }
		private var _hideOpenNewWindow:Boolean = false;
		
		/*======================================================================*//**
		 * <p>[URL をコピーする] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideCopyURL():Boolean { return _hideCopyURL; }
		public function set hideCopyURL( value:Boolean ):void { _hideCopyURL = value; }
		private var _hideCopyURL:Boolean = false;
		
		/*======================================================================*//**
		 * CastButton インスタンスを取得します。
		 */
		private var _target:CastButton;
		
		/*======================================================================*//**
		 * ContextMenu インスタンスを取得します。
		 */
		private var _menu:ContextMenu;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function CastButtonContextMenu( target:CastButton, menu:ContextMenu ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CastButtonContextMenu" ) ); };
			
			// 引数を設定する
			_target = target;
			_menu = menu;
			
			// ビルトインメニューを非表示にする
			_menu.hideBuiltInItems();
			
			// 初期化する
			_internallyCalled = false;
			
			// イベントリスナーを登録する
			_menu.addEventListener( ContextMenuEvent.MENU_SELECT, _menuSelect, false, 0, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance( target:CastButton, menu:ContextMenu ):CastButtonContextMenu {
			_internallyCalled = true;
			return new CastButtonContextMenu( target, menu );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>[設定] を除き、指定された ContextMenu オブジェクト内のすべてのビルトインメニューアイテムを非表示にします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function hideBuiltInItems():void {
			_menu.hideBuiltInItems();
		}
		
		/*======================================================================*//**
		 * <p>指定された ContextMenu オブジェクト内の Progression に関連するすべてのメニューアイテムを非表示にします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function hideProgressionItems():void {
			_hideOpen = true;
			_hideOpenNewWindow = true;
			_hideCopyURL = true;
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
		public function toString():String {
			return "[object CastButtonContextMenu]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
		 */
		private function _menuSelect( e:ContextMenuEvent ):void {
			var items:Array = _menu.customItems = [];
			var item:ContextMenuItem;
			
			// 無効化されていれば終了する
			if ( !_enabled || !CastButtonContextMenu.enabled ) {
				// Powered by ...
				items.push( item = new ContextMenuItem( "Powered by " + Progression.NAME + " " + Progression.VERSION, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPoweredBy, false, int.MAX_VALUE, true );
				return;
			}
			
			// 開くを有効化するかどうか
			if ( !_hideOpen ) {
				items.push( item = new ContextMenuItem( Locale.getString( "開く" ) + "　" ) );
				item.enabled = !!_target.navigateURL;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpen, false, int.MAX_VALUE, true );
			}
			
			// 新規ウィンドウで開くを有効化するかどうか
			if ( !_hideOpenNewWindow ) {
				items.push( item = new ContextMenuItem( Locale.getString( "新規ウィンドウで開く" ) + "　" ) );
				item.enabled = !!_target.navigateURL && BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenNewWindow, false, int.MAX_VALUE, true );
			}
			
			// URL のコピーを有効化するかどうか
			if ( !_hideCopyURL ) {
				items.push( item = new ContextMenuItem( Locale.getString( "URL をコピーする" ) + "　", true ) );
				item.enabled = !!_target.navigateURL && BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyURL, false, int.MAX_VALUE, true );
			}
			
			// Powered by ...
			items.push( item = new ContextMenuItem( "Powered by " + Progression.NAME + " " + Progression.VERSION, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPoweredBy, false, int.MAX_VALUE, true );
			
			// 先頭の要素のセパレータを有効化する
			if ( items.length > 0 ) {
				ContextMenuItem( items[0] ).separatorBefore = true;
			}
			
			// カスタムメニューを追加する
			var l:int = Math.min( _customItems.length, 15 - items.length );
			for ( var i:int = 0; i < l; i++ ) {
				items.unshift( _customItems[l - i - 1] );
			}
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectOpen( e:ContextMenuEvent ):void {
			_target.navigateTo();
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectOpenNewWindow( e:ContextMenuEvent ):void {
			_target.navigateTo( null, "_blank" );
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectCopyURL( e:ContextMenuEvent ):void {
			System.setClipboard( _target.navigateURL );
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectPoweredBy( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( "http://progression.jp/" ), "http://progression.jp/" );
		}
	}
}









