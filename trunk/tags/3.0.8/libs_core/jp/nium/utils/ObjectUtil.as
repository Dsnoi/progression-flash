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
	import flash.utils.ByteArray;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.ArrayUtil;
	
	/*======================================================================*//**
	 * <p>ObjectUtil クラスは、オブジェクト操作のためのユーティリティクラスです。
	 * ObjectUtil クラスを直接インスタンス化することはできません。
	 * new ObjectUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class ObjectUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function ObjectUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ObjectUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>対象オブジェクトのプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>一括設定したいオブジェクトです。</p>
		 * 	<p></p>
		 * @param props
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
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
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトを複製して返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>対象のオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>複製されたオブジェクトです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function clone( target:Object ):Object {
			var byte:ByteArray = new ByteArray();
			byte.writeObject( target );
			byte.position = 0;
			return Object( byte.readObject() );
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトに設定されているプロパティ数を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>対象のオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>オブジェクトに設定されているプロパティ数です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
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
				length++;
			}
			
			return length;
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのクエリーストリング表現を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param query
		 * 	<p>対象のオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>オブジェクトのクエリーストリング表現です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * var o:Object = { a:"A", b:"B", c:"C" };
		 * trace( ObjectUtil.toQueryString( o ) ); // c=C&a=A&b=B
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
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>対象のオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>オブジェクトのストリング表現です。</p>
		 * 	<p>A string representation of the object.</p>
		 * 
		 * @example <listing version="3.0" >
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
					case value is String	: { str += "\"" + value + "\""; break; }
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









