/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import jp.nium.core.collections.ExDisplayCollection;
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.core.namespaces.nium_internal;
	
	use namespace nium_internal;
	
	/**
	 * <span lang="ja">指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</span>
	 * <span lang="en">Returns the instance implements the IExDisplayObject interface which is set the same value of the specified id.</span>
	 * 
	 * @param id
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en">The string that becomes a condition.</span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en">The instance match to the condition.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public function getInstanceById( id:String ):IExDisplayObject {
		return ExDisplayCollection.nium_internal::getInstanceById( id );
	}
}
