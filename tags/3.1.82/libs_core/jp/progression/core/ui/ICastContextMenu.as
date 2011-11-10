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
package jp.progression.core.ui {
	
	/**
	 * <span lang="ja">ICastContextMenu インターフェイスは ContextMenu の基本機能を強化する機能を実装します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ICastContextMenu {
		
		/**
		 * <span lang="ja">コンテクストメニューを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		function get enabled():Boolean;
		function set enabled( value:Boolean ):void;
		
		/**
		 * <span lang="ja">ユーザー定義の ContextMenuItem を含む配列を取得します。</span>
		 * <span lang="en"></span>
		 */
		function get customItems():Array;
		
		/**
		 * <span lang="ja">[設定] を除き、指定された ContextMenu オブジェクト内のすべてのビルトインメニューアイテムを非表示にします。</span>
		 * <span lang="en"></span>
		 */
		function hideBuiltInItems():void;
		
		/**
		 * <span lang="ja">指定された ContextMenu オブジェクト内の Progression に関連するすべてのメニューアイテムを非表示にします。</span>
		 * <span lang="en"></span>
		 */
		function hideProgressionItems():void;
	}
}









