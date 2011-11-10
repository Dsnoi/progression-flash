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
package jp.progression.core.managers {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * @private
	 */
	public class HistoryManagerType {
		
		/*======================================================================*//**
		 * <p>履歴管理をブラウザで行うよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BROWSER:String = "browser";
		
		/*======================================================================*//**
		 * <p>履歴管理を Flash Player で行うよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const FLASHPLAYER:String = "flashPlayer";
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function HistoryManagerType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "HistoryManagerType" ) );
		}
	}
}









