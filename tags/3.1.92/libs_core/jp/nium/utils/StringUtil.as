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
	 * <span lang="ja">StringUtil クラスは、文字列操作のためのユーティリティクラスです。
	 * StringUtil クラスを直接インスタンス化することはできません。
	 * new StringUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The StringUtil class is an utility class for string operation.
	 * StringUtil class can not instanciate directly.
	 * When call the new StringUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class StringUtil {
		
		/**
		 * 改行コードを判別する正規表現を取得します。
		 */
		private static const _COLLECTBREAK_REGEXP:RegExp = new RegExp( "(\r\n|\n|\r)", "g" );
		
		
		
		
		
		/**
		 * @private
		 */
		public function StringUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "StringUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定されたストリングを適切な型のオブジェクトに変換して返します。</span>
		 * <span lang="en">Convert the specified string to the proper object type and returns.</span>
		 * 
		 * @param str
		 * <span lang="ja">変換したいストリングです。</span>
		 * <span lang="en">The string to convert.</span>
		 * @param priority
		 * <span lang="ja">数値化を優先するかどうかです。</span>
		 * <span lang="en">Whether it gives priority to expressing numerically or not?</span>
		 * @return
		 * <span lang="ja">変換後のオブジェクトです。</span>
		 * <span lang="en">The converted object.</span>
		 * 
		 * @example <listing version="3.0">
		 * trace( StringUtil.toProperType( "true" ) == true ); // true
		 * trace( StringUtil.toProperType( "false" ) == false ); // true
		 * trace( StringUtil.toProperType( "null" ) == null ); // true
		 * trace( StringUtil.toProperType( "ABCDE" ) == "ABCDE" ); // true
		 * trace( StringUtil.toProperType( "100" ) == 100 ); // true
		 * trace( StringUtil.toProperType( "010" ) == 10 ); // true
		 * trace( StringUtil.toProperType( "010", false ) == "010" ); // true
		 * trace( StringUtil.toProperType( "10.0", false ) == "10.0" ); // true
		 * </listing>
		 */
		public static function toProperType( str:String, priority:Boolean = true ):* {
			// Number 型に変換する
			var num:Number = parseFloat( str );
			
			// モードが true なら
			if ( priority ) {
				// 数値化を優先する
				if ( !isNaN( num ) ) { return num; }
			}
			else {
				// 元データの維持を優先する
				if ( num.toString() == str ) { return num; }
			}
			
			// グローバル定数、プライマリ式キーワードで返す
			switch ( str ) {
				case "true"			: { return true; }
				case "false"		: { return false; }
				case ""				:
				case "null"			: { return null; }
				case "undefined"	: { return undefined; }
				case "Infinity"		: { return Infinity; }
				case "-Infinity"	: { return -Infinity; }
				case "NaN"			: { return NaN; }
			}
			
			return str;
		}
		
		/**
		 * <span lang="ja">指定された文字列を指定された数だけリピートさせた文字列を返します。</span>
		 * <span lang="en">Returns the string which repeats the specified string with specified times.</span>
		 * 
		 * @param str
		 * <span lang="ja">リピートしたい文字列です。</span>
		 * <span lang="en">The string to repeat.</span>
		 * @param count
		 * <span lang="ja">リピート回数です。</span>
		 * <span lang="en">Repeat time.</span>
		 * @return
		 * <span lang="ja">リピートされた文字列です。</span>
		 * <span lang="en">Repeated string.</span>
		 * 
		 * @example <listing version="3.0">
		 * trace( StringUtil.repeat( "A", 0 ) == "" ); // true
		 * trace( StringUtil.repeat( "A", 1 ) == "A" ); // true
		 * trace( StringUtil.repeat( "A", 2 ) == "AA" ); // true
		 * trace( StringUtil.repeat( "ABC", 3 ) == "ABCABCABC" ); // true
		 * </listing>
		 */
		public static function repeat( str:String, count:int = 0 ):String {
			var result:String = "";
			count = Math.max( 0, count );
			for ( var i:int = 0; i < count; i++ ) {
				result += str;
			}
			return result;
		}
		
		/**
		 * <span lang="ja">String の最初の文字を大文字にし、以降の文字を小文字に変換して返します。</span>
		 * <span lang="en">Convert the first character to upper case and remain character to lower case of the specified string.</span>
		 * 
		 * @param str
		 * <span lang="ja">変換したい文字列です。</span>
		 * <span lang="en">The string to convert.</span>
		 * @return
		 * <span lang="ja">変換後の文字列です。</span>
		 * <span lang="en">The converted string.</span>
		 * 
		 * @example <listing version="3.0">
		 * trace( StringUtil.toUpperCaseFirstLetter( "ABCDE" ) == "Abcde" );
		 * trace( StringUtil.toUpperCaseFirstLetter( "abcde" ) == "Abcde" );
		 * trace( StringUtil.toUpperCaseFirstLetter( "aBCDE" ) == "Abcde" );
		 * </listing>
		 */
		public static function toUpperCaseFirstLetter( str:String ):String {
			return str.charAt( 0 ).toUpperCase() + str.slice( 1 ).toLowerCase();
		}
		
		/**
		 * <span lang="ja">改行コードを変換して返します。</span>
		 * <span lang="en">Convert the line feed code of the specified string and returns.</span>
		 * 
		 * @param str
		 * <span lang="ja">変換したい文字列です。</span>
		 * <span lang="en">The string to convert.</span>
		 * @param newLine
		 * <span lang="ja">変換後の改行コードです。</span>
		 * <span lang="en">The line feed code to convert to.</span>
		 * @return
		 * <span lang="ja">変換後の文字列です。</span>
		 * <span lang="en">The converted string.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function collectBreak( str:String, newLine:String = null ):String {
			newLine ||= "\n";
			
			switch ( newLine ) {
				case "\r"		:
				case "\n"		:
				case "\r\n"		: { return str.replace( _COLLECTBREAK_REGEXP, newLine ); }
			}
			
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_8006" ) );
		}
		
		/**
		 * <span lang="ja">指定されたクエリー形式のストリングを Object に変換して返します。</span>
		 * <span lang="en">Convert the specified query form string to the Object and returns.</span>
		 * 
		 * @param query
		 * <span lang="ja">クエリー形式のストリングです。</span>
		 * <span lang="en">The query form string.</span>
		 * @return
		 * <span lang="ja">変換後の Object です。</span>
		 * <span lang="en">The converted Object.</span>
		 * 
		 * @example <listing version="3.0">
		 * var o:Object = StringUtil.queryToObject( "a=A&amp;b=B&amp;c=C" );
		 * trace( o.a ); // A
		 * trace( o.b ); // B
		 * trace( o.c ); // C
		 * </listing>
		 */
		public static function queryToObject( query:String ):Object {
			var o:Object = {};
			
			var queries:Array = query ? query.split( "&" ) : [];
			
			var l:int = queries.length;
			for ( var i:int = 0; i < l; i++ ) {
				var item:Array = String( queries[i] ).split( "=" );
				o[item[0]] = StringUtil.toProperType( item[1] );
			}
			
			return o;
		}
	}
}
