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
package jp.progression.commands {
	import jp.progression.core.collections.CommandCollection;
	import jp.progression.core.commands.Command;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された id と同じ値が設定されている Command インスタンスを返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param id
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // Command インスタンスを作成します。
	 * var com1:Command = new Command();
	 * 
	 * // id を設定します
	 * com1.id = "com1";
	 * 
	 * // id から Command インスタンスを取得します。
	 * var com2:Command = getCommandById( "com1" );
	 * 
	 * // 両者を比較します。
	 * trace( com1 == com2 ); // true
	 * </listing>
	 */
	public function getCommandById( id:String ):Command {
		return CommandCollection.progression_internal::__getInstanceById( id );
	}
}
