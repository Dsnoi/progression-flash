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
	import jp.progression.casts.effects.PixelDissolveEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "PixelDissolveEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class PixelDissolveEffectComp extends EffectComp {
		
		/*======================================================================*//**
		 * <p>水平軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="xSections", type="Number", defaultValue="10" )]
		public function get xSections():int { return PixelDissolveEffect( component ).xSections; }
		public function set xSections( value:int ):void { PixelDissolveEffect( component ).xSections = value; }
		
		/*======================================================================*//**
		 * <p>垂直軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="ySections", type="Number", defaultValue="10" )]
		public function get ySections():int { return PixelDissolveEffect( component ).ySections; }
		public function set ySections( value:int ):void { PixelDissolveEffect( component ).ySections = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function PixelDissolveEffectComp() {
			// スーパークラスを初期化する
			super( new PixelDissolveEffect() );
		}
	}
}









