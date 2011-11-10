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
package jp.progression.scenes {
	import jp.progression.core.collections.SceneCollection;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された id と同じ値が設定されている SceneObject インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @param id
	 * 	<p>条件となるストリングです。</p>
	 * 	<p></p>
	 * @return
	 * 	<p>条件と一致するインスタンスです。</p>
	 * 	<p></p>
	 */
	public function getSceneById( id:String ):SceneObject {
		return SceneCollection.progression_internal::__getInstanceById( id );
	}
}









