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
import jp.progression.ActivatedLicenseType;
import jp.progression.Progression;

Locale.setString( "前に戻る", "ja", "前に戻る" );
Locale.setString( "前に戻る", "en", "Back ..." );

Locale.setString( "次に進む", "ja", "次に進む" );
Locale.setString( "次に進む", "en", "Forward ..." );

Locale.setString( "更新", "ja", "更新" );
Locale.setString( "更新", "en", "Reload ..." );

Locale.setString( "新規ウィンドウで開く", "ja", "新規ウィンドウで開く" );
Locale.setString( "新規ウィンドウで開く", "en", "Open Link in New Window" );

Locale.setString( "URL をコピーする", "ja", "URL をコピーする" );
Locale.setString( "URL をコピーする", "en", "Copy Link Location" );

Locale.setString( "URL をメールで送信する", "ja", "URL をメールで送信する" );
Locale.setString( "URL をメールで送信する", "en", "Send Link" );

Locale.setString( "印刷する", "ja", "印刷する" );
Locale.setString( "印刷する", "en", "Print ..." );

/**
 * パッケージ内からの呼び出しかどうかを取得します。
 */
private static var _internallyCalled:Boolean = false;





/**
 * ICastObject インスタンスを取得します。
 */
private var _target:ICastObject;

/**
 * ContextMenu インスタンスを取得します。
 */
private var _menu:ContextMenu;





/**
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





/**
 * @private
 */
progression_internal static function __createInstance( target:ICastObject, menu:ContextMenu ):CastObjectContextMenu {
	_internallyCalled = true;
	return new CastObjectContextMenu( target, menu );
}





/**
 * 
 */
private function _hideBuiltInItems():void {
	_menu.hideBuiltInItems();
}

/**
 * 
 */
private function _hideProgressionItems():void {
	_hideHistory = true;
	_hideReload = true;
	_hideOpenNewWindow = true;
	_hideCopyURL = true;
	_hidePrint = true;
}





/**
 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
 */
private function _menuSelect( e:ContextMenuEvent ):void {
	var items:Array = _menu.customItems = [];
	var item:ContextMenuItem;
	
	// 無効化されていれば終了する
	if ( !_enabled || !CastObjectContextMenu.enabled ) {
		// Built on ...
		switch ( Progression.activatedLicenseType ) {
			case ActivatedLicenseType.PLL_APPLICATION	:
			case ActivatedLicenseType.PLL_WEB			: { break; }
			case ActivatedLicenseType.GPL				:
			case ActivatedLicenseType.PLL_BASIC			: {
				items.push( item = new ContextMenuItem( "Built on " + Progression.NAME + " " + Progression.VERSION.majorVersion, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectBuiltOn, false, int.MAX_VALUE, true );
				break;
			}
		}
		return;
	}
	
	// 履歴を有効化するかどうか
	if ( !_hideHistory ) {
		items.push( item = new ContextMenuItem( Locale.getString( "前に戻る" ) ) );
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryBack, false, int.MAX_VALUE, true );
		
		items.push( item = new ContextMenuItem( Locale.getString( "次に進む" ) ) );
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectHistoryForward, false, int.MAX_VALUE, true );
	}
	
	// 更新を有効化するかどうか
	if ( !_hideReload ) {
		items.push( item = new ContextMenuItem( Locale.getString( "更新" ) ) );
		item.enabled = BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectReload, false, int.MAX_VALUE, true );
	}
	
	// 新規ウィンドウで開くを有効化するかどうか
	if ( !_hideOpenNewWindow ) {
		items.push( item = new ContextMenuItem( Locale.getString( "新規ウィンドウで開く" ), true ) );
		item.enabled = BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenNewWindow, false, int.MAX_VALUE, true );
	}
	
	// URL のコピーを有効化するかどうか
	if ( !_hideCopyURL ) {
		items.push( item = new ContextMenuItem( Locale.getString( "URL をコピーする" ), true ) );
		item.enabled = BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyURL, false, int.MAX_VALUE, true );
		
		items.push( item = new ContextMenuItem( Locale.getString( "URL をメールで送信する" ) ) );
		item.enabled = BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectMailURL, false, int.MAX_VALUE, true );
	}
	
	// 印刷機能を有効化するかどうか
	if ( !_hidePrint ) {
		items.push( item = new ContextMenuItem( Locale.getString( "印刷する" ), true ) );
		item.enabled = BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectPrint, false, int.MAX_VALUE, true );
	}
	
	// Built on ...
	switch ( Progression.activatedLicenseType ) {
		case ActivatedLicenseType.PLL_APPLICATION	:
		case ActivatedLicenseType.PLL_WEB			: { break; }
		case ActivatedLicenseType.GPL				:
		case ActivatedLicenseType.PLL_BASIC			: {
			items.push( item = new ContextMenuItem( Progression.progression_internal::$BUILT_ON_LABEL, true ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectBuiltOn, false, int.MAX_VALUE, true );
			break;
		}
	}
	
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

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectHistoryBack( e:ContextMenuEvent ):void {
	HistoryManager.back();
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectHistoryForward( e:ContextMenuEvent ):void {
	HistoryManager.forward();
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectReload( e:ContextMenuEvent ):void {
	BrowserInterface.reload();
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectOpenNewWindow( e:ContextMenuEvent ):void {
	navigateToURL( new URLRequest( BrowserInterface.locationHref ), "_blank" );
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectCopyURL( e:ContextMenuEvent ):void {
	System.setClipboard( BrowserInterface.locationHref );
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectMailURL( e:ContextMenuEvent ):void {
	navigateToURL( new URLRequest( "mailto:?subject=" + escapeMultiByte( SWFAddress.getTitle() ) + "&body=" + escape( BrowserInterface.locationHref ) ) );
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectPrint( e:ContextMenuEvent ):void {
	BrowserInterface.print();
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectBuiltOn( e:ContextMenuEvent ):void {
	navigateToURL( new URLRequest( Progression.progression_internal::$BUILT_ON_URL ), Progression.URL );
}
