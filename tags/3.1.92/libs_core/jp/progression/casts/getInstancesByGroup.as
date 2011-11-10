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
package jp.progression.casts {
	import jp.nium.display.getInstancesByGroup;
	
	/**
	 * <span lang="ja">指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param group
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en"></span>
	 * @param sort
	 * <span lang="ja">配列をソートするかどうかを指定します。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // CastSprite インスタンスを作成します。
	 * var cast1:CastSprite = new CastSprite();
	 * var cast2:CastSprite = new CastSprite();
	 * var cast3:CastSprite = new CastSprite();
	 * 
	 * // グループを設定します。
	 * cast1.group = "group";
	 * cast2.group = "group";
	 * cast3.group = "group";
	 * 
	 * // id から CastSprite インスタンスを取得します。
	 * var casts:Array = getInstancesByGroup( "group", true );
	 * 
	 * // 両者を比較します。
	 * trace( casts[0] == cast1 ); // true
	 * trace( casts[1] == cast2 ); // true
	 * trace( casts[2] == cast3 ); // true
	 * </listing>
	 */
	public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
		return jp.nium.display.getInstancesByGroup( group, sort );
	}
}
