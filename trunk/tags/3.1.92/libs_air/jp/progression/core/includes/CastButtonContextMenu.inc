import flash.events.ContextMenuEvent;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import jp.nium.core.errors.ErrorMessageConstants;
import jp.progression.casts.ICastObject;
import jp.progression.ActivatedLicenseType;
import jp.progression.Progression;

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
public function CastButtonContextMenu( target:ICastObject, menu:* ) {
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
progression_internal static function __createInstance( target:ICastObject, menu:* ):CastButtonContextMenu {
	_internallyCalled = true;
	return new CastButtonContextMenu( target, menu );
}





/**
 * 
 */
private function _hideBuiltInItems():void {
}

/**
 * 
 */
private function _hideProgressionItems():void {
}





/**
 * ユーザーが最初にコンテキストメニューを生成したときに、コンテキストメニューの内容が表示される前に送出されます。
 */
private function _menuSelect( e:ContextMenuEvent ):void {
	var items:Array = _menu.customItems = [];
	var item:ContextMenuItem;
	
	// Built on ...
	switch ( Progression.activatedLicenseType ) {
		case ActivatedLicenseType.PLL_APPLICATION	:
		case ActivatedLicenseType.PLL_WEB			: { break; }
		case ActivatedLicenseType.GPL				:
		case ActivatedLicenseType.PLL_BASIC			: {
			items.push( item = new ContextMenuItem( "Built on " + Progression.NAME + " " + Progression.VERSION.majorVersion, false ) );
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _menuSelectBuiltOn, false, int.MAX_VALUE, true );
			break;
		}
	}
	
	// 先頭の要素のセパレータを有効化する
	if ( customItems.length > 0 ) {
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
private function _menuSelectBuiltOn( e:ContextMenuEvent ):void {
	navigateToURL( new URLRequest( "http://progression.jp/built_on/" ), "http://progression.jp/built_on/" );
}
