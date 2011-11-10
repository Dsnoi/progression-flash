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
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">NumberUtil クラスは、数値操作のためのユーティリティクラスです。
	 * NumberUtil クラスを直接インスタンス化することはできません。
	 * new NumberUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The NumberUtil class is an utility class for numeric operation.
	 * NumbertUtil class can not instanciate directly.
	 * When call the new NumberUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class NumberUtil {
		
		/**
		 * @private
		 */
		public function NumberUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "NumberUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">数値を 1000 桁ごとにカンマをつけて返します。</span>
		 * <span lang="en">Returns the numerical value applying the comma every 1000 digits.</span>
		 * 
		 * @param number
		 * <span lang="ja">変換したい数値です。</span>
		 * <span lang="en">The numerical value to convert.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The converted numerical value.</span>
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
		
		/**
		 * <span lang="ja">数値の桁数を 0 で揃えて返します。</span>
		 * <span lang="en">Arrange the digit of numerical value by 0.</span>
		 * 
		 * @param number
		 * <span lang="ja">変換したい数値です。</span>
		 * <span lang="en">The numerical value to convert.</span>
		 * @param figure
		 * <span lang="ja">揃えたい桁数です。</span>
		 * <span lang="en">The number of digit to arrange.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The converted numerical value.</span>
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
