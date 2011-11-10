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
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>NumberUtil クラスは、数値操作のためのユーティリティクラスです。
	 * NumberUtil クラスを直接インスタンス化することはできません。
	 * new NumberUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class NumberUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function NumberUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "NumberUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>数値を 1000 桁ごとにカンマをつけて返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param number
		 * 	<p>変換したい数値です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換後の数値です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( NumberUtil.format( 100 ) ); // 100
		 * trace( NumberUtil.format( 10000 ) ); // 10,000
		 * trace( NumberUtil.format( 1000000 ) ); // 1,000,000
		 * </listing>
		 */
		public static function format( number:Number ):String {
			var words:Array = String( number ).split( "" ).reverse();
			var l:int = words.length;
			for ( var i:int = 3; i < l; i += 3 ) {
				if ( words[i] ) {
					words.splice( i, 0, "," );
					i++;
					l++;
				}
			}
			return words.reverse().join( "" );
		}
		
		/*======================================================================*//**
		 * <p>数値の桁数を 0 で揃えて返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param number
		 * 	<p>変換したい数値です。</p>
		 * 	<p></p>
		 * @param figure
		 * 	<p>揃えたい桁数です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換後の数値です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( NumberUtil.digit( 1, 3 ) ); // 001
		 * trace( NumberUtil.digit( 100, 3 ) ); // 100
		 * trace( NumberUtil.digit( 10000, 3 ) ); // 000
		 * </listing>
		 */
		public static function digit( number:Number, figure:int ):String {
			var str:String = String( number );
			for ( var i:int = 0; i < figure; i++ ) {
				str = "0" + str;
			}
			return str.substr( str.length - figure, str.length );
		}
	}
}









