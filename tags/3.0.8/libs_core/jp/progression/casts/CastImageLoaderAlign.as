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
package jp.progression.casts {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExImageLoaderAlign;
	
	/*======================================================================*//**
	 * <p>CastImageLoaderAlign クラスは、CastImageLoader.align プロパティの値を提供します。
	 * CastImageLoaderAlign クラスを直接インスタンス化することはできません。
	 * new CastImageLoaderAlign() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastImageLoaderAlign {
		
		/*======================================================================*//**
		 * <p>イメージを左上の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_LEFT:String = ExImageLoaderAlign.TOP_LEFT;
		
		/*======================================================================*//**
		 * <p>ステージを上揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP:String = ExImageLoaderAlign.TOP;
		
		/*======================================================================*//**
		 * <p>イメージを右上の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_RIGHT:String = ExImageLoaderAlign.TOP_RIGHT;
		
		/*======================================================================*//**
		 * <p>イメージを左揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const LEFT:String = ExImageLoaderAlign.LEFT;
		
		/*======================================================================*//**
		 * <p>イメージを中央に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CENTER:String = ExImageLoaderAlign.CENTER;
		
		/*======================================================================*//**
		 * <p>イメージを右揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RIGHT:String = ExImageLoaderAlign.RIGHT;
		
		/*======================================================================*//**
		 * <p>イメージを左下の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_LEFT:String = ExImageLoaderAlign.BOTTOM_LEFT;
		
		/*======================================================================*//**
		 * <p>イメージを下揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM:String = ExImageLoaderAlign.BOTTOM;
		
		/*======================================================================*//**
		 * <p>イメージを右下の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_RIGHT:String = ExImageLoaderAlign.BOTTOM_RIGHT;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function CastImageLoaderAlign() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CastImageLoaderAlign" ) );
		}
	}
}









