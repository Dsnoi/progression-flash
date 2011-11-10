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
package jp.progression.core.components.animation {
	import jp.progression.casts.animation.InOutMovie;
	import jp.progression.core.components.animation.AnimationComp;
	
	[IconFile( "InOutMovie.png" )]
	/**
	 * @private
	 */
	public class InOutMovieComp extends AnimationComp {
		
		[Inspectable( name="inStateFrames", type="Array", defaultValue="in,stop", verbose="1" )]
		/**
		 * <span lang="ja">CastEvent.CAST_ADDED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get inStateFrames():Array { return InOutMovie( component ).inStateFrames; }
		public function set inStateFrames( value:Array ):void { InOutMovie( component ).inStateFrames = value; }
		
		[Inspectable( name="outStateFrames", type="Array", defaultValue="stop,out", verbose="1" )]
		/**
		 * <span lang="ja">CastEvent.CAST_REMOVED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get outStateFrames():Array { return InOutMovie( component ).outStateFrames; }
		public function set outStateFrames( value:Array ):void { InOutMovie( component ).outStateFrames = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function InOutMovieComp() {
			// スーパークラスを初期化する
			super( new InOutMovie() );
		}
	}
}
