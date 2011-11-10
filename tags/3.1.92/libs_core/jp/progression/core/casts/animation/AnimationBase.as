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
package jp.progression.core.casts.animation {
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public class AnimationBase extends CastMovieClip {
		
		/**
		 * @private
		 */
		protected function get target():MovieClip { return _target; }
		private var _target:MovieClip;
		
		/**
		 * @private
		 */
		progression_internal function get __target():MovieClip { return _target; }
		progression_internal function set __target( value:MovieClip ):void { _target = value || this; }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい AnimationBase インスタンスを作成します。</span>
		 * <span lang="en">Creates a new AnimationBase object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
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
