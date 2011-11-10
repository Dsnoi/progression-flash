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
package jp.progression.casts {
	import jp.nium.display.getInstancesByRegExp;
	
	/**
	 * <span lang="ja">指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
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
