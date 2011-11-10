/*======================================================================*//**
 * 
 * Command
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
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された fieldName が条件と一致する Command インスタンスを含む配列を返します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @param fieldName
	 * 	<p>調査するフィールド名です。</p>
	 * 	<p></p>
	 * @param pattern
	 * 	<p>条件となる正規表現です。</p>
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
	 * // id を設定します
	 * com1.id = "com1";
	 * com2.id = "com2";
	 * com3.id = "com3";
	 * 
	 * // id から Command インスタンスを取得します。
	 * var coms:Array = getCommandsByRegExp( "id", new RegExp( "^com.$" ), true );
	 * 
	 * // 両者を比較します。
	 * trace( coms[0] == com1 ); // true
	 * trace( coms[1] == com2 ); // true
	 * trace( coms[2] == com3 ); // true
	 * </listing>
	 */
	public function getCommandsByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return CommandCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
	}
}









