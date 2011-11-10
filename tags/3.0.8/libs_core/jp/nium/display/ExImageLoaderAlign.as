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
package jp.nium.display {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>ExImageLoaderAlign クラスは、ExImageLoader.align プロパティの値を提供します。
	 * ExImageLoaderAlign クラスを直接インスタンス化することはできません。
	 * new ExImageLoaderAlign() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExImageLoaderAlign {
		
		/*======================================================================*//**
		 * <p>イメージを左上の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_LEFT:String = "topLeft";
		
		/*======================================================================*//**
		 * <p>ステージを上揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP:String = "top";
		
		/*======================================================================*//**
		 * <p>イメージを右上の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TOP_RIGHT:String = "topRight";
		
		/*======================================================================*//**
		 * <p>イメージを左揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const LEFT:String = "left ";
		
		/*======================================================================*//**
		 * <p>イメージを中央に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CENTER:String = "center";
		
		/*======================================================================*//**
		 * <p>イメージを右揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RIGHT:String = "right";
		
		/*======================================================================*//**
		 * <p>イメージを左下の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_LEFT:String = "bottomLeft ";
		
		/*======================================================================*//**
		 * <p>イメージを下揃えにするよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM:String = "bottom";
		
		/*======================================================================*//**
		 * <p>イメージを右下の隅に揃えるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BOTTOM_RIGHT:String = "bottomRight";
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function ExImageLoaderAlign() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ExImageLoaderAlign" ) );
		}
	}
}









