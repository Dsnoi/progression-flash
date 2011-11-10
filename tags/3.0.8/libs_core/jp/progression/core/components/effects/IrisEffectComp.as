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
	import jp.progression.casts.effects.EffectStartPointType;
	import jp.progression.casts.effects.IrisEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "IrisEffect.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class IrisEffectComp extends EffectComp {
		
		/*======================================================================*//**
		 * <p>エフェクトの開始位置を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="startPoint", type="List", enumeration="topLeft,top,topRight,left,center,right,bottomLeft,bottom,bottomRight", defaultValue="center" )]
		public function get startPoint():String { return _startPoint; }
		public function set startPoint( value:String ):void {
			_startPoint = value;
			
			IrisEffect( component ).startPoint = function():int {
				switch ( value ) {
					case "topLeft"		: { return EffectStartPointType.TOP_LEFT; }
					case "top"			: { return EffectStartPointType.TOP; }
					case "topRight"		: { return EffectStartPointType.TOP_RIGHT; }
					case "left"			: { return EffectStartPointType.LEFT; }
					case "center"		: { return EffectStartPointType.CENTER; }
					case "right"		: { return EffectStartPointType.RIGHT; }
					case "bottomLeft"	: { return EffectStartPointType.BOTTOM_LEFT; }
					case "bottom"		: { return EffectStartPointType.BOTTOM; }
					case "bottomRight"	: { return EffectStartPointType.BOTTOM_RIGHT; }
				}
				return -1;
			}.apply();
		}
		private var _startPoint:String = "center";
		
		/*======================================================================*//**
		 * <p>マスクシェイプを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="shape", type="List", enumeration="CIRCLE,SQUARE", defaultValue="SQUARE" )]
		public function get shape():String { return IrisEffect( component ).shape; }
		public function set shape( value:String ):void { IrisEffect( component ).shape = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function IrisEffectComp() {
			// スーパークラスを初期化する
			super( new IrisEffect() );
		}
	}
}









