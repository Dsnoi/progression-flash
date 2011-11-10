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
	import jp.progression.casts.effects.EffectDimensionType;
	import jp.progression.casts.effects.SqueezeEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "SqueezeEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class SqueezeEffectComp extends EffectComp {
		
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
			
			SqueezeEffect( component ).dimension = function():int {
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
		public function SqueezeEffectComp() {
			// スーパークラスを初期化する
			super( new SqueezeEffect() );
		}
	}
}









