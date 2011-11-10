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
package jp.progression.core.casts.animation {
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * @private
	 */
	public class AnimationBase extends CastMovieClip {
		
		/*======================================================================*//**
		 * @private
		 */
		protected function get target():MovieClip { return _target; }
		private var _target:MovieClip;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __target():MovieClip { return _target; }
		progression_internal function set __target( value:MovieClip ):void { _target = value || this; }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい AnimationBase インスタンスを作成します。</p>
		 * <p>Creates a new AnimationBase object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function AnimationBase( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CastMovieClip ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "AnimationBase" ) ); }
			
			// 初期化する
			_target = this;
			
			// 再生を停止する
			stop();
		}
	}
}









