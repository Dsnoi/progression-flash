import flash.ui.ContextMenu;
public override function get contextMenu():ContextMenu { return null; }
public override function set contextMenu( value:ContextMenu ):void { }
private function _initContextMenu():void {
	_uiContextMenu = CastObjectContextMenu.progression_internal::__createInstance( this, super.contextMenu = new ContextMenu() );
}
