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
package jp.progression.core.events {
	import flash.events.Event;
	
	/**
	 * @private
	 */
	public class ComponentEvent extends Event {
		
		/**
		 * <span lang="ja">componentAdded イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ComponentEvent.COMPONENT_ADDED constant defines the value of the type property of an componentAdded event object.</span>
		 */
		public static const COMPONENT_ADDED:String = "componentAdded";
		
		/**
		 * <span lang="ja">componentRemoved イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ComponentEvent.COMPONENT_REMOVED constant defines the value of the type property of an componentRemoved event object.</span>
		 */
		public static const COMPONENT_REMOVED:String = "componentRemoved";
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ComponentEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ComponentEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">ComponentEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as ComponentEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">ComponentEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the ComponentEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">ComponentEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the ComponentEvent object can be canceled. The default values is false.</span>
		 */
		public function ComponentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">ComponentEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an ComponentEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい ComponentEvent インスタンスです。</span>
		 * <span lang="en">A new ComponentEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new ComponentEvent( type, bubbles, cancelable );
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
			return formatToString( "ComponentEvent", "type", "bubbles", "cancelable" );
		}
	}
}
