/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core.components.effects {
	import jp.progression.casts.effects.FadeEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "FadeEffect.png" )]
	/**
	 * @private
	 */
	public class FadeEffectComp extends EffectComp {
		
		/**
		 * @private
		 */
		public function FadeEffectComp() {
			// スーパークラスを初期化する
			super( new FadeEffect() );
		}
	}
}
