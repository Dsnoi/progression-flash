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
package jp.progression.core.components.commands {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.commands.CommandComp;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	[IconFile( "PositionCommand.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class PositionCommandComp extends CommandComp {
		
		/*======================================================================*//**
		 * <p>対象の X 座標を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="positionX", type="Default", defaultValue="" )]
		public function get positionX():* { return _positionX; }
		public function set positionX( value:* ):void {
			var num:Number = parseFloat( value );
			if ( isNaN( num ) ) { return; }
			_positionX = num;
		}
		private var _positionX:*;
		
		/*======================================================================*//**
		 * <p>対象の Y 座標を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="positionY", type="Default", defaultValue="" )]
		public function get positionY():* { return _positionY; }
		public function set positionY( value:* ):void {
			var num:Number = parseFloat( value );
			if ( isNaN( num ) ) { return; }
			_positionY = num;
		}
		private var _positionY:*;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function PositionCommandComp() {
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, 0, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _componentAdded( e:ComponentEvent ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded );
			
			// 値を反映する
			target.x = ( _positionX is Number ) ? _positionX : target.x;
			target.y = ( _positionY is Number ) ? _positionY : target.y;
		}
	}
}










