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
	 * <span lang="ja">指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
	 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that has the same value of the specified group.</span>
	 * 
	 * @param group
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en">The string that becomes a condition.</span>
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
	public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
		return ExDisplayCollection.nium_internal::getInstancesByGroup( group, sort );
	}
}
