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
	import jp.progression.casts.effects.FadeEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "FadeEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class FadeEffectComp extends EffectComp {
		
		/*======================================================================*//**
		 * @private
		 */
		public function FadeEffectComp() {
			// スーパークラスを初期化する
			super( new FadeEffect() );
		}
	}
}









