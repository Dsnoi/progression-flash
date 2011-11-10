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
package jp.progression.core.ui {
	
	/*======================================================================*//**
	 * <p>ICastContextMenu インターフェイスは ContextMenu の基本機能を強化する機能を実装します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ICastContextMenu {
		
		/*======================================================================*//**
		 * <p>コンテクストメニューを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function get enabled():Boolean;
		function set enabled( value:Boolean ):void;
		
		/*======================================================================*//**
		 * <p>ユーザー定義の ContextMenuItem を含む配列を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function get customItems():Array;
		
		/*======================================================================*//**
		 * <p>[設定] を除き、指定された ContextMenu オブジェクト内のすべてのビルトインメニューアイテムを非表示にします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function hideBuiltInItems():void;
		
		/*======================================================================*//**
		 * <p>指定された ContextMenu オブジェクト内の Progression に関連するすべてのメニューアイテムを非表示にします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function hideProgressionItems():void;
	}
}









