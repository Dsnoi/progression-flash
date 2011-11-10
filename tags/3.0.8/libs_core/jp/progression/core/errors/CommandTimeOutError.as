/*======================================================================*//**
 * 
 * Progression
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://progression.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.progression.core.errors {
	
	/*======================================================================*//**
	 * <p>CommandTimeOutError クラスは、Command 処理が指定された時間を経過しても正しく完了されないために発生するエラーを表します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CommandTimeOutError extends Error {
		
		/*======================================================================*//**
		 * <p>新しい CommandTimeOutError インスタンスを作成します。</p>
		 * <p>Creates a new CommandTimeOutError object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param message
		 * 	<p>エラーに関連付けられたストリングです。</p>
		 * 	<p>A string associated with the error object.</p>
		 */
		public function CommandTimeOutError( message:String ) {
			// スーパークラスを初期化する
			super( message );
		}
	}
}









