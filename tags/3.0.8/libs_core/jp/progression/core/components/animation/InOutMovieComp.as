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
	import jp.progression.casts.animation.InOutMovie;
	import jp.progression.core.components.animation.AnimationComp;
	
	[IconFile( "InOutMovie.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class InOutMovieComp extends AnimationComp {
		
		[Inspectable( name="inStateFrames", type="Array", defaultValue="in,stop", verbose="1" )]
		/*======================================================================*//**
		 * <p>CastEvent.CAST_ADDED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get inStateFrames():Array { return InOutMovie( component ).inStateFrames; }
		public function set inStateFrames( value:Array ):void { InOutMovie( component ).inStateFrames = value; }
		
		[Inspectable( name="outStateFrames", type="Array", defaultValue="stop,out", verbose="1" )]
		/*======================================================================*//**
		 * <p>CastEvent.CAST_REMOVED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get outStateFrames():Array { return InOutMovie( component ).outStateFrames; }
		public function set outStateFrames( value:Array ):void { InOutMovie( component ).outStateFrames = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function InOutMovieComp() {
			// スーパークラスを初期化する
			super( new InOutMovie() );
		}
	}
}









