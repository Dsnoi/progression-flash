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
package jp.nium.lang {
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	
	/*======================================================================*//**
	 * <p>Locale クラスは、多言語テキストを制御するためのクラスです。
	 * Locale クラスを直接インスタンス化することはできません。
	 * new Locale() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Locale {
		
		/*======================================================================*//**
		 * <p>言語設定が英語になるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const EN:String = "en";
		
		/*======================================================================*//**
		 * <p>言語設定が日本語になるよう指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const JA:String = "ja";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>現在設定されている言語を取得または設定します。
		 * デフォルト設定は、Flash Player が実行されているシステムの言語コードになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get language():String { return _language; }
		public static function set language( value:String ):void { _language = value || Capabilities.language; }
		private static var _language:String = Capabilities.language;
		
		/*======================================================================*//**
		 * 指定された言語に対応したストリングが存在しなかった場合に、代替言語として使用される言語を取得します。
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get defaultLanguage():String { return _defaultLanguage; }
		private static var _defaultLanguage:String = Locale.EN;
		
		/*======================================================================*//**
		 * EventIntegrator インスタンスを取得します。
		 */
		private static var _integrator:EventIntegrator = new EventIntegrator();
		
		/*======================================================================*//**
		 * Dictionary インスタンスを取得します。
		 */
		private static var _dictionary:Dictionary = new Dictionary();
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function Locale() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Locale" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定した id に関連付けられたストリングを現在設定されている言語表現で返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>ストリングに関連付けられた識別子です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>関連付けられたストリングです。</p>
		 * 	<p></p>
		 */
		public static function getString( id:String ):String {
			return getStringByLang( id, language );
		}
		
		/*======================================================================*//**
		 * <p>指定した id と言語に関連付けられたストリングを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>ストリングに関連付けられた識別子です。</p>
		 * 	<p></p>
		 * @param lang
		 * 	<p>ストリングに関連付けられた言語です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>関連付けられたストリングです。</p>
		 * 	<p></p>
		 */
		public static function getStringByLang( id:String, lang:String ):String {
			// 指定された言語で登録されていれば返す
			if ( _dictionary[lang] ) { return _dictionary[lang][id] || ""; }
			
			// デフォルト言語で登録されている情報を返す
			return _dictionary[_defaultLanguage][id] || "";
		}
		
		/*======================================================================*//**
		 * <p>ストリングを指定した id と言語に関連付けます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>ストリングに関連付ける識別子です。</p>
		 * 	<p></p>
		 * @param lang
		 * 	<p>ストリングに関連付ける言語です。</p>
		 * 	<p></p>
		 * @param value
		 * 	<p>関連付けるストリングです。</p>
		 * 	<p></p>
		 */
		public static function setString( id:String, lang:String, value:String ):void {
			// 初期化されていなければ初期化する
			_dictionary[lang] ||= new Dictionary();
			
			// 設定する
			_dictionary[lang][id] = value;
		}
	}
}









