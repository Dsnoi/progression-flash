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
	import jp.nium.core.namespaces.nium_internal;
	
	use namespace nium_internal;
	
	/*======================================================================*//**
	 * <p>指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</p>
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
	 * </listing>
	 */
	public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return ExDisplayCollection.nium_internal::getInstancesByRegExp( fieldName, pattern, sort );
	}
}









