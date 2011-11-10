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
package jp.nium.core.errors {
	
	/**
	 * <span lang="ja">FormatError クラスは、指定された文字列のフォーマットが正しくないために発生するエラーを表します。</span>
	 * <span lang="en">FormatError class represent the error caused by the specified string with wrong format.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class FormatError extends Error {
		
		/**
		 * <span lang="ja">新しい FormatError インスタンスを作成します。</span>
		 * <span lang="en">Creates a new FormatError object.</span>
		 * 
		 * @param message
		 * <span lang="ja">エラーに関連付けられたストリングです。</span>
		 * <span lang="en">A string associated with the error object.</span>
		 */
		public function FormatError( message:String ) {
			// スーパークラスを初期化する
			super( message );
		}
	}
}
