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
package jp.progression.core.components.effects {
	import jp.progression.casts.effects.RotateEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "RotateEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class RotateEffectComp extends EffectComp {
		
		/*======================================================================*//**
		 * <p>対象を反時計回りに回転させるかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="ccw", type="Boolean", defaultValue="false" )]
		public function get ccw():Boolean { return RotateEffect( component ).ccw; }
		public function set ccw( value:Boolean ):void { RotateEffect( component ).ccw = value; }
		
		/*======================================================================*//**
		 * <p>オブジェクトを回転する角度を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="degrees", type="Number", defaultValue="360" )]
		public function get degrees():int { return RotateEffect( component ).degrees; }
		public function set degrees( value:int ):void { RotateEffect( component ).degrees = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function RotateEffectComp() {
			// スーパークラスを初期化する
			super( new RotateEffect() );
		}
	}
}









