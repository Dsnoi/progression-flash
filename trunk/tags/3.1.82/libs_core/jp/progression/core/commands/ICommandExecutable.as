/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.core.commands {
	import jp.nium.events.IEventIntegrator;
	import jp.progression.core.commands.CommandExecutor;
	
	/**
	 * <span lang="ja">ICommandExecutable インターフェイスは、対象がコマンドを実行可能にする機能を実装します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ICommandExecutable extends IEventIntegrator {
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		function get executor():CommandExecutor;
	}
}
