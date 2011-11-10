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
package jp.nium.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.namespaces.nium_internal;
	import jp.nium.events.IEventIntegrator;
	
	use namespace nium_internal;
	
	/**
	 * <span lang="ja">ChildIndexer クラスは、DisplayObjectContainer を拡張して、より高度な表示リスト操作を行うためのクラスです。</span>
	 * <span lang="en">ChildIndexer class is a class that extends the DisplayObjectContainer to do a more advanced display list operation.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class ChildIndexer {
		
		/**
		 * 登録された DisplayObjectContainer インスタンスをキーとして ChildIndexer インスタンスを保存した Dictionary インスタンスを取得します。 
		 */
		private static var _indexers:Dictionary = new Dictionary( true );
		
		
		
		
		
		/**
		 * <span lang="ja">子ディスプレイオブジェクトの数を取得します。</span>
		 * <span lang="en">Returns the number of children of this object.</span>
		 */
		public function get numChildren():int { return _numChildren; }
		private var _numChildren:int = 0;
		
		/**
		 * <span lang="ja">子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能である為、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en">The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</span>
		 */
		public function get children():Array { return _children.slice(); }
		private var _children:Array;
		
		/**
		 * インデックスを整理する対象コンテナを取得します。
		 */
		private var _container:DisplayObjectContainer;
		
		/**
		 * インデックスをキーとしてディスプレイオブジェクトを保存した Dictionary インスタンスを取得します。
		 */
		public var _indexesToChild:Dictionary;
		
		/**
		 * ディスプレイオブジェクトをキーとしてインデックスを保存した Dictionary インスタンスを取得します。
		 */
		public var _childrenToIndex:Dictionary;
		
		/**
		 */
		private var _addAbove:Boolean = false;
		
		/**
		 * 実際に使用する関数を取得します。
		 */
		private var _addChild:Function;
		private var _addChildAt:Function;
		private var _removeChild:Function;
		private var _removeChildAt:Function;
		private var _contains:Function;
		private var _getChildAt:Function;
		private var _getChildByName:Function;
		private var _getChildIndex:Function;
		private var _swapChildren:Function;
		private var _swapChildrenAt:Function;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ChildIndexer インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ChildIndexer object.</span>
		 * 
		 * @param container
		 * <span lang="ja">関連付けたい DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en">The DisplayObjectContainer instance that want to relate.</span>
		 */
		public function ChildIndexer( container:DisplayObjectContainer ) {
			// すでに登録されていればエラーを送出する
			if ( _indexers[container] ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_8007" ) ); }
			
			// 引数を設定する
			_container = container;
			
			// 登録する
			_indexers[_container] = this;
			
			// 初期化する
			nium_internal::initialize( {
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
		nium_internal function initialize( initObject:Object ):void {
			// 指定された関数を設定する
			_addChild = initObject.addChild;
			_addChildAt = initObject.addChildAt;
			_removeChild = initObject.removeChild;
			_removeChildAt = initObject.removeChildAt;
			_contains = initObject.contains;
			_getChildAt = initObject.getChildAt;
			_getChildByName = initObject.getChildByName;
			_getChildIndex = initObject.getChildIndex;
			_swapChildren = initObject.swapChildren;
			_swapChildrenAt = initObject.swapChildrenAt;
			
			// 初期化する
			_children = [];
			_indexesToChild = new Dictionary( true );
			_childrenToIndex = new Dictionary( true );
			
			// IEventIntegrator インターフェイスを実装していれば
			if ( _container is IEventIntegrator ) {
				try {
					// イベントを登録する
					IEventIntegrator( _container ).addExclusivelyEventListener( Event.ADDED, _added, true, int.MAX_VALUE, true );
					IEventIntegrator( _container ).addExclusivelyEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
				}
				catch ( e:Error ) {
				}
			}
			else {
				// イベントを登録する
				_container.addEventListener( Event.ADDED, _added, true, int.MAX_VALUE, true );
				_container.addEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
			}
			
			// 既存のディスプレイオブジェクトを子に追加する
			var l:int = _container.numChildren;
			for ( var i:int = 0; i < l; i++ ) {
				try {
					var child:DisplayObject = _getChildAt( i );
				}
				catch ( e:Error ) {
					continue;
				}
				
				// 存在すれば設定する
				_indexesToChild[i] = child;
				_childrenToIndex[child] = i;
				_children.push( child );
			}
			
			// この数を設定する
			_numChildren = _children.length;
		}
		
		/**
		 * 子 DisplayObject を登録します。
		 */
		private function _registerChild( child:DisplayObject, index:int ):DisplayObject {
			// すでに配置済みのインデックス位置が指定されたらエラーを送出する
			if ( _indexesToChild[index] ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_8003" ) ); }
			
			// 既存の登録があれば削除する
			if ( !isNaN( _childrenToIndex[child] ) ) {
				_unregisterChild( child );
			}
			
			// データを登録する
			_indexesToChild[index] = child;
			_childrenToIndex[child] = index;
			
			// インデックス位置を取得する
			var indexes:Array = [];
			for each ( var idx:int in _childrenToIndex ) {
				indexes.push( idx );
			}
			
			// 数値順に並び替える
			indexes.sort( Array.NUMERIC );
			
			// 子を並び替える
			_children = [];
			var l:int = indexes.length;
			for ( var i:int = 0; i < l; i++ ) {
				_children.push( _indexesToChild[indexes[i]] );
			}
			
			// この数を設定する
			_numChildren = _children.length;
			
			return child;
		}
		
		/**
		 * 子 DisplayObject の登録を削除します。
		 */
		private function _unregisterChild( child:DisplayObject ):DisplayObject {
			// 子ディスプレイオブジェクトに登録があれば削除する
			if ( !isNaN( _childrenToIndex[child] ) ) {
				// 登録から削除する
				delete _indexesToChild[_childrenToIndex[child]];
				delete _childrenToIndex[child];
				
				// 子ディスプレイオブジェクトを走査する
				var l:int = _children.length;
				for ( var i:int = 0; i < l; i++ ) {
					var display:DisplayObject = DisplayObject( _children[i] );
					
					// 違っていれば次へ
					if ( display != child ) { continue; }
					
					_children.splice( i, 1 );
					break;
				}
			}
			
			// この数を設定する
			_numChildren = _children.length;
			
			return child;
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
			// 親を取得する
			var parent:DisplayObjectContainer = DisplayObjectContainer( child.parent );
			
			// 親が存在すれば
			if ( parent ) {
				// ChildIndexer インスタンスを取得する
				var indexer:ChildIndexer = _indexers[parent];
				
				// 親が ChildIndexer を使用していれば
				if ( indexer ) {
					indexer.removeChild( child );
				}
				else {
					parent.removeChild( child );
				}
			}
			
			// 最高値の仮想インデックス位置を取得する
			var virtualIndex:int = numChildren ? _childrenToIndex[_getChildAt( numChildren - 1 )] + 1 : 0;
			
			// ディスプレイリストに追加して参照を返す
			return _addChild( _registerChild( child, virtualIndex ) );
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
			var virtualIndex:int = index;
			
			// virtualIndex が 0 未満であればエラーを送出する
			if ( virtualIndex < 0 ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2025" ) ); }
			
			// 親を取得する
			var parent:DisplayObjectContainer = DisplayObjectContainer( child.parent );
			
			// 親が存在すれば、親から削除する
			if ( parent ) {
				// ChildIndexer インスタンスを取得する
				var indexer:ChildIndexer = _indexers[parent];
				
				// 親が ChildIndexer を使用していれば
				if ( indexer ) {
					indexer.removeChild( child );
				}
				else {
					parent.removeChild( child );
				}
			}
			
			var realIndex:int;
			
			// 指定された仮想インデックス位置にすでに登録されていれば
			if ( _indexesToChild[virtualIndex] ) {
				realIndex = _getChildIndex( _indexesToChild[virtualIndex] );
				
				// 対象の上に配置するのであれば
				if ( _addAbove ) {
					virtualIndex++;
					realIndex++;
					_addAbove = false;
				}
				
				// インデックス位置を走査する
				var l:int = numChildren;
				for ( var i:int = realIndex; i < l; i++ ) {
					// 子を取得する
					var child1:DisplayObject = _getChildAt( Math.max( realIndex, i - 1 ) );
					var child2:DisplayObject = _getChildAt( i );
					
					// 一つ前のインデックス値と競合してなければ終了する
					if ( _childrenToIndex[child1] != _childrenToIndex[child2] ) { break; }
					
					// 値を 1 つずらす
					var newVirtualIndex:int = _childrenToIndex[child2] + 1;
					
					// 古い登録を削除する
					delete _indexesToChild[_childrenToIndex[child2]];
					
					// 新しく登録する
					_indexesToChild[newVirtualIndex] = child2;
					_childrenToIndex[child2] = newVirtualIndex;
				}
			}
			else {
				l = _children.length;
				for ( i = 0; i < l; i++ ) {
					// 対象の仮想インデックス位置が指定された仮想インデックスを超えていれば終了する
					if ( _childrenToIndex[_children[i]] > virtualIndex ) { break; }
				}
				realIndex = i;
			}
			
			// ディスプレイリストに追加して参照を返す
			return _addChildAt( _registerChild( child, virtualIndex ), realIndex );
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
			_addAbove = true;
			return addChildAt( child, index );
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
			return _removeChild( _unregisterChild( child ) );
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
			return removeChild( _indexesToChild[index] );
		}
		
		/**
		 * <span lang="ja">DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Remove the whole child DisplayObject instance which added to the DisplayObjectContainer.</span>
		 */
		public function removeAllChildren():void {
			// 現在の子リストをコピーする
			var children:Array = _children.slice();
			
			// 初期化する
			_children = [];
			_indexesToChild = new Dictionary( true );
			_childrenToIndex = new Dictionary( true );
			_numChildren = 0;
			
			// 全ての子ディスプレイオブジェクトを削除する
			var l:int = children.length;
			for ( var i:int = 0; i < l; i++ ) {
				_removeChild( children[i] );
			}
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
			return _contains( child );
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
			return _indexesToChild[index];
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
			return _getChildByName( name );
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
			return _childrenToIndex[child];
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
			addChildAt( removeChild( child ), index );
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
			addChildAtAbove( removeChild( child ), index );
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
			// インデックス位置を保存する
			var index1:int = _childrenToIndex[child1];
			var index2:int = _childrenToIndex[child2];
			
			if ( child1.parent != _container || child2.parent != _container ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2025" ) ); }
			
			// ディスプレイリストから削除する
			removeChild( child1 );
			removeChild( child2 );
			
			// ディスプレイリストに追加する
			addChildAt( child1, index2 );
			addChildAt( child2, index1 );
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
			// ディスプレイオブジェクトを保存する
			var child1:DisplayObject = _indexesToChild[index1];
			var child2:DisplayObject = _indexesToChild[index2];
			
			if ( !child1 || !child2 ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_8003" ) ); }
			
			// ディスプレイリストから削除する
			removeChild( child1 );
			removeChild( child2 );
			
			// ディスプレイリストに追加する
			addChildAt( child1, index2 );
			addChildAt( child2, index1 );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return "[object ChildIndexer]";
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが表示リストに追加されたときに送出されます。
		 */
		private function _added( e:Event ):void {
			var target:DisplayObject = DisplayObject( e.target );
			var parent:DisplayObjectContainer = target.parent;
			
			// 対象の親が管理対象の DisplayObjectContainer ではなければ終了する
			if ( parent != _container ) { return; }
			
			// インデックス値が存在していれば終了する
			if ( _childrenToIndex[target] != undefined ) { return; }
			
			// 関連付けられている ChildIndexer を取得する
			var indexer:ChildIndexer = ChildIndexer( _indexers[parent] );
			
			// target の実インデックス値を取得する
			try {
				var realIndex:int = indexer._getChildIndex( target );
			}
			catch ( e:Error ) {
				realIndex = target.parent.getChildIndex( target );
			}
			var virtualIndex:int = -1;
			
			// 子を走査する
			var l:int = parent.numChildren;
			for ( var i:int = 0; i < l; i++ ) {
				// 子を取得する
				var child:DisplayObject = indexer._getChildAt( i );
				
				// 存在しなければ次へ
				if ( !child ) { continue; }
				
				// リアルインデックス値を取得する
				var childRealIndex:int = indexer._getChildIndex( child );
				
				switch ( true ) {
					// 対象のインデックス値が target 未満であれば
					case realIndex > childRealIndex		: { virtualIndex = indexer.getChildIndex( child ); break; }
					
					// 対象と target のインデックス値が同じであれば
					case realIndex == childRealIndex	: {
						virtualIndex++;
						delete _indexesToChild[virtualIndex];
						break;
					}
					// 対象のインデックス値が target より大きければ
					default								: {
						_childrenToIndex[child]++;
					}
				}
			}
			
			// 登録する
			indexer._registerChild( target, virtualIndex );
		}
		
		/**
		 * 表示オブジェクトが表示リストから削除されようとしているときに送出されます。
		 */
		private function _removed( e:Event ):void {
			var target:DisplayObject = DisplayObject( e.target );
			var parent:DisplayObjectContainer = target.parent;
			
			// 対象の親が管理対象の DisplayObjectContainer ではなければ終了する
			if ( parent != _container ) { return; }
			
			// 削除したにも関わらずインデックス値が存在していなければ終了する
			if ( _childrenToIndex[target] == undefined ) { return; }
			
			// 登録から削除する
			var indexer:ChildIndexer = ChildIndexer( _indexers[_container] );
			indexer._unregisterChild( target );
		}
	}
}









