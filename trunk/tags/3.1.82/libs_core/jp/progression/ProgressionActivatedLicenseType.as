/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja"></span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class ProgressionActivatedLicenseType {
		
		/**
		 * <span lang="ja">ライセンスを「Progression 有償アプリケーションライセンス」として指定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @see jp.progression.Progression#activatedLicenseType
		 */
		public static const BUSINESS_APPLICATION_LICENSE:String = "businessApplicationLicense";
		
		/**
		 * <span lang="ja">ライセンスを「Progression 有償 Web ライセンス」として指定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @see jp.progression.Progression#activatedLicenseType
		 */
		public static const BUSINESS_WEB_LICENSE:String = "businessWebLicense";
		
		/**
		 * <span lang="ja">ライセンスを「Progression ライブラリライセンス」として指定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @see jp.progression.Progression#activatedLicenseType
		 */
		public static const BASIC_LIBRARY_LICENSE:String = "basicLibraryLicense";
		
		
		
		
		
		/**
		 * @private
		 */
		public function ProgressionActivatedLicenseType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ProgressionActivatedLicenseType" ) );
		}
	}
}
