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
import jp.progression.Progression;
import jp.progression.ProgressionActivatedLicenseType;

Locale.setString( "開く" ,"ja", "開く" );
Locale.setString( "開く" ,"en", "Open ..." );

Locale.setString( "メールアドレスをコピーする" ,"ja", "メールアドレスをコピーする" );
Locale.setString( "メールアドレスをコピーする" ,"en", "Copy Mail Address" );

/**
 * パッケージ内からの呼び出しかどうかを取得します。
 */
private static var _internallyCalled:Boolean = false;





/**
 * CastButton インスタンスを取得します。
 */
private var _target:CastButton;

/**
 * ContextMenu インスタンスを取得します。
 */
private var _menu:ContextMenu;





/**
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

/**
 * @private
 */
progression_internal static function __createInstance( target:CastButton, menu:ContextMenu ):CastButtonContextMenu {
	_internallyCalled = true;
	return new CastButtonContextMenu( target, menu );
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
	_hideOpen = true;
	_hideOpenNewWindow = true;
	_hideCopyURL = true;
}





/**
 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
 */
private function _menuSelect( e:ContextMenuEvent ):void {
	var items:Array = _menu.customItems = [];
	var item:ContextMenuItem;
	
	// 無効化されていれば終了する
	if ( !_enabled || !CastButtonContextMenu.enabled ) {
		// Built on ...
		switch ( Progression.activatedLicenseType ) {
			case ProgressionActivatedLicenseType.BUSINESS_APPLICATION_LICENSE	:
			case ProgressionActivatedLicenseType.BUSINESS_WEB_LICENSE			: { break; }
			case ProgressionActivatedLicenseType.BASIC_LIBRARY_LICENSE			: {
				items.push( item = new ContextMenuItem( "Built on " + Progression.NAME + " " + Progression.VERSION.majorVersion, true ) );
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectBuiltOn, false, int.MAX_VALUE, true );
				break;
			}
		}
		return;
	}
	
	// 開くを有効化するかどうか
	if ( !_hideOpen ) {
		items.push( item = new ContextMenuItem( Locale.getString( "開く" ) ) );
		item.enabled = !!_target.navigateURL;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpen, false, int.MAX_VALUE, true );
	}
	
	// 新規ウィンドウで開くを有効化するかどうか
	if ( !_hideOpenNewWindow ) {
		items.push( item = new ContextMenuItem( Locale.getString( "新規ウィンドウで開く" ) ) );
		item.enabled = !!_target.navigateURL && BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectOpenNewWindow, false, int.MAX_VALUE, true );
	}
	
	// URL のコピーを有効化するかどうか
	if ( !_hideCopyURL ) {
		items.push( item = new ContextMenuItem( Locale.getString( "URL をコピーする" ), true ) );
		item.enabled = !!_target.navigateURL && BrowserInterface.enabled;
		item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectCopyURL, false, int.MAX_VALUE, true );
	}
	
	// Built on ...
	switch ( Progression.activatedLicenseType ) {
		case ProgressionActivatedLicenseType.BUSINESS_APPLICATION_LICENSE	:
		case ProgressionActivatedLicenseType.BUSINESS_WEB_LICENSE			: { break; }
		case ProgressionActivatedLicenseType.BASIC_LIBRARY_LICENSE			: {
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
private function _menuSelectOpen( e:ContextMenuEvent ):void {
	_target.navigateTo();
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectOpenNewWindow( e:ContextMenuEvent ):void {
	_target.navigateTo( null, "_blank" );
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectCopyURL( e:ContextMenuEvent ):void {
	System.setClipboard( _target.navigateURL );
}

/**
 * ユーザーがコンテキストメニューからアイテムを選択したときに送出されます。
 */
private function _menuSelectBuiltOn( e:ContextMenuEvent ):void {
	navigateToURL( new URLRequest( Progression.progression_internal::$BUILT_ON_URL ), Progression.URL );
}
