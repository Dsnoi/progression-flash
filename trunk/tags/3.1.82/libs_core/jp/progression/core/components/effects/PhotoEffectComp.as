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
	import jp.progression.casts.effects.PhotoEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "PhotoEffect.png" )]
	/**
	 * @private
	 */
	public class PhotoEffectComp extends EffectComp {
		
		/**
		 * @private
		 */
		public function PhotoEffectComp() {
			// スーパークラスを初期化する
			super( new PhotoEffect() );
		}
	}
}
