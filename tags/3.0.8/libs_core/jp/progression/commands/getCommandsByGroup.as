/*======================================================================*//**
 * 
 * Command
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://comression.jp/
 * @see http://comression.libspark.org/
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
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された group と同じ値を持つ Command インスタンスを含む配列を返します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @param group
	 * 	<p>条件となるストリングです。</p>
	 * 	<p></p>
	 * @param sort
	 * 	<p>配列をソートするかどうかを指定します。</p>
	 * 	<p></p>
	 * @return
	 * 	<p>条件と一致するインスタンスです。</p>
	 * 	<p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Command インスタンスを作成します。
	 * var com1:Command = new Command();
	 * var com2:Command = new Command();
	 * var com3:Command = new Command();
	 * 
	 * // グループを設定します。
	 * com1.group = "group";
	 * com2.group = "group";
	 * com3.group = "group";
	 * 
	 * // id から Command インスタンスを取得します。
	 * var coms:Array = getCommandsByGroup( "group", true );
	 * 
	 * // 両者を比較します。
	 * trace( coms[0] == com1 ); // true
	 * trace( coms[1] == com2 ); // true
	 * trace( coms[2] == com3 ); // true
	 * </listing>
	 */
	public function getCommandsByGroup( group:String, sort:Boolean = false ):Array {
		return CommandCollection.progression_internal::__getInstancesByGroup( group, sort );
	}
}









