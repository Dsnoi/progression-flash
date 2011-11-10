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
package jp.progression.casts.effects {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>EffectStartPointType クラスは、startPoint プロパティの値を提供します。
	 * EffectStartPointType クラスを直接インスタンス化することはできません。
	 * new EffectStartPointType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EffectStartPointType {
		
		/*======================================================================*//**
		 * <p>エフェクトを左上の隅から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_LEFT:int = 1;
		
		/*======================================================================*//**
		 * <p>エフェクトを上から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP:int = 2;
		
		/*======================================================================*//**
		 * <p>エフェクトを右上の隅から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_RIGHT:int = 3;
		
		/*======================================================================*//**
		 * <p>エフェクトを左から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const LEFT:int = 4;
		
		/*======================================================================*//**
		 * <p>エフェクトを中央から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CENTER:int = 5;
		
		/*======================================================================*//**
		 * <p>エフェクトを右から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RIGHT:int = 6;
		
		/*======================================================================*//**
		 * <p>エフェクトを左下の隅から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_LEFT:int = 7;
		
		/*======================================================================*//**
		 * <p>エフェクトを下から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM:int = 8;
		
		/*======================================================================*//**
		 * <p>エフェクトを右下の隅から開始するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_RIGHT:int = 9;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function EffectStartPointType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectStartPointType" ) );
		}
	}
}









