import flash.display.NativeMenu;
import flash.ui.ContextMenu;
public override function get contextMenu():NativeMenu { return super.contextMenu; }
public override function set contextMenu( value:NativeMenu ):void { super.contextMenu = value; }
private function _initContextMenu():void {
	_uiContextMenu = CastButtonContextMenu.progression_internal::__createInstance( this, super.contextMenu = new ContextMenu() );
}
