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
	import jp.progression.Progression;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>指定された id と同じ値が設定されている Progression インスタンスを返します。</p>
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
	 * 
	 * @example <listing version="3.0" >
	 * // Progression インスタンスを作成します。
	 * var prog1:Progression = new Progression( "index", stage );
	 * 
	 * // id から Progression インスタンスを取得します。
	 * var prog2:Progression = getProgressionById( "index" );
	 * 
	 * // 両者を比較します。
	 * trace( prog1 == prog2 ); // true
	 //* </listing>
	 */
	public function getProgressionById( id:String ):Progression {
		return ProgressionCollection.progression_internal::__getInstanceById( id );
	}
}









