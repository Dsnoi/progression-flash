import flash.ui.ContextMenu;
public override function get contextMenu():ContextMenu { return null; }
public override function set contextMenu( value:ContextMenu ):void { }
private function _initContextMenu():void {
	var contextMenu:ContextMenu = new ContextMenu();
	contextMenu.hideBuiltInItems();
	super.contextMenu = contextMenu;
}
