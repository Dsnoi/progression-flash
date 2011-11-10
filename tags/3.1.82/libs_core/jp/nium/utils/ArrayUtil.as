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
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <span lang="ja">ArrayUtil クラスは、配列操作のためのユーティリティクラスです。
	 * ArrayUtil クラスを直接インスタンス化することはできません。
	 * new ArrayUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The ArrayUtil class is an utility class for array operation.
	 * ArrayUtil class can not instanciate directly.
	 * When call the new ArrayUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class ArrayUtil {
		
		/**
		 * @private
		 */
		public function ArrayUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ArrayUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された配列に含まれるアイテムのインデックス値を返します。</span>
		 * <span lang="en">Returns the index value of the item included in specified array.</span>
		 * 
		 * @param target
		 * <span lang="ja">検索対象の配列です。</span>
		 * <span lang="en">The array to search the object.</>
		 * @param item
		 * <span lang="ja">検索されるアイテムです。</span>
		 * <span lang="en">The item to be searched.</span>
		 * @return
		 * <span lang="ja">指定されたアイテムのインデックス値、または -1 （指定されたアイテムが見つからない場合）です。</span>
		 * <span lang="en">The index value of the specified item or -1 (In case, the specified item could not find).</span>
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
		
		/**
		 * <span lang="ja">ネストされた配列を分解して、単一の配列に結合します。
		 * この操作では元の配列は変更されません。</span>
		 * <span lang="en">Split the nested array and combine to sigle array.
		 * The original array will not be modified by this operation.</span>
		 * 
		 * @param target
		 * <span lang="ja">対象の配列です。</span>
		 * <span lang="en">The array to split.</span>
		 * @return
		 * <span lang="ja">結合後の配列です。</span>
		 * <span lang="en">The combined array.</span>
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
		
		/**
		 * <span lang="ja">指定された配列のストリング表現を返します。</span>
		 * <span lang="en">Returns the string expression of the specified array.</span>
		 * 
		 * @param target
		 * <span lang="ja">対象の配列です。</span>
		 * <span lang="en">The array to process.</span>
		 * @return
		 * <span lang="ja">配列のストリング表現です。</span>
		 * <span lang="en">The string expression of the array.</span>
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
					case value is String	: { str += '"' + value.replace( new RegExp( '"', "gi" ), '\\"' ) + '"'; break; }
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
