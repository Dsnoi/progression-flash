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
package jp.nium.lang {
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">Locale クラスは、多言語テキストを制御するためのクラスです。
	 * Locale クラスを直接インスタンス化することはできません。
	 * new Locale() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The Locale class is a class to handle muilti languages.
	 * Locale class can not instanciate directly.
	 * When call the new Locale() constructor, the ArgumentError exception will be thrown.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class Locale {
		
		/**
		 * <span lang="ja">言語設定が英語になるよう指定します。</span>
		 * <span lang="en">Set the language configuration to "English".</span>
		 */
		public static const EN:String = "en";
		
		/**
		 * <span lang="ja">言語設定が日本語になるよう指定します。</span>
		 * <span lang="en">Set the language configuration to "Japanese".</span>
		 */
		public static const JA:String = "ja";
		
		
		
		
		
		/**
		 * <span lang="ja">現在設定されている言語を取得または設定します。
		 * デフォルト設定は、Flash Player が実行されているシステムの言語コードになります。</span>
		 * <span lang="en">Get or set the current language.
		 * The default setting will be same as System language code which executing the Flash Player.</span>
		 */
		public static function get language():String { return _language; }
		public static function set language( value:String ):void { _language = value || Capabilities.language; }
		private static var _language:String = Capabilities.language;
		
		/**
		 * 指定された言語に対応したストリングが存在しなかった場合に、代替言語として使用される言語を取得します。
		 */
		public static function get defaultLanguage():String { return _defaultLanguage; }
		private static var _defaultLanguage:String = Locale.EN;
		
		/**
		 * Dictionary インスタンスを取得します。
		 */
		private static var _dictionary:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * @private
		 */
		public function Locale() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Locale" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定した id に関連付けられたストリングを現在設定されている言語表現で返します。</span>
		 * <span lang="en">Returns the string which relate to the specified id by the current language expression.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付けられた識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @return
		 * <span lang="ja">関連付けられたストリングです。</span>
		 * <span lang="en">Related string.</span>
		 */
		public static function getString( id:String ):String {
			return getStringByLang( id, language );
		}
		
		/**
		 * <span lang="ja">指定した id と言語に関連付けられたストリングを返します。</span>
		 * <span lang="en">Returns the string which relates to the specified id and language.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付けられた識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @param language
		 * <span lang="ja">ストリングに関連付けられた言語です。</span>
		 * <span lang="en">The language relates to the string.</span>
		 * @return
		 * <span lang="ja">関連付けられたストリングです。</span>
		 * <span lang="en">Related string.</span>
		 */
		public static function getStringByLang( id:String, language:String ):String {
			// 指定された言語で登録されていれば返す
			if ( _dictionary[language] ) { return _dictionary[language][id] || ""; }
			
			// デフォルト言語で登録されている情報を返す
			return _dictionary[_defaultLanguage][id] || "";
		}
		
		/**
		 * <span lang="ja">ストリングを指定した id と言語に関連付けます。</span>
		 * <span lang="en">Relate the specified string to the language.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付ける識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @param language
		 * <span lang="ja">ストリングに関連付ける言語です。</span>
		 * <span lang="en">The language relates to the string.</span>
		 * @param value
		 * <span lang="ja">関連付けるストリングです。</span>
		 * <span lang="en">Related string.</span>
		 */
		public static function setString( id:String, language:String, value:String ):void {
			// 初期化されていなければ初期化する
			_dictionary[language] ||= new Dictionary();
			
			// 設定する
			_dictionary[language][id] = value;
		}
	}
}
