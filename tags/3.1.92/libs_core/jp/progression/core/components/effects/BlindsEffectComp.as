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
	import jp.progression.casts.effects.BlindsEffect;
	import jp.progression.casts.effects.EffectDimensionType;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "BlindsEffect.png" )]
	/**
	 * @private
	 */
	public class BlindsEffectComp extends EffectComp {
		
		/**
		 * <span lang="ja">Blinds 効果内のマスクストリップの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="numStrips", type="Number", defaultValue="10" )]
		public function get numStrips():int { return BlindsEffect( component ).numStrips; }
		public function set numStrips( value:int ):void { BlindsEffect( component ).numStrips = value; }
		
		/**
		 * <span lang="ja">マスクストリップが垂直か水平かを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="dimension", type="List", enumeration="vertical,horizontal", defaultValue="vertical" )]
		public function get dimension():String { return _dimension; }
		public function set dimension( value:String ):void {
			_dimension = value;
			
			BlindsEffect( component ).dimension = function():int {
				switch ( value ) {
					case "vertical"		: { return EffectDimensionType.VERTICAL; }
					case "horizontal"	: { return EffectDimensionType.HORIZONTAL; }
				}
				return -1;
			}.apply();
		}
		private var _dimension:String = "vertical";
		
		
		
		
		/**
		 * @private
		 */
		public function BlindsEffectComp() {
			// スーパークラスを初期化する
			super( new BlindsEffect() );
		}
	}
}
