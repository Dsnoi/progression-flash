/**
 * 
 * Command
 * 
 * @author Copyright (C) 2007-2010 taka:nium
 * @version 3.1.92
 * @see http://progression.jp/
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
	 * <span lang="ja">指定された fieldName が条件と一致する Command インスタンスを含む配列を返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param fieldName
	 * <span lang="ja">調査するフィールド名です。</span>
	 * <span lang="en"></span>
	 * @param pattern
	 * <span lang="ja">条件となる正規表現です。</span>
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
