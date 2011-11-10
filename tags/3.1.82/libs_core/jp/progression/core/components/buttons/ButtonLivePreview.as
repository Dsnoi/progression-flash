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
package jp.progression.core.components.buttons {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.components.CoreLivePreview;
	
	/**
	 * @private
	 */
	public class ButtonLivePreview extends CoreLivePreview {
		
		/**
		 * @private
		 */
		public function ButtonLivePreview() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreLivePreview ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ButtonLivePreview" ) ); }
		}
	}
}
