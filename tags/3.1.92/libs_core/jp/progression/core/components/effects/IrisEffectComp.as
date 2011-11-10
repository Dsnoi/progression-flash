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
	import jp.progression.casts.effects.EffectStartPointType;
	import jp.progression.casts.effects.IrisEffect;
	import jp.progression.core.components.effects.EffectComp;
	
	[IconFile( "IrisEffect.png" )]
	/**
	 * @private
	 */
	public class IrisEffectComp extends EffectComp {
		
		/**
		 * <span lang="ja">エフェクトの開始位置を取得または設定します。</span>
		 * <span lang="en"></span>
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
		
		/**
		 * <span lang="ja">マスクシェイプを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="shape", type="List", enumeration="CIRCLE,SQUARE", defaultValue="SQUARE" )]
		public function get shape():String { return IrisEffect( component ).shape; }
		public function set shape( value:String ):void { IrisEffect( component ).shape = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function IrisEffectComp() {
			// スーパークラスを初期化する
			super( new IrisEffect() );
		}
	}
}
