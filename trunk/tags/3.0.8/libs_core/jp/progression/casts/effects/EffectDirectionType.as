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
	 * <p>EffectDirectionType クラスは、directionType プロパティの値を提供します。
	 * EffectDirectionType クラスを直接インスタンス化することはできません。
	 * new EffectDirectionType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EffectDirectionType {
		
		/*======================================================================*//**
		 * <p>エフェクトが開始方向のイージングをするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const IN:String = "in";
		
		/*======================================================================*//**
		 * <p>エフェクトが終了方向のイージングをするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const OUT:String = "out";
		
		/*======================================================================*//**
		 * <p>エフェクトが開始・終了方向のイージングをするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const IN_OUT:String = "inOut";
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function EffectDirectionType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectDirectionType" ) );
		}
	}
}









