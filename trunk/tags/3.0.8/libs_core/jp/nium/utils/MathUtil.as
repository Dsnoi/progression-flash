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
	 * <p>MathUtil クラスは、算術演算のためのユーティリティクラスです。
	 * MathUtil クラスを直接インスタンス化することはできません。
	 * new MathUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class MathUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function MathUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "MathUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>数値を指定された周期内に収めて返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param number
		 * 	<p>周期内に収めたい数値です。</p>
		 * 	<p></p>
		 * @param cycle
		 * 	<p>周期となる数値です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換後の数値です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( MathUtil.cycle( 8, 10 ) ); // 8
		 * trace( MathUtil.cycle( 10, 10 ) ); // 0
		 * trace( MathUtil.cycle( 24, 10 ) ); // 4
		 * </listing>
		 */
		public static function cycle( number:Number, cycle:Number ):Number {
			return ( number % cycle + cycle ) % cycle;
		}
		
		/*======================================================================*//**
		 * <p>範囲内に適合する値を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param number
		 * 	<p>範囲内に適合させたい数値です。</p>
		 * 	<p></p>
		 * @param min
		 * 	<p>範囲の最小値となる数値です。</p>
		 * 	<p></p>
		 * @param max
		 * 	<p>範囲の最大値となる数値です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換後の数値です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( MathUtil.range( 0, 10, 30 ) ); // 10
		 * trace( MathUtil.range( 20, 10, 30 ) ); // 20
		 * trace( MathUtil.range( 40, 10, 30 ) ); // 30
		 * </listing>
		 */
		public static function range( number:Number, min:Number, max:Number ):Number {
			// min の方が max よりも大きい場合に入れ替える
			if ( min > max ) {
				var tmp:Number = min;
				min = max;
				max = tmp;
			}
			
			return Math.max( min, Math.min( number, max ) );
		}
		
		/*======================================================================*//**
		 * <p>分母が 0 の場合に 0 となるパーセント値を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param numerator
		 * 	<p>分子となる数値です。</p>
		 * 	<p></p>
		 * @param denominator
		 * 	<p>分母となる数値です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換後の数値です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( MathUtil.percent( 100, 100 ) ); // 100
		 * trace( MathUtil.percent( 100, 200 ) ); // 50
		 * trace( MathUtil.percent( 200, 100 ) ); // 200
		 * </listing>
		 */
		public static function percent( numerator:Number, denominator:Number ):Number {
			if ( denominator == 0) { return 0; }
			
			return numerator / denominator * 100;
		}
		
		/*======================================================================*//**
		 * <p>数値が偶数かどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param number
		 * 	<p>テストしたい数値です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>偶数であれば true を、奇数であれば false を返します。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( MathUtil.even( 1 ) ); // false
		 * trace( MathUtil.even( 2 ) ); // true
		 * trace( MathUtil.even( 3 ) ); // false
		 * </listing>
		 */
		public static function even( number:Number ):Boolean {
			var h:Number = number / 2;
			return h == Math.ceil( h );
		}
	}
}









