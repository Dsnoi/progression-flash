/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.utils {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>MovieClipUtil クラスは、MovieClip 操作のためのユーティリティクラスです。
	 * MovieClipUtil クラスを直接インスタンス化することはできません。
	 * new MovieClipUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class MovieClipUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function MovieClipUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "MovieClipUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>MovieClip インスタンスの指定されたフレームラベルからフレーム番号を格納した配列を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param movie
		 * 	<p>フレーム番号を取得したい MovieClip インスタンスです。</p>
		 * 	<p></p>
		 * @param labelName
		 * 	<p>フレームラベルです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>フレーム番号です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function labelToFrames( movie:MovieClip, labelName:String ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			var l:int = labels.length;
			for ( var i:int = 0; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( labelName == frameLabel.name ) { list.push( frameLabel.frame ); }
			}
			
			return list;
		}
		
		/*======================================================================*//**
		 * <p>MovieClip インスタンスの指定されたフレーム番号からフレームラベルを格納した配列を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param movie
		 * 	<p>フレームラベルを取得したい MovieClip インスタンスです。</p>
		 * 	<p></p>
		 * @param labelName
		 * 	<p>フレーム番号です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>フレームラベルです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function frameToLabels( movie:MovieClip, frame:int ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			var l:int = labels.length;
			for ( var i:int = 0; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( frame == frameLabel.frame ) { list.push( frameLabel.name ); }
			}
			
			return list;
		}
		
		/*======================================================================*//**
		 * <p>指定されて 2 点間のフレーム差を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param movie
		 * 	<p>対象の MovieClip インスタンスです。</p>
		 * 	<p></p>
		 * @param frame1
		 * 	<p>最初のフレーム位置です。</p>
		 * 	<p></p>
		 * @param frame2
		 * 	<p>2 番目のフレーム位置です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>フレーム差です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginFrames( movie:MovieClip, frame1:*, frame2:* ):int {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			
			return Math.abs( e - s );
		}
		
		/*======================================================================*//**
		 * <p>指定されて 2 点間に再生ヘッドが存在しているかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param movie
		 * 	<p>対象の MovieClip インスタンスです。</p>
		 * 	<p></p>
		 * @param frame1
		 * 	<p>最初のフレーム位置です。</p>
		 * 	<p></p>
		 * @param frame2
		 * 	<p>2 番目のフレーム位置です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>存在していれば true 、なければ false です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function playheadWithinFrames( movie:MovieClip, frame1:*, frame2:* ):Boolean {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			var c:int = movie.currentFrame;
			
			// s の方が e よりも大きい場合に入れ替える
			if ( s > e ) {
				var temp:int = s;
				s = e;
				e = temp;
			}
			
			return ( s <= c && c <= e );
		}
		
		/*======================================================================*//**
		 * <p>指定したフレームが存在しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param movie
		 * 	<p>対象の MovieClip インスタンスです。</p>
		 * 	<p></p>
		 * @param labelName
		 * 	<p>存在を確認するフレームです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>存在していれば true 、なければ false です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function hasFrame( movie:MovieClip, frame:* ):Boolean {
			switch ( true ) {
				case frame is int		: { return ( frame <= movie.totalFrames ); }
				case frame is String	: {
					// FrameLabel を走査する
					var labels:Array = _getFrameLabels( movie );
					var l:int = labels.length;
					for ( var i:int = 0; i < l; i++ ) {
						// 参照を取得する
						var frameLabel:FrameLabel = FrameLabel( labels[i] );
						
						// 条件と一致すれば追加する
						if ( frame == frameLabel.name ) { return true; }
					}
				}
			}
			
			return false;
		}
		
		/*======================================================================*//**
		 * 対象の MovieClip インスタンスに存在するフレームラベルを格納した配列を返します。
		 */
		private static function _getFrameLabels( movie:MovieClip ):Array {
			var list:Array = [];
			
			// Scene を取得する
			var scenes:Array = movie.scenes;
			var l:int = scenes.length;
			for ( var i:int = 0; i < l; i++ ) {
				// 参照を取得する
				var scene:Scene = Scene( scenes[i] );
				
				// FrameLabel を取得する
				var ll:int = scene.labels.length;
				for ( var ii:int = 0; ii < ll; ii++ ) {
					list.push( scene.labels[ii] );
				}
			}
			
			return list;
		}
		
		/*======================================================================*//**
		 * 対象の MovieClip に存在する指定された位置のフレーム番号を返します。
		 */
		private static function _getFrame( movie:MovieClip, frame:* ):int {
			switch ( true ) {
				case frame is String	: { return labelToFrames( movie, frame )[0]; }
				case frame is int		: { return frame as int; }
			}
			
			return -1;
		}
		
		/*======================================================================*//**
		 * <p>指定された関数を 1 フレーム経過後に実行します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param scope
		 * 	<p>関数が実行される際のスコープです。</p>
		 * 	<p></p>
		 * @param callBack
		 * 	<p>実行したい関数です。</p>
		 * 	<p></p>
		 * @param args
		 * 	<p>関数の実行時の引数です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function doLater( scope:*, callBack:Function, ... args:Array ):void {
			var timer:Timer = new Timer( 1, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, function( e:TimerEvent ):void {
				// イベントリスナーを解除する
				Timer( e.target ).removeEventListener( e.type, arguments.callee );
				
				// コールバック関数を実行する
				callBack.apply( scope, args );
			} );
			timer.start();
		}
	}
}









