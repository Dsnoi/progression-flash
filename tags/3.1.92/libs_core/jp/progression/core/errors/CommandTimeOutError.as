/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core.errors {
	
	/**
	 * <span lang="ja">CommandTimeOutError クラスは、Command 処理が指定された時間を経過しても正しく完了されないために発生するエラーを表します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CommandTimeOutError extends Error {
		
		/**
		 * <span lang="ja">新しい CommandTimeOutError インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CommandTimeOutError object.</span>
		 * 
		 * @param message
		 * <span lang="ja">エラーに関連付けられたストリングです。</span>
		 * <span lang="en">A string associated with the error object.</span>
		 */
		public function CommandTimeOutError( message:String ) {
			// スーパークラスを初期化する
			super( message );
		}
	}
}
