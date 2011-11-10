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
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">MathUtil クラスは、算術演算のためのユーティリティクラスです。
	 * MathUtil クラスを直接インスタンス化することはできません。
	 * new MathUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The MathUtil class is an utility class for arithmetic operation.
	 * MathUtil class can not instanciate directly.
	 * When call the new MathUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class MathUtil {
		
		/**
		 * @private
		 */
		public function MathUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "MathUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">数値を指定された周期内に収めて返します。</span>
		 * <span lang="en">Returns the value of number put in the specified cycle.</span>
		 * 
		 * @param number
		 * <span lang="ja">周期内に収めたい数値です。</span>
		 * <span lang="en">The value which want to put in the cycle.</span>
		 * @param cycle
		 * <span lang="ja">周期となる数値です。</span>
		 * <span lang="en">The cycle value.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The translated value.</span>
		 * 
		 * @example <listing version="3.0">
		 * trace( MathUtil.cycle( 8, 10 ) ); // 8
		 * trace( MathUtil.cycle( 10, 10 ) ); // 0
		 * trace( MathUtil.cycle( 24, 10 ) ); // 4
		 * </listing>
		 */
		public static function cycle( number:Number, cycle:Number ):Number {
			return ( number % cycle + cycle ) % cycle;
		}
		
		/**
		 * <span lang="ja">範囲内に適合する値を返します。</span>
		 * <span lang="en">Returns the value suited within the range.</span>
		 * 
		 * @param number
		 * <span lang="ja">範囲内に適合させたい数値です。</span>
		 * <span lang="en">The number which wanted to suit within the range.</span>
		 * @param min
		 * <span lang="ja">範囲の最小値となる数値です。</span>
		 * <span lang="en">The mininum value of the range.</span>
		 * @param max
		 * <span lang="ja">範囲の最大値となる数値です。</span>
		 * <span lang="en">The maximum value of the range.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The translated value.</span>
		 * 
		 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">分母が 0 の場合に 0 となるパーセント値を返します。</span>
		 * <span lang="en">Returns the percent value (return 0 if the denominator is 0).</span>
		 * 
		 * @param numerator
		 * <span lang="ja">分子となる数値です。</span>
		 * <span lang="en">The numerator value.</span>
		 * @param denominator
		 * <span lang="ja">分母となる数値です。</span>
		 * <span lang="en">The denominator value.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The translated value.</span>
		 * 
		 * @example <listing version="3.0">
		 * trace( MathUtil.percent( 100, 100 ) ); // 100
		 * trace( MathUtil.percent( 100, 200 ) ); // 50
		 * trace( MathUtil.percent( 200, 100 ) ); // 200
		 * </listing>
		 */
		public static function percent( numerator:Number, denominator:Number ):Number {
			if ( denominator == 0) { return 0; }
			
			return numerator / denominator * 100;
		}
		
		/**
		 * <span lang="ja">数値が偶数かどうかを返します。</span>
		 * <span lang="en">Returns if the value is even number.</span>
		 * 
		 * @param number
		 * <span lang="ja">テストしたい数値です。</span>
		 * <span lang="en">The number to test.</span>
		 * @return
		 * <span lang="ja">偶数であれば true を、奇数であれば false を返します。</span>
		 * <span lang="en">Returns true if the value is even number, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0">
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
