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
package jp.progression.core.components.animation {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.components.CoreLivePreview;
	
	/*======================================================================*//**
	 * @private
	 */
	public class AnimationLivePreview extends CoreLivePreview {
		
		/*======================================================================*//**
		 * @private
		 */
		public function AnimationLivePreview() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreLivePreview ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "AnimationLivePreview" ) ); }
		}
	}
}









