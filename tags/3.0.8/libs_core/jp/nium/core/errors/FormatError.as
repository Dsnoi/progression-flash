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
package jp.nium.core.errors {
	
	/*======================================================================*//**
	 * <p>FormatError クラスは、指定された文字列のフォーマットが正しくないために発生するエラーを表します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class FormatError extends Error {
		
		/*======================================================================*//**
		 * <p>新しい FormatError インスタンスを作成します。</p>
		 * <p>Creates a new FormatError object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param message
		 * 	<p>エラーに関連付けられたストリングです。</p>
		 * 	<p>A string associated with the error object.</p>
		 */
		public function FormatError( message:String ) {
			// スーパークラスを初期化する
			super( message );
		}
	}
}









