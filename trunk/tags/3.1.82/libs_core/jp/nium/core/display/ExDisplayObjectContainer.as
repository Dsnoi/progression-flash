/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.core.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.display.ExDisplayObject;
	import jp.nium.core.display.IExDisplayObjectContainer;
	import jp.nium.core.namespaces.nium_internal;
	import jp.nium.display.ChildIndexer;
	
	use namespace nium_internal;
	
	/**
	 * <span lang="ja">ExDisplayObjectContainer クラスは、IExDisplayObjectContainer インターフェイスを実装した ExDisplayObject クラスの基本機能を拡張するための委譲クラスです。
	 * このクラスを実装すると拡張されたイベント機能を持つ ChildIndexer クラスが Mix-in されることになります。</span>
	 * <span lang="en">ExDisplayObjectContainer class which implements IExDisplayObjectCOntainer interface is a delegate class to extend the basic function of ExDisplayObject class.
	 * If implement this class, the ChildIndexer class which has extended event function will be Mixed-in.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExDisplayObjectContainer extends ExDisplayObject implements IExDisplayObjectContainer {
		
		/**
		 * <span lang="ja">子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能である為、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en">The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</span>
		 */
		public function get children():Array { return _indexer.children; }
		
		/**
		 * ChildIndexer インスタンスを取得します。
		 */
		private var _indexer:ChildIndexer;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ExDisplayObjectContainer インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ExDisplayObjectContainer object.</span>
		 * 
		 * @param target
		 * <span lang="ja">関連付けたい IExDisplayObjectContainer インターフェイスを実装したインスタンスです。</span>
		 * <span lang="en">The instance which implements the IExDisplayObjectContainer that want to relate.</span>
		 */
		public function ExDisplayObjectContainer( target:IExDisplayObjectContainer ) {
			// ChildIndexer を作成する
			var container:DisplayObjectContainer = DisplayObjectContainer( target );
			_indexer = new ChildIndexer( container );
			
			// スーパークラスを初期化する
			super( target );
			
			_indexer.nium_internal::initialize( {
				addChild		:container.addChild,
				addChildAt		:container.addChildAt,
				removeChild		:container.removeChild,
				removeChildAt	:container.removeChildAt,
				contains		:container.contains,
				getChildAt		:container.getChildAt,
				getChildByName	:container.getChildByName,
				getChildIndex	:container.getChildIndex,
				swapChildren	:container.swapChildren,
				swapChildrenAt	:container.swapChildrenAt
			} );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		nium_internal override function initialize( initObject:Object ):void {
			super.nium_internal::initialize( initObject );
			
			_indexer.nium_internal::initialize( {
				addChild:initObject.addChild,
				addChildAt:initObject.addChildAt,
				removeChild:initObject.removeChild,
				removeChildAt:initObject.removeChildAt,
				contains:initObject.contains,
				getChildAt:initObject.getChildAt,
				getChildByName:initObject.getChildByName,
				getChildIndex:initObject.getChildIndex,
				swapChildren:initObject.swapChildren,
				swapChildrenAt:initObject.swapChildrenAt
			} );
		}
		
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
		public function addChild( child:DisplayObject ):DisplayObject {
			return _indexer.addChild( child );
		}
		
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
		public function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			return _indexer.addChildAt( child, index );
		}
		
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
		public function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			return _indexer.addChildAtAbove( child, index );
		}
		
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
		public function removeChild( child:DisplayObject ):DisplayObject {
			return _indexer.removeChild( child );
		}
		
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
		public function removeChildAt( index:int ):DisplayObject {
			return _indexer.removeChildAt( index );
		}
		
		/**
		 * <span lang="ja">DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Remove the whole child DisplayObject instance which added to the DisplayObjectContainer.</span>
		 */
		public function removeAllChildren():void {
			_indexer.removeAllChildren();
		}
		
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
		public function contains( child:DisplayObject ):Boolean {
			return _indexer.contains( child );
		}
		
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
		public function getChildAt( index:int ):DisplayObject {
			return _indexer.getChildAt( index );
		}
		
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
		public function getChildByName( name:String ):DisplayObject {
			return _indexer.getChildByName( name );
		}
		
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
		public function getChildIndex( child:DisplayObject ):int {
			return _indexer.getChildIndex( child );
		}
		
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
		public function setChildIndex( child:DisplayObject, index:int ):void {
			_indexer.setChildIndex( child, index );
		}
		
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
		public function setChildIndexAbove( child:DisplayObject, index:int ):void {
			_indexer.setChildIndexAbove( child, index );
		}
		
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
		public function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			_indexer.swapChildren( child1, child2 );
		}
		
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
		public function swapChildrenAt( index1:int, index2:int ):void {
			_indexer.swapChildrenAt( index1, index2 );
		}
	}
}
