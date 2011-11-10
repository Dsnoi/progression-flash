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
	import jp.progression.casts.effects.BlindsEffect;
	import jp.progression.casts.effects.EffectDimensionType;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "BlindsEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class BlindsEffectComp extends EffectComp {
		
		/*======================================================================*//**
		 * <p>Blinds 効果内のマスクストリップの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="numStrips", type="Number", defaultValue="10" )]
		public function get numStrips():int { return BlindsEffect( component ).numStrips; }
		public function set numStrips( value:int ):void { BlindsEffect( component ).numStrips = value; }
		
		/*======================================================================*//**
		 * <p>マスクストリップが垂直か水平かを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function BlindsEffectComp() {
			// スーパークラスを初期化する
			super( new BlindsEffect() );
		}
	}
}









