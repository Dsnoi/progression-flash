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
	 * <p>XMLUtil クラスは、XML データを操作するためのユーティリティクラスです。
	 * XMLUtil クラスを直接インスタンス化することはできません。
	 * new XMLUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class XMLUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function XMLUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "XMLUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された XMLList インスタンスのオブジェクト表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param xmllist
		 * 	<p>変換したい XMLList インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>XMLList インスタンスのオブジェクト表現です。</p>
		 * 	<p>A Object representation of the XMLList instance.</p>
		 * 
		 * @example <listing version="3.0" >
		 * var xml:XMLList = new XMLList( ""
		 * 	+ "<aaa>AAA</aaa>"
		 * 	+ "<bbb>BBB</bbb>"
		 * 	+ "<ccc>CCC</ccc>" );
		 * var obj:Object = XMLUtil.xmlToObject( xml );
		 * trace( obj.aaa ); // AAA を出力します。
		 * trace( obj.bbb ); // BBB を出力します。
		 * trace( obj.ccc ); // CCC を出力します。
		 * </listing>
		 */
		public static function xmlToObject( xmllist:XMLList ):Object {
			var o:Object = {};
			
			for each ( var xml:XML in xmllist ) {
				o[String( xml.name() )] = StringUtil.toProperType( xml.valueOf(), false );
			}
			
			return o;
		}
	}
}









