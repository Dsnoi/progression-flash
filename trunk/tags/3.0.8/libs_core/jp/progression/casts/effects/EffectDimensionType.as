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
	 * <p>EffectDimensionType クラスは、dimension プロパティの値を提供します。
	 * EffectDimensionType クラスを直接インスタンス化することはできません。
	 * new EffectDimensionType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EffectDimensionType {
		
		/*======================================================================*//**
		 * <p>エフェクトを垂直方向に適用するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const VERTICAL:int = 0;
		
		/*======================================================================*//**
		 * <p>エフェクトを水平方向に適用するよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const HORIZONTAL:int = 1;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function EffectDimensionType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectDimensionType" ) );
		}
	}
}









