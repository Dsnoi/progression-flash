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
package jp.progression.core.managers {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * @private
	 */
	public final class HistoryManagerType {
		
		/**
		 * <span lang="ja">履歴管理をブラウザで行うよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const BROWSER:String = "browser";
		
		/**
		 * <span lang="ja">履歴管理を Flash Player で行うよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const FLASHPLAYER:String = "flashPlayer";
		
		
		
		
		
		/**
		 * @private
		 */
		public function HistoryManagerType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "HistoryManagerType" ) );
		}
	}
}
