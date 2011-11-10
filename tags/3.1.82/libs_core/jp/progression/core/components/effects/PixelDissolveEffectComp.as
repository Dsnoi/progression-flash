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
	import jp.progression.casts.effects.PixelDissolveEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "PixelDissolveEffect.png" )]
	/**
	 * @private
	 */
	public class PixelDissolveEffectComp extends EffectComp {
		
		/**
		 * <span lang="ja">水平軸に沿ったマスク矩形セクションの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="xSections", type="Number", defaultValue="10" )]
		public function get xSections():int { return PixelDissolveEffect( component ).xSections; }
		public function set xSections( value:int ):void { PixelDissolveEffect( component ).xSections = value; }
		
		/**
		 * <span lang="ja">垂直軸に沿ったマスク矩形セクションの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="ySections", type="Number", defaultValue="10" )]
		public function get ySections():int { return PixelDissolveEffect( component ).ySections; }
		public function set ySections( value:int ):void { PixelDissolveEffect( component ).ySections = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function PixelDissolveEffectComp() {
			// スーパークラスを初期化する
			super( new PixelDissolveEffect() );
		}
	}
}
