/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.core.components.commands {
	import jp.progression.core.components.commands.CommandComp;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	[IconFile( "PositionCommand.png" )]
	/**
	 * @private
	 */
	public class PositionCommandComp extends CommandComp {
		
		/**
		 * <span lang="ja">対象の X 座標を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="positionX", type="Default", defaultValue="" )]
		public function get positionX():* { return _positionX; }
		public function set positionX( value:* ):void {
			var num:Number = parseFloat( value );
			if ( isNaN( num ) ) { return; }
			_positionX = num;
		}
		private var _positionX:*;
		
		/**
		 * <span lang="ja">対象の Y 座標を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="positionY", type="Default", defaultValue="" )]
		public function get positionY():* { return _positionY; }
		public function set positionY( value:* ):void {
			var num:Number = parseFloat( value );
			if ( isNaN( num ) ) { return; }
			_positionY = num;
		}
		private var _positionY:*;
		
		
		
		
		
		/**
		 * @private
		 */
		public function PositionCommandComp() {
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, 0, true );
		}
		
		
		
		
		
		/**
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
