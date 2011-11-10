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
package jp.progression {
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された group と同じ値を持つ Progression インスタンスを含む配列を返します。</span>
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
	 * // Progression インスタンスを作成します。
	 * var prog1:Progression = new Progression( "index1", stage );
	 * var prog2:Progression = new Progression( "index2", stage );
	 * var prog3:Progression = new Progression( "index3", stage );
	 * 
	 * // グループを設定します。
	 * prog1.group = "group";
	 * prog2.group = "group";
	 * prog3.group = "group";
	 * 
	 * // id から Progression インスタンスを取得します。
	 * var progs:Array = getProgressionsByGroup( "group", true );
	 * 
	 * // 両者を比較します。
	 * trace( progs[0] == prog1 ); // true
	 * trace( progs[1] == prog2 ); // true
	 * trace( progs[2] == prog3 ); // true
	 * </listing>
	 */
	public function getProgressionsByGroup( group:String, sort:Boolean = false ):Array {
		return ProgressionCollection.progression_internal::__getInstancesByGroup( group, sort );
	}
}
