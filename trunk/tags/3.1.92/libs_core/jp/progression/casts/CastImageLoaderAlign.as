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
package jp.progression.casts {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExImageLoaderAlign;
	
	/**
	 * <span lang="ja">CastImageLoaderAlign クラスは、CastImageLoader.align プロパティの値を提供します。
	 * CastImageLoaderAlign クラスを直接インスタンス化することはできません。
	 * new CastImageLoaderAlign() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public final class CastImageLoaderAlign {
		
		/**
		 * <span lang="ja">イメージを左上の隅に揃えるよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const TOP_LEFT:String = ExImageLoaderAlign.TOP_LEFT;
		
		/**
		 * <span lang="ja">ステージを上揃えにするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const TOP:String = ExImageLoaderAlign.TOP;
		
		/**
		 * <span lang="ja">イメージを右上の隅に揃えるよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const TOP_RIGHT:String = ExImageLoaderAlign.TOP_RIGHT;
		
		/**
		 * <span lang="ja">イメージを左揃えにするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const LEFT:String = ExImageLoaderAlign.LEFT;
		
		/**
		 * <span lang="ja">イメージを中央に揃えるよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const CENTER:String = ExImageLoaderAlign.CENTER;
		
		/**
		 * <span lang="ja">イメージを右揃えにするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const RIGHT:String = ExImageLoaderAlign.RIGHT;
		
		/**
		 * <span lang="ja">イメージを左下の隅に揃えるよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const BOTTOM_LEFT:String = ExImageLoaderAlign.BOTTOM_LEFT;
		
		/**
		 * <span lang="ja">イメージを下揃えにするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const BOTTOM:String = ExImageLoaderAlign.BOTTOM;
		
		/**
		 * <span lang="ja">イメージを右下の隅に揃えるよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const BOTTOM_RIGHT:String = ExImageLoaderAlign.BOTTOM_RIGHT;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CastImageLoaderAlign() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CastImageLoaderAlign" ) );
		}
	}
}
