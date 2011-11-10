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
package jp.progression.core.events {
	import flash.events.Event;
	
	/**
	 * @private
	 */
	public class CollectionEvent extends Event {
		
		/**
		 * <span lang="ja">collectionUpdate イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CollectionEvent.COLLECTION_UPDATE constant defines the value of the type property of an collectionUpdate event object.</span>
		 */
		public static const COLLECTION_UPDATE:String = "collectionUpdate";
		
		
		
		
		
		/**
		 * <span lang="ja">イベントに関連するオブジェクトへの参照を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get relatedTarget():* { return _relatedTarget; }
		private var _relatedTarget:*;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CollectionEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CollectionEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">CollectionEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as CollectionEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">CollectionEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CollectionEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">CollectionEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CollectionEvent object can be canceled. The default values is false.</span>
		 * @param relatedTarget
		 * <span lang="ja">イベントに関連するオブジェクトへの参照です。</span>
		 * <span lang="en"></span>
		 */
		public function CollectionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedTarget:* = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_relatedTarget = relatedTarget;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">CollectionEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an CollectionEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい CollectionEvent インスタンスです。</span>
		 * <span lang="en">A new CollectionEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new CollectionEvent( type, bubbles, cancelable, _relatedTarget );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return formatToString( "CollectionEvent", "type", "bubbles", "cancelable" );
		}
	}
}
