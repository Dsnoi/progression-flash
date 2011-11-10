/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import jp.nium.core.collections.ExDisplayCollection;
	import jp.nium.core.namespaces.nium_internal;
	
	use namespace nium_internal;
	
	/**
	 * <span lang="ja">指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
	 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that match the condition to the specified fieldName.</span>
	 * 
	 * @param fieldName
	 * <span lang="ja">調査するフィールド名です。</span>
	 * <span lang="en">The field name to check.</span>
	 * @param pattern
	 * <span lang="ja">条件となる正規表現です。</span>
	 * <span lang="en">The regular expression to become a condition.</span>
	 * @param sort
	 * <span lang="ja">配列をソートするかどうかを指定します。</span>
	 * <span lang="en">Specify if it sorts the array.</span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en">The instance match to the condition.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return ExDisplayCollection.nium_internal::getInstancesByRegExp( fieldName, pattern, sort );
	}
}
