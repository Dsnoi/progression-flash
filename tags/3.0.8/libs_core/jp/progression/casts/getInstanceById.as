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
package jp.progression.casts {
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.display.getInstanceById;
	
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
	 * // CastSprite インスタンスを作成します。
	 * var cast1:CastSprite = new CastSprite();
	 * 
	 * // id を設定します
	 * cast1.id = "cast1";
	 * 
	 * // id から CastSprite インスタンスを取得します。
	 * var cast2:CastSprite = getInstanceById( "cast1" );
	 * 
	 * // 両者を比較します。
	 * trace( cast1 == cast2 ); // true
	 * </listing>
	 */
	public function getInstanceById( id:String ):IExDisplayObject {
		return jp.nium.display.getInstanceById( id );
	}
}









