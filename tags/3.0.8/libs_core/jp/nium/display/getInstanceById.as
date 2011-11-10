/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.display {
	import jp.nium.core.collections.ExDisplayCollection;
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.core.namespaces.nium_internal;
	
	use namespace nium_internal;
	
	/*======================================================================*//**
	 * <p>指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</p>
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
	 * </listing>
	 */
	public function getInstanceById( id:String ):IExDisplayObject {
		return ExDisplayCollection.nium_internal::getInstanceById( id );
	}
}









