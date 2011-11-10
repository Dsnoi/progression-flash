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
	import jp.nium.utils.ObjectUtil;
	
	/*======================================================================*//**
	 * <p>ArrayUtil クラスは、配列操作のためのユーティリティクラスです。
	 * ArrayUtil クラスを直接インスタンス化することはできません。
	 * new ArrayUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class ArrayUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function ArrayUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ArrayUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された配列に含まれるアイテムのインデックス値を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>検索対象の配列です。</p>
		 * 	<p></p>
		 * @param item
		 * 	<p>検索されるアイテムです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>指定されたアイテムのインデックス値、または -1 （指定されたアイテムが見つからない場合）です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * var array:Array = [ "A", "B", "C" ];
		 * trace( ArrayUtil.getItemIndex( array, "A" ) ); // 0
		 * trace( ArrayUtil.getItemIndex( array, "B" ) ); // 1
		 * trace( ArrayUtil.getItemIndex( array, "C" ) ); // 2
		 * trace( ArrayUtil.getItemIndex( array, "D" ) ); // -1
		 * </listing>
		 */
		public static function getItemIndex( target:Array, item:* ):int {
			var l:int = target.length;
			for ( var i:int = 0; i < l; i++ ) {
				if ( target[i] == item ) { return i; }
			}
			return -1;
		}
		
		/*======================================================================*//**
		 * <p>ネストされた配列を分解して、単一の配列に結合します。
		 * この操作では元の配列は変更されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>対象の配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>結合後の配列です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * var array:Array = [ [ [ "A" ], "B" ], "C" ];
		 * array = ArrayUtil.combine( array );
		 * trace( array[0] ); // A
		 * trace( array[1] ); // B
		 * trace( array[2] ); // C
		 * </listing>
		 */
		public static function combine( target:Array ):Array {
			var list:Array = [];
			
			// 対象の型のよって振り分ける
			var l:int = target.length;
			for ( var i:int = 0; i < l; i++ ) {
				var value:* = target[i];
				
				switch ( true ) {
					case value is Array	: { list = list.concat( combine( value as Array ) ); break; }
					default				: { list.push( value ); }
				}
			}
			
			return list;
		}
		
		/*======================================================================*//**
		 * <p>指定された配列のストリング表現を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>対象の配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>配列のストリング表現です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * var array:Array = [ "A" , 10 , { aaa:"AAA", num:10 } ];
		 * trace( ArrayUtil.toString( array ) ); // ["A", 10, {aaa:"AAA", num:10}]
		 * </listing>
		 */
		public static function toString( target:Array ):String {
			var str:String = "[";
			
			var l:int = target.length;
			for ( var i:int = 0; i < l; i++ ) {
				var value:* = target[i];
				
				switch ( true ) {
					case value is Array		: { str += ArrayUtil.toString( value ); break; }
					case value is Boolean	:
					case value is Number	:
					case value is int		:
					case value is uint		: { str += value; break; }
					case value is String	: { str += "\"" + value + "\""; break; }
					default					: { str += ObjectUtil.toString( value ); }
				}
				
				str += ", ";
			}
			
			// 1 度でもループを処理していれば最後の , を削除する
			if ( i > 0 ) {
				str = str.slice( 0, -2 );
			}
			
			str += "]";
			
			return str;
		}
	}
}









