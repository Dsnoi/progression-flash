/**
 * 
 * Command
 * 
 * @author Copyright (C) 2007-2010 taka:nium
 * @version 3.1.92
 * @see http://comression.jp/
 * @see http://comression.libspark.org/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (C) taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.progression.commands {
	import jp.progression.core.collections.CommandCollection;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された group と同じ値を持つ Command インスタンスを含む配列を返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param group
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en"></span>
	 * @param sort
	 * <span lang="ja">配列をソートするかどうかを指定します。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
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
