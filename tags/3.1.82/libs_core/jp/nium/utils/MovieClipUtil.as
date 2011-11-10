/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.utils {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">MovieClipUtil クラスは、MovieClip 操作のためのユーティリティクラスです。
	 * MovieClipUtil クラスを直接インスタンス化することはできません。
	 * new MovieClipUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The MovieClipUtil class is an utility class for MovieClip operation.
	 * MovieClipUtil class can not instanciate directly.
	 * When call the new MovieClipUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class MovieClipUtil {
		
		/**
		 * @private
		 */
		public function MovieClipUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "MovieClipUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">MovieClip インスタンスの指定されたフレームラベルからフレーム番号を格納した配列を取得します。</span>
		 * <span lang="en">Get the array which contains the frame number that specified by frame label of the MovieClip instance.</span>
		 * 
		 * @param movie
		 * <span lang="ja">フレーム番号を取得したい MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to get the frame number.</span>
		 * @param labelName
		 * <span lang="ja">フレームラベルです。</span>
		 * <span lang="en">The frame label.</span>
		 * @return
		 * <span lang="ja">フレーム番号です。</span>
		 * <span lang="en">The frame number.</span>
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
		
		/**
		 * <span lang="ja">MovieClip インスタンスの指定されたフレーム番号からフレームラベルを格納した配列を取得します。</span>
		 * <span lang="en">Get the array which contains the frame label that specified by frame number of the MovieClip instance.</span>
		 * 
		 * @param movie
		 * <span lang="ja">フレームラベルを取得したい MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to get the frame number.</span>
		 * @param labelName
		 * <span lang="ja">フレーム番号です。</span>
		 * <span lang="en">The frame number.</span>
		 * @return
		 * <span lang="ja">フレームラベルです。</span>
		 * <span lang="en">The frame label.</span>
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
		
		/**
		 * <span lang="ja">指定された 2 点間のフレーム差を取得します。</span>
		 * <span lang="en">Get the frame difference of specified two points.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param frame1
		 * <span lang="ja">最初のフレーム位置です。</span>
		 * <span lang="en">The position of the first frame.</span>
		 * @param frame2
		 * <span lang="ja">2 番目のフレーム位置です。</span>
		 * <span lang="en">The position of the second frame.<.p>
		 * @return
		 * <span lang="ja">フレーム差です。</span>
		 * <span lang="en">The frame difference.</span>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginFrames( movie:MovieClip, frame1:*, frame2:* ):int {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			
			return Math.abs( e - s );
		}
		
		/**
		 * <span lang="ja">指定されて 2 点間に再生ヘッドが存在しているかどうかを取得します。</span>
		 * <span lang="en">Returns if the playback head exists between the specified two points.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param frame1
		 * <span lang="ja">最初のフレーム位置です。</span>
		 * <span lang="en">The position of the first frame.</span>
		 * @param frame2
		 * <span lang="ja">2 番目のフレーム位置です。</span>
		 * <span lang="en">The position of the second frame.<.p>
		 * @return
		 * <span lang="ja">存在していれば true 、なければ false です。</span>
		 * <span lang="en">Returns true if exists, otherwise return false.</span>
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
		
		/**
		 * <span lang="ja">指定したフレームが存在しているかどうかを返します。</span>
		 * <span lang="en">Returns if the specified frame exists.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param labelName
		 * <span lang="ja">存在を確認するフレームです。</span>
		 * <span lang="en">The frame to check if exists.</span>
		 * @return
		 * <span lang="ja">存在していれば true 、なければ false です。</span>
		 * <span lang="en">Returns true if exists, otherwise return false.</span>
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
		
		/**
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
		
		/**
		 * 対象の MovieClip に存在する指定された位置のフレーム番号を返します。
		 */
		private static function _getFrame( movie:MovieClip, frame:* ):int {
			switch ( true ) {
				case frame is String	: { return labelToFrames( movie, frame )[0]; }
				case frame is int		: { return frame as int; }
			}
			
			return -1;
		}
		
		/**
		 * <span lang="ja">指定された関数を 1 フレーム経過後に実行します。</span>
		 * <span lang="en">Execute the specified function, 1 frame later.</span>
		 * 
		 * @param scope
		 * <span lang="ja">関数が実行される際のスコープです。</span>
		 * <span lang="en">The scope when the function executes.</span>
		 * @param callBack
		 * <span lang="ja">実行したい関数です。</span>
		 * <span lang="en">The function to execute.</span>
		 * @param args
		 * <span lang="ja">関数の実行時の引数です。</span>
		 * <span lang="en">The argument of the function when executes.</span>
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
