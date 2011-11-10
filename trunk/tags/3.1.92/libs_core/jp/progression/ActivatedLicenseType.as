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
package jp.progression {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja"></span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public final class ActivatedLicenseType {
		
		/**
		 * <span lang="ja">ライセンスを「Progression Library License Basic」として指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const PLL_BASIC:String = "PLL Basic";
		
		/**
		 * <span lang="ja">ライセンスを「Progression Library License Web」として指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const PLL_WEB:String = "PLL Web";
		
		/**
		 * <span lang="ja">ライセンスを「Progression Library License Application」として指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const PLL_APPLICATION:String = "PLL Application";
		
		/**
		 * <span lang="ja">ライセンスを「GPL」として指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const GPL:String = "GPL";
		
		
		
		
		
		/**
		 * @private
		 */
		public function ActivatedLicenseType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ActivatedLicenseType" ) );
		}
	}
}
