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
	import jp.nium.display.getInstancesByRegExp;
	
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
	 * // CastSprite インスタンスを作成します。
	 * var cast1:CastSprite = new CastSprite();
	 * var cast2:CastSprite = new CastSprite();
	 * var cast3:CastSprite = new CastSprite();
	 * 
	 * // id を設定します
	 * cast1.id = "com1";
	 * cast2.id = "com2";
	 * cast3.id = "com3";
	 * 
	 * // id から CastSprite インスタンスを取得します。
	 * var casts:Array = getInstancesByRegExp( "id", new RegExp( "^cast.$" ), true );
	 * 
	 * // 両者を比較します。
	 * trace( casts[0] == cast1 ); // true
	 * trace( casts[1] == cast2 ); // true
	 * trace( casts[2] == cast3 ); // true
	 * </listing>
	 */
	public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
		return jp.nium.display.getInstancesByRegExp( fieldName, pattern, sort );
	}
}









