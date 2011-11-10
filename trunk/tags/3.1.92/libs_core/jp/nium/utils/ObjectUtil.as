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
	import flash.utils.ByteArray;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.ArrayUtil;
	
	/**
	 * <span lang="ja">ObjectUtil クラスは、オブジェクト操作のためのユーティリティクラスです。
	 * ObjectUtil クラスを直接インスタンス化することはできません。
	 * new ObjectUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The ObjectUtil class is an utility class for object operation.
	 * ObjectUtil class can not instanciate directly.
	 * When call the new ObjectUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class ObjectUtil {
		
		/**
		 * @private
		 */
		public function ObjectUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ObjectUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">対象オブジェクトのプロパティを一括設定します。</span>
		 * <span lang="en">Set the whole property of the object.</span>
		 * 
		 * @param target
		 * <span lang="ja">一括設定したいオブジェクトです。</span>
		 * <span lang="en">The object to set.</span>
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en">The object that contains the property to setup.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function setProperties( target:Object, props:Object ):void {
			// 対象を保存する配列を作成する
			var targets:Array = [target];
			
			// 対象が配列であれば結合する
			if ( target is Array ) {
				targets = target.slice();
			}
			
			// プロパティを設定する
			var l:int = targets.length;
			for ( var i:int = 0; i < l; i++ ) {
				for ( var prop:String in props ) {
					// プロパティが存在しなければ次へ
					if ( !( prop in targets[i] ) ) { continue; }
					
					// 設定値を取得する
					var item:* = targets[i];
					var value:* = props[prop];
					
					// プロパティを設定する
					switch ( true ) {
						case value is Array									:
						case value is Boolean								:
						case value is Number								:
						case value is int									:
						case value is uint									:
						case value is String								:
						case value is Function								:
						case ClassUtil.getClassName( value ) != "Object"	: { item[prop] = value; break; }
						default												: {
							try {
								item[prop] ||= {};
							}
							catch ( e:Error ) {
							}
							
							setProperties( item[prop], value );
							break;
						}
					}
				}
			}
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトを複製して返します。</span>
		 * <span lang="en">Returns the copy of the specified object.</span>
		 * 
		 * @param target
		 * <span lang="ja">対象のオブジェクトです。</span>
		 * <span lang="en">The object to copy.</span>
		 * @return
		 * <span lang="ja">複製されたオブジェクトです。</span>
		 * <span lang="en">The copied object.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function clone( target:Object ):Object {
			var byte:ByteArray = new ByteArray();
			byte.writeObject( target );
			byte.position = 0;
			return Object( byte.readObject() );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトに設定されているプロパティ数を返します。</span>
		 * <span lang="en">Returns the number of the property of the specified object.</span>
		 * 
		 * @param target
		 * <span lang="ja">対象のオブジェクトです。</span>
		 * <span lang="en">The object to check.</span>
		 * @return
		 * <span lang="ja">オブジェクトに設定されているプロパティ数です。</span>
		 * <span lang="en">The property count of the object.</span>
		 * 
		 * @example <listing version="3.0">
		 * var o:Object = { a:"A", b:"B", c:"C" };
		 * trace( ObjectUtil.length( o ) ); // 3
		 * o.d = "D";
		 * o.e = "E";
		 * trace( ObjectUtil.length( o ) ); // 5
		 * </listing>
		 */
		public static function length( target:Object ):int {
			var length:int = 0;
			
			for ( var p:String in target ) {
				p;
				length++;
			}
			
			return length;
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのクエリーストリング表現を返します。</span>
		 * <span lang="en">Returns the query string expression of the specified object.</span>
		 * 
		 * @param query
		 * <span lang="ja">対象のオブジェクトです。</span>
		 * <span lang="en">The object to get the query string.</span>
		 * @return
		 * <span lang="ja">オブジェクトのクエリーストリング表現です。</span>
		 * <span lang="en">The query string expression of the object.</span>
		 * 
		 * @example <listing version="3.0">
		 * var o:Object = { a:"A", b:"B", c:"C" };
		 * trace( ObjectUtil.toQueryString( o ) ); // c=C&amp;a=A&amp;b=B
		 * </listing>
		 */
		public static function toQueryString( query:Object ):String {
			var str:String = "";
			query ||= {};
			
			// String に変換する
			for ( var p:String in query ) {
				str += p + "=" + query[p] + "&";
			}
			
			// 1 度でもループを処理していれば、最後の & を削除する
			if ( p ) {
				str = str.slice( 0, -1 );
			}
			
			return encodeURI( decodeURI( str ) );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string expression of the specified object.</span>
		 * 
		 * @param target
		 * <span lang="ja">対象のオブジェクトです。</span>
		 * <span lang="en">The object to get the string expression.</span>
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">The string expression of the object.</span>
		 * 
		 * @example <listing version="3.0">
		 * var o:Object = { a:"A", b:"B", c:"C" };
		 * trace( ObjectUtil.toString( o ) ); // {c:"C", a:"A", b:"B"}
		 * </listing>
		 */
		public static function toString( target:Object ):String {
			// Array であれば
			if ( target is Array ) { return ArrayUtil.toString( target as Array ); }
			
			var str:String = "{";
			
			for ( var p:String in target ) {
				str += p + ":";
				
				var value:* = target[p];
				
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
			
			// 1 度でもループを処理していれば、最後の , を削除する
			if ( p ) {
				str = str.slice( 0, -2 );
			}
			
			str += "}";
			
			return str;
		}
	}
}
