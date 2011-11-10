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
package jp.progression {
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された fieldName が条件と一致する Progression インスタンスを含む配列を返します。</p>
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
	 * // Progression インスタンスを作成します。
	 * var prog1:Progression = new Progression( "index1", stage );
	 * var prog2:Progression = new Progression( "index2", stage );
	 * var prog3:Progression = new Progression( "index3", stage );
	 * 
	 * // id から Progression インスタンスを取得します。
	 * var progs:Array = getProgressionsByRegExp( "id", new RegExp( "^index.$" ), true );
	 * 
	 * // 両者を比較します。
	 * trace( progs[0] == prog1 ); // true
	 * trace( progs[1] == prog2 ); // true
	 * trace( progs[2] == prog3 ); // true
	 * </listing>
	 */
	public function getProgressionsByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return ProgressionCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
	}
}









