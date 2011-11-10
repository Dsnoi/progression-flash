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
package jp.nium.display {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">ExImageLoaderAlign クラスは、ExImageLoader.align プロパティの値を提供します。
	 * ExImageLoaderAlign クラスを直接インスタンス化することはできません。
	 * new ExImageLoaderAlign() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">ExImageLoaderAlign class provides ExIMageLoader.align property.
	 * ExImageLoaderAlign class can not instanciate directry.
	 * ArgumentError exception will be thrown when call new ExImageLoaderAlign() constructor.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public final class ExImageLoaderAlign {
		
		/**
		 * <span lang="ja">イメージを左上の隅に揃えるよう指定します。</span>
		 * <span lang="en">Set the image to align to top-left.</span>
		 */
		public static const TOP_LEFT:String = "topLeft";
		
		/**
		 * <span lang="ja">ステージを上揃えにするよう指定します。</span>
		 * <span lang="en">Set the stage to align to top.</span>
		 */
		public static const TOP:String = "top";
		
		/**
		 * <span lang="ja">イメージを右上の隅に揃えるよう指定します。</span>
		 * <span lang="en">Set the image to align to top-right.</span>
		 */
		public static const TOP_RIGHT:String = "topRight";
		
		/**
		 * <span lang="ja">イメージを左揃えにするよう指定します。</span>
		 * <span lang="en">Set the image to align to left.</span>
		 */
		public static const LEFT:String = "left ";
		
		/**
		 * <span lang="ja">イメージを中央に揃えるよう指定します。</span>
		 * <span lang="en">Set the image to align to center.</span>
		 */
		public static const CENTER:String = "center";
		
		/**
		 * <span lang="ja">イメージを右揃えにするよう指定します。</span>
		 * <span lang="en">Set the image to align to right.</span>
		 */
		public static const RIGHT:String = "right";
		
		/**
		 * <span lang="ja">イメージを左下の隅に揃えるよう指定します。</span>
		 * <span lang="en">Set the image to align to bottom-left.</span>
		 */
		public static const BOTTOM_LEFT:String = "bottomLeft ";
		
		/**
		 * <span lang="ja">イメージを下揃えにするよう指定します。</span>
		 * <span lang="en">Set the image to align to bottom.</span>
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * <span lang="ja">イメージを右下の隅に揃えるよう指定します。</span>
		 * <span lang="en">Set the image to align to bottom-right.</span>
		 */
		public static const BOTTOM_RIGHT:String = "bottomRight";
		
		
		
		
		
		/**
		 * @private
		 */
		public function ExImageLoaderAlign() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ExImageLoaderAlign" ) );
		}
	}
}
