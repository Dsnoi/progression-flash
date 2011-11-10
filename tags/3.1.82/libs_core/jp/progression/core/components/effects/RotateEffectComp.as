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
package jp.progression.core.components.effects {
	import jp.progression.casts.effects.RotateEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "RotateEffect.png" )]
	/**
	 * @private
	 */
	public class RotateEffectComp extends EffectComp {
		
		/**
		 * <span lang="ja">対象を反時計回りに回転させるかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="ccw", type="Boolean", defaultValue="false" )]
		public function get ccw():Boolean { return RotateEffect( component ).ccw; }
		public function set ccw( value:Boolean ):void { RotateEffect( component ).ccw = value; }
		
		/**
		 * <span lang="ja">オブジェクトを回転する角度を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="degrees", type="Number", defaultValue="360" )]
		public function get degrees():int { return RotateEffect( component ).degrees; }
		public function set degrees( value:int ):void { RotateEffect( component ).degrees = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function RotateEffectComp() {
			// スーパークラスを初期化する
			super( new RotateEffect() );
		}
	}
}
