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
	 * <p>DateUtil クラスは、日付データ操作のためのユーティリティクラスです。
	 * DateUtil クラスを直接インスタンス化することはできません。
	 * new DateUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class DateUtil {
		
		/*======================================================================*//**
		 * <p>1 ミリ秒をミリ秒単位で表した定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ONE_MILLISECOND:int = 1;
		
		/*======================================================================*//**
		 * <p>ミリ秒の最大値を表す定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const MAX_MILLISECOND:int = 1000;
		
		/*======================================================================*//**
		 * <p>1 秒をミリ秒単位で表した定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ONE_SECOND:int = ONE_MILLISECOND * MAX_MILLISECOND;
		
		/*======================================================================*//**
		 * <p>秒の最大値を表す定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const MAX_SECOND:int = 60;
		
		/*======================================================================*//**
		 * <p>1 分をミリ秒単位で表した定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ONE_MINUTE:int = ONE_SECOND * MAX_SECOND;
		
		/*======================================================================*//**
		 * <p>分の最大値を表す定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const MAX_MINUTE:int = 60;
		
		/*======================================================================*//**
		 * <p>1 時間をミリ秒単位で表した定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ONE_HOUR:int = ONE_MINUTE * MAX_MINUTE;
		
		/*======================================================================*//**
		 * <p>時間の最大値を表す定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const MAX_HOUR:int = 24;
		
		/*======================================================================*//**
		 * <p>1 日をミリ秒単位で表した定数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ONE_DAY:int = ONE_HOUR * MAX_HOUR;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function DateUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "DateUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>対象の月の最大日数を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param date
		 * 	<p>最大日数を取得したい Date インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>最大日数です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( DateUtil.getMaxDateLength( new Date( 1955, 10, 5 ) ) ); // 30
		 * trace( DateUtil.getMaxDateLength( new Date( 1985, 10, 26, 1, 18 ) ) ); // 30
		 * </listing>
		 */
		public static function getMaxDateLength( date:Date ):int {
			var newdate:Date = new Date( date );
			newdate.setMonth( date.getMonth() + 1 );
			newdate.setDate( 0 );
			return newdate.getDate();
		}
	}
}









