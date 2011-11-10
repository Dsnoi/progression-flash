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
	import jp.progression.Progression;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">指定された sceneId インスタンスの指し示す Progression インスタンスを返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param id
	 * <span lang="ja">条件となる SceneId インスタンスです。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // Progression インスタンスを作成します。
	 * var prog1:Progression = new Progression( "index", stage );
	 * 
	 * // id から Progression インスタンスを取得します。
	 * var prog2:Progression = getProgressionBySceneId( new SceneId( "/index" ) );
	 * 
	 * // 両者を比較します。
	 * trace( prog1 == prog2 ); // true
	 * </listing>
	 */
	public function getProgressionBySceneId( sceneId:SceneId ):Progression {
		return ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
	}
}
