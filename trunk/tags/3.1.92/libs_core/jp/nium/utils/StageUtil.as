/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.utils {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">StageUtil クラスは、Stage 操作のためのユーティリティクラスです。
	 * StageUtil クラスを直接インスタンス化することはできません。
	 * new StageUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The StageUtil class is an utility class for stage operation.
	 * StageUtil class can not instanciate directly.
	 * When call the new StageUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class StageUtil {
		
		/**
		 * @private
		 */
		public function StageUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "StageUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">SWF ファイル書き出し時にドキュメントとして設定されたクラスを返します。</span>
		 * <span lang="en">Returns the class that set as document when writing the SWF file.</span>
		 * 
		 * @param stage
		 * <span lang="ja">ドキュメントを保存している stage インスタンスです。</span>
		 * <span lang="en">The stage instance which save the document.</span>
		 * @return
		 * <span lang="ja">ドキュメントとして設定された表示オブジェクトです。</span>
		 * <span lang="en">The display object that set as document.</span>
		 * 
		 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">指定された URL ストリングを SWF ファイルの設置されているフォルダを基準とした URL に変換して返します。
		 * 絶対パスが指定された場合には、そのまま返します。</span>
		 * <span lang="en">Translate the specified URL string to the URL based on the folder where the SWF file is setting.
		 * In case it specified the absolute path, it will return as is.</span>
		 * 
		 * @param stage
		 * <span lang="ja">基準となる SWF ファイルの stage インスタンスです。</span>
		 * <span lang="en">The Stage instance of the SWF file to be the baseine.</span>
		 * @param url
		 * <span lang="ja">変換したい URL のストリング表現です。</span>
		 * <span lang="en">The URL string representation to translate.</span>
		 * @return
		 * <span lang="ja">変換された URL のストリング表現です。</span>
		 * <span lang="en">The URL string representation which translated.</span>
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
		
		/**
		 * <span lang="ja">ステージの左マージンを取得します。</span>
		 * <span lang="en">Get the left margin of the stage.</span>
		 * 
		 * @param stage
		 * <span lang="ja">マージンを取得したい stage インスタンスです。</span>
		 * <span lang="en">The stage instance to get the margin.</span>
		 * @return
		 * <span lang="ja">左マージンです。</span>
		 * <span lang="en">The left margin.</span>
		 * 
		 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">ステージの上マージンを取得します。</span>
		 * <span lang="en">Get the top margin of the stage.</span>
		 * 
		 * @param stage
		 * <span lang="ja">マージンを取得したい stage インスタンスです。</span>
		 * <span lang="en">The stage instance to get the margin.</span>
		 * @return
		 * <span lang="ja">上マージンです。</span>
		 * <span lang="en">The top margin.</span>
		 * 
		 * @example <listing version="3.0">
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
						case StageAlign.TOP				:
						case StageAlign.TOP_LEFT		:
						case StageAlign.TOP_RIGHT		: { return 0; }
						case StageAlign.BOTTOM			:
						case StageAlign.BOTTOM_LEFT		:
						case StageAlign.BOTTOM_RIGHT	: { return ( stgHeight - rootHeight ); }
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
