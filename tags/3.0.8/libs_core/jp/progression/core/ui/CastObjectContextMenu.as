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
	import com.asual.swfaddress.SWFAddress;
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.escapeMultiByte;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.external.BrowserInterface;
	import jp.nium.lang.Locale;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.managers.HistoryManager;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.ICastContextMenu;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>CastObjectContextMenu クラスは、ContextMenu クラスの基本機能を拡張した jp.progression パッケージで使用される基本的なオブジェクトメニュークラスです。
	 * CastObjectContextMenu クラスを直接インスタンス化することはできません。
	 * new CastObjectContextMenu() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastObjectContextMenu implements ICastContextMenu {
		
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
			Locale.setString( "前に戻る", "ja", "前に戻る" );
			Locale.setString( "前に戻る", "en", "Back" );
			
			Locale.setString( "次に進む", "ja", "次に進む" );
			Locale.setString( "次に進む", "en", "Forword" );
			
			Locale.setString( "更新", "ja", "更新" );
			Locale.setString( "更新", "en", "Reload" );
			
			Locale.setString( "新規ウィンドウで開く", "ja", "新規ウィンドウで開く" );
			Locale.setString( "新規ウィンドウで開く", "en", "Open Link in New Window" );
			
			Locale.setString( "URL をコピーする", "ja", "URL をコピーする" );
			Locale.setString( "URL をコピーする", "en", "Copy Link Location" );
			
			Locale.setString( "URL をメールで送信する", "ja", "URL をメールで送信する" );
			Locale.setString( "URL をメールで送信する", "en", "Send Link" );
			
			Locale.setString( "印刷する", "ja", "印刷する" );
			Locale.setString( "印刷する", "en", "Print" );
			
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
		 * <p>[前に戻る] 及び [次に進む] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideHistory():Boolean { return _hideHistory; }
		public function set hideHistory( value:Boolean ):void { _hideHistory = value; }
		private var _hideHistory:Boolean = false;
		
		/*======================================================================*//**
		 * <p>[更新] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideReload():Boolean { return _hideReload; }
		public function set hideReload( value:Boolean ):void { _hideReload = value; }
		private var _hideReload:Boolean = false;
		
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
		 * <p>[URL をコピーする] 及び [URL をメールで送信する] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hideCopyURL():Boolean { return _hideCopyURL; }
		public function set hideCopyURL( value:Boolean ):void { _hideCopyURL = value; }
		private var _hideCopyURL:Boolean = false;
		
		/*======================================================================*//**
		 * <p>[印刷する] メニューを表示するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get hidePrint():Boolean { return _hidePrint; }
		public function set hidePrint( value:Boolean ):void { _hidePrint = value; }
		private var _hidePrint:Boolean = false;
		
		/*======================================================================*//**
		 * ICastObject インスタンスを取得します。
		 */
		private var _target:ICastObject;
		
		/*======================================================================*//**
		 * ContextMenu インスタンスを取得します。
		 */
		private var _menu:ContextMenu;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function CastObjectContextMenu( target:ICastObject, menu:ContextMenu ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CastObjectContextMenu" ) ); };
			
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
		progression_internal static function __createInstance( target:ICastObject, menu:ContextMenu ):CastObjectContextMenu {
			_internallyCalled = true;
			return new CastObjectContextMenu( target, menu );
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
			_hideHistory = true;
			_hideReload = true;
			_hideOpenNewWindow = true;
			_hideCopyURL = true;
			_hidePrint = true;
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
			return "[object CastObjectContextMenu]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
		 */
		private function _menuSelect( e:ContextMenuEvent ):void {
			var items:Array = _menu.customItems = [];
			var item:ContextMenuItem;
			
			// 無効化されていれば終了する
			if ( !_enabled || !CastObjectContextMenu.enabled ) {
				// Powered by ...
				items.push( item = new ContextMenuItem( "Powered by " + Progression.NAME + " " + Progression.VERSION, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPoweredBy, false, int.MAX_VALUE, true );
				return;
			}
			
			// 履歴を有効化するかどうか
			if ( !_hideHistory ) {
				items.push( item = new ContextMenuItem( Locale.getString( "前に戻る" ) + "　" ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryBack, false, int.MAX_VALUE, true );
				
				items.push( item = new ContextMenuItem( Locale.getString( "次に進む" ) + "　" ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryForward, false, int.MAX_VALUE, true );
			}
			
			// 更新を有効化するかどうか
			if ( !_hideReload ) {
				items.push( item = new ContextMenuItem( Locale.getString( "更新" ) + "　" ) );
				item.enabled = BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectReload, false, int.MAX_VALUE, true );
			}
			
			// 新規ウィンドウで開くを有効化するかどうか
			if ( !_hideOpenNewWindow ) {
				items.push( item = new ContextMenuItem( Locale.getString( "新規ウィンドウで開く" ) + "　", true ) );
				item.enabled = BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenNewWindow, false, int.MAX_VALUE, true );
			}
			
			// URL のコピーを有効化するかどうか
			if ( !_hideCopyURL ) {
				items.push( item = new ContextMenuItem( Locale.getString( "URL をコピーする" ) + "　", true ) );
				item.enabled = BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyURL, false, int.MAX_VALUE, true );
				
				items.push( item = new ContextMenuItem( Locale.getString( "URL をメールで送信する" ) + "　" ) );
				item.enabled = BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectMailURL, false, int.MAX_VALUE, true );
			}
			
			// 印刷機能を有効化するかどうか
			if ( !_hidePrint ) {
				items.push( item = new ContextMenuItem( Locale.getString( "印刷する" ) + "　", true ) );
				item.enabled = BrowserInterface.enabled;
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPrint, false, int.MAX_VALUE, true );
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
		private function _menuSelectHistoryBack( e:ContextMenuEvent ):void {
			HistoryManager.back();
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectHistoryForward( e:ContextMenuEvent ):void {
			HistoryManager.forward();
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectReload( e:ContextMenuEvent ):void {
			BrowserInterface.reload();
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectOpenNewWindow( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( BrowserInterface.locationHref ), "_blank" );
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectCopyURL( e:ContextMenuEvent ):void {
			System.setClipboard( BrowserInterface.locationHref );
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectMailURL( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( "mailto:?subject=" + escapeMultiByte( SWFAddress.getTitle() ) + "&body=" + escape( BrowserInterface.locationHref ) ) );
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectPrint( e:ContextMenuEvent ):void {
			BrowserInterface.print();
		}
		
		/*======================================================================*//**
		 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
		 */
		private function _menuSelectPoweredBy( e:ContextMenuEvent ):void {
			navigateToURL( new URLRequest( "http://progression.jp/" ), "http://progression.jp/" );
		}
	}
}









