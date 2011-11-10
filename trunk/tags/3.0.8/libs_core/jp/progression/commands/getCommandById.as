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
package jp.progression.commands {
	import jp.progression.core.collections.CommandCollection;
	import jp.progression.core.commands.Command;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された id と同じ値が設定されている Command インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @param id
	 * 	<p>条件となるストリングです。</p>
	 * 	<p></p>
	 * @return
	 * 	<p>条件と一致するインスタンスです。</p>
	 * 	<p></p>
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









