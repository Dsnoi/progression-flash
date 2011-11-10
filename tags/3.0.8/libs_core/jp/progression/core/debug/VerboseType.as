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
package jp.progression.core.debug {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>VerboseType クラスは、Verbose.type プロパティの値を提供します。
	 * VerboseType クラスを直接インスタンス化することはできません。
	 * new VerboseType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class VerboseType {
		
		/*======================================================================*//**
		 * <p>ログの出力を行わないよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const NONE:String = "none";
		
		/*======================================================================*//**
		 * <p>ログの出力を基本的な項目のみ行うよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SIMPLE:String = "simple";
		
		/*======================================================================*//**
		 * <p>ログの出力を全ての項目に対して行うよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const FULL:String = "full";
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function VerboseType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "VerboseType" ) );
		}
	}
}









