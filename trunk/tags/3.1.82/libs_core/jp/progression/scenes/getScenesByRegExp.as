/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.scenes {
	import jp.progression.core.collections.SceneCollection;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された fieldName が条件と一致する SceneObject インスタンスを含む配列を返します。</span>
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
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getScenesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return SceneCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
	}
}
