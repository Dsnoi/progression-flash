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
package jp.progression.scenes {
	import jp.progression.core.collections.SceneCollection;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された id と同じ値が設定されている SceneObject インスタンスを返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param id
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
	 */
	public function getSceneById( id:String ):SceneObject {
		return SceneCollection.progression_internal::__getInstanceById( id );
	}
}
