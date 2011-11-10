/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.core.display {
	import flash.display.DisplayObject;
	import jp.nium.core.display.IExDisplayObject;
	
	/**
	 * <span lang="ja">IExDisplayObjectContainer インターフェイスは IExDisplayObject を拡張し、DisplayObjectContainer の基本機能を強化する機能を実装します。</span>
	 * <span lang="en">IExDisplayObjectContainer interface extends IExDispalyObject and implements the function to enhance the basic function of the DisplayObjectContainer.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public interface IExDisplayObjectContainer extends IExDisplayObject {
		
		/**
		 * <span lang="ja">子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能である為、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en">The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</span>
		 */
		function get children():Array;
		
		
		
		
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスに子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		function addChild( child:DisplayObject ):DisplayObject;
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		function addChildAt( child:DisplayObject, index:int ):DisplayObject;
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject;
		
		/**
		 * <span lang="ja">DisplayObjectContainer インスタンスの子リストから指定の DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子から削除する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to remove.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		function removeChild( child:DisplayObject ):DisplayObject;
		
		/**
		 * <span lang="ja">DisplayObjectContainer の子リストの指定されたインデックス位置から子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.</span>
		 * 
		 * @param index
		 * <span lang="ja">削除する DisplayObject の子インデックスです。</span>
		 * <span lang="en">The child index of the DisplayObject to remove.</span>
		 * @return
		 * <span lang="ja">削除された DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that was removed.</span>
		 */
		function removeChildAt( index:int ):DisplayObject;
		
		/**
		 * <span lang="ja">DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes the whole child DisplayObject instance added to the DisplayObjectContainer.</span>
		 */
		function removeAllChildren():void;
		
		/**
		 * <span lang="ja">指定された表示オブジェクトが DisplayObjectContainer インスタンスの子であるか、オブジェクト自体であるかを指定します。</span>
		 * <span lang="en">Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.</span>
		 * 
		 * @param child
		 * <span lang="ja">テストする子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child object to test.</span>
		 * @return
		 * <span lang="ja">child インスタンスが DisplayObjectContainer の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</span>
		 * <span lang="en">true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false.</span>
		 */
		function contains( child:DisplayObject ):Boolean;
		
		/**
		 * <span lang="ja">指定のインデックス位置にある子表示オブジェクトオブジェクトを返します。</span>
		 * <span lang="en">Returns the child display object instance that exists at the specified index.</span>
		 * 
		 * @param index
		 * <span lang="ja">子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the child object.</span>
		 * @return
		 * <span lang="ja">指定されたインデックス位置にある子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child display object at the specified index position.</span>
		 */
		function getChildAt( index:int ):DisplayObject;
		
		/**
		 * <span lang="ja">指定された名前に一致する子表示オブジェクトを返します。</span>
		 * <span lang="en">Returns the child display object that exists with the specified name.</span>
		 * 
		 * @param name
		 * <span lang="ja">返される子 DisplayObject インスタンスの名前です。</span>
		 * <span lang="en">The name of the child to return.</span>
		 * @return
		 * <span lang="ja">指定された名前を持つ子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child display object with the specified name.</span>
		 */
		function getChildByName( name:String ):DisplayObject;
		
		/**
		 * <span lang="ja">子 DisplayObject インスタンスのインデックス位置を返します。</span>
		 * <span lang="en">Returns the index position of a child DisplayObject instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">特定する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to identify.</span>
		 * @return
		 * <span lang="ja">特定する子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the child display object to identify.</span>
		 */
		function getChildIndex( child:DisplayObject ):int;
		
		/**
		 * <span lang="ja">表示オブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing child in the display object container.</span>
		 * 
		 * @param child
		 * <span lang="ja">インデックス番号を変更する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child DisplayObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the child display object.</span>
		 */
		function setChildIndex( child:DisplayObject, index:int ):void;
		
		/**
		 * <span lang="ja">表示オブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing child in the display object container.</span>
		 * 
		 * @param child
		 * <span lang="ja">インデックス番号を変更する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child DisplayObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the child display object.</span>
		 */
		function setChildIndexAbove( child:DisplayObject, index:int ):void ;
		
		/**
		 * <span lang="ja">指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the two specified child objects.</span>
		 * 
		 * @param child1
		 * <span lang="ja">先頭の子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The first child object.</span>
		 * @param child2
		 * <span lang="ja">2 番目の子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The second child object.</span>
		 */
		function swapChildren( child1:DisplayObject, child2:DisplayObject ):void;
		
		/**
		 * <span lang="ja">子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.</span>
		 * 
		 * @param index1
		 * <span lang="ja">最初の子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the first child object.</span>
		 * @param index2
		 * <span lang="ja">2 番目の子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the second child object.</span>
		 */
		function swapChildrenAt( index1:int, index2:int ):void;
	}
}
