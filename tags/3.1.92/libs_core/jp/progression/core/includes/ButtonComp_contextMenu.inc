import flash.ui.ContextMenu;

private function _initContextMenu():void {
	// コンテクストメニューを設定する
	if ( _useContextMenu ) {
		target.contextMenu = new ContextMenu();
		target.contextMenu.hideBuiltInItems();
		
		// CastButtonContextMenu を作成する
		_uiContextMenu = CastButtonContextMenu.progression_internal::__createInstance( _component, target.contextMenu = new ContextMenu() );
	}
	else {
	}
}

private function _disposeContextMenu():void {
	target.contextMenu = null;
	_uiContextMenu = null;
}
