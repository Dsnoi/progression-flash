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
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>StageUtil クラスは、Stage 操作のためのユーティリティクラスです。
	 * StageUtil クラスを直接インスタンス化することはできません。
	 * new StageUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class StageUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function StageUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "StageUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>SWF ファイル書き出し時にドキュメントとして設定されたクラスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>ドキュメントを保存している stage インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>ドキュメントとして設定された表示オブジェクトです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * var documentRoot:Sprite = getDocument( stage );
		 * trace( documentRoot.root == documentRoot ); // true
		 * </listing>
		 */
		public static function getDocument( stage:Stage ):Sprite {
			var l:int = stage.numChildren;
			for ( var i:int = 0; i < l; i++ ) {
				var child:Sprite = Sprite( stage.getChildAt( i ) );
				
				if ( child.root == child ) { return child; }
			}
			
			return null;
		}
		
		/*======================================================================*//**
		 * <p>指定された URL ストリングを SWF ファイルの設置されているフォルダを基準とした URL に変換して返します。
		 * 絶対パスが指定された場合には、そのまま返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>基準となる SWF ファイルの stage インスタンスです。</p>
		 * 	<p></p>
		 * @param url
		 * 	<p>変換したい URL のストリング表現です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換された URL のストリング表現です。</p>
		 * 	<p></p>
		 */
		public static function toSWFBasePath( stage:Stage, url:String ):String {
			// stage が存在しなければ何も返さない
			if ( !stage ) { return ""; }
			
			// 絶対パスであればそのまま返す
			if ( new RegExp( "^[a-z][a-z0-9+-.]*://", "i" ).test( url ) ) { return url; }
			
			// SWF ファイルを基点としたパスに変換する
			var folder:Array = stage.loaderInfo.url.split( "/" );
			folder.splice( folder.length - 1, 1, url );
			url = folder.join( "/" );
			
			// パスに /./ が存在すれば結合する
			url = url.replace( "/./", "/" );
			
			// /A/B/../ なら /A/ に変換する
			var pattern:String = "/[^/]+/[^/]+/\\.\\./";
			while ( new RegExp( pattern, "g" ).test( url ) ) {
				url = url.replace( new RegExp( pattern, "g" ), function():String {
					return String( arguments[0] ).split( "/" ).slice( 0, 2 ).join( "/" ) + "/";
				} );
			}
			
			return url;
		}
		
		/*======================================================================*//**
		 * <p>ステージの左マージンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>マージンを取得したい stage インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>左マージンです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginLeft( stage:Stage ):Number {
			// ドキュメントクラスを取得する
			var root:Sprite = getDocument( stage );
			
			try {
				var rootWidth:Number = root.loaderInfo.width;
				var stgWidth:Number = stage.stageWidth;
			}
			catch ( e:Error ) {
				return 0;
			}
			
			switch ( stage.scaleMode ) {
				case StageScaleMode.NO_SCALE	: {
					switch ( stage.align ) {
						case StageAlign.BOTTOM_LEFT		:
						case StageAlign.LEFT			:
						case StageAlign.TOP_LEFT		: { return 0; }
						case StageAlign.BOTTOM_RIGHT	:
						case StageAlign.RIGHT			:
						case StageAlign.TOP_RIGHT		: { return ( stgWidth - rootWidth ); }
						default							: { return ( stgWidth - rootWidth ) / 2; }
					}
				}
				case StageScaleMode.EXACT_FIT	:
				case StageScaleMode.NO_BORDER	:
				case StageScaleMode.SHOW_ALL	: { return 0; }
			}
			
			return 0;
		}
		
		/*======================================================================*//**
		 * <p>ステージの上マージンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>マージンを取得したい stage インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>上マージンです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getMarginTop( stage:Stage ):Number {
			// ドキュメントクラスを取得する
			var root:Sprite = getDocument( stage );
			
			try {
				var rootHeight:Number = root.loaderInfo.height;
				var stgHeight:Number = stage.stageHeight;
			}
			catch ( e:Error ) {
				return -1;
			}
			
			switch ( stage.scaleMode ) {
				case StageScaleMode.NO_SCALE	: {
					switch ( stage.align ) {
						case StageAlign.BOTTOM_LEFT		:
						case StageAlign.LEFT			:
						case StageAlign.TOP_LEFT		: { return 0; }
						case StageAlign.BOTTOM_RIGHT	:
						case StageAlign.RIGHT			:
						case StageAlign.TOP_RIGHT		: { return ( stgHeight - rootHeight ); }
						default							: { return ( stgHeight - rootHeight ) / 2; }
					}
				}
				case StageScaleMode.EXACT_FIT	:
				case StageScaleMode.NO_BORDER	:
				case StageScaleMode.SHOW_ALL	: { return 0; }
			}
			
			return 0;
		}
	}
}









