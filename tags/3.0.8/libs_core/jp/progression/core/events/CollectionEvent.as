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
package jp.progression.core.events {
	import flash.events.Event;
	
	/*======================================================================*//**
	 * @private
	 */
	public class CollectionEvent extends Event {
		
		/*======================================================================*//**
		 * <p>collectionUpdate イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CollectionEvent.COLLECTION_UPDATE constant defines the value of the type property of an collectionUpdate event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COLLECTION_UPDATE:String = "collectionUpdate";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>イベントに関連するオブジェクトへの参照を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get relatedTarget():* { return _relatedTarget; }
		private var _relatedTarget:*;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CollectionEvent インスタンスを作成します。</p>
		 * <p>Creates a new CollectionEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>CollectionEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as CollectionEvent.type.</p>
		 * @param bubbles
		 * 	<p>CollectionEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CollectionEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>CollectionEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CollectionEvent object can be canceled. The default values is false.</p>
		 * @param relatedTarget
		 * 	<p>イベントに関連するオブジェクトへの参照です。</p>
		 * 	<p></p>
		 */
		public function CollectionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedTarget:* = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_relatedTarget = relatedTarget;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>CollectionEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CollectionEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい CollectionEvent インスタンスです。</p>
		 * 	<p>A new CollectionEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CollectionEvent( type, bubbles, cancelable, _relatedTarget );
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>オブジェクトのストリング表現です。</p>
		 * 	<p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return formatToString( "CollectionEvent", "type", "bubbles", "cancelable" );
		}
	}
}









