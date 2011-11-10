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
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.display.getInstanceById;
	
	/**
	 * <span lang="ja">指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</span>
	 * <span lang="en"></span>
	 * 
	 * @param id
	 * <span lang="ja">条件となるストリングです。</span>
	 * <span lang="en"></span>
	 * @return
	 * <span lang="ja">条件と一致するインスタンスです。</span>
	 * <span lang="en"></span>
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
