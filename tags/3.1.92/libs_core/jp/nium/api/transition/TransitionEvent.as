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
package jp.nium.api.transition {
	import flash.events.Event;
	
	/**
	 * <span lang="ja">TransitionHelper オブジェクトを実行した場合に TransitionEvent オブジェクトが送出されます。</span>
	 * <span lang="en">When the TransitionHelper object is executed, the TransitionEvent object is sent.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class TransitionEvent extends Event {
		
		/**
		 * <span lang="ja">transitionProgress イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TransitionEvent.TRANSITION_PROGRESS constant defines the value of the type property of an transitionProgress event object.</span>
		 */
		public static const TRANSITION_PROGRESS:String = "transitionProgress";
		
		/**
		 * <span lang="ja">transitionInDone イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TransitionEvent.TRANSITION_IN_DONE constant defines the value of the type property of an transitionInDone event object.</span>
		 */
		public static const TRANSITION_IN_DONE:String = "transitionInDone";
		
		/**
		 * <span lang="ja">transitionOutDone イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TransitionEvent.TRANSITION_OUT_DONE constant defines the value of the type property of an transitionOutDone event object.</span>
		 */
		public static const TRANSITION_OUT_DONE:String = "transitionOutDone";
		
		/**
		 * <span lang="ja">allTransitionsInDone イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TransitionEvent.ALL_TRANSITIONS_IN_DONE constant defines the value of the type property of an allTransitionsInDone event object.</span>
		 */
		public static const ALL_TRANSITIONS_IN_DONE:String = "allTransitionsInDone";
		
		/**
		 * <span lang="ja">allTransitionsOutDone イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TransitionEvent.ALL_TRANSITIONS_OUT_DONE constant defines the value of the type property of an allTransitionsOutDone event object.</span>
		 */
		public static const ALL_TRANSITIONS_OUT_DONE:String = "allTransitionsOutDone";
		
		
		
		
		
		/**
		 * <span lang="ja">新しい TransitionEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new TransitionEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">TransitionEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as TransitionEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">TransitionEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the TransitionEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">TransitionEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the TransitionEvent object can be canceled. The default values is false.</span>
		 */
		public function TransitionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">TransitionEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an TransitionEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい TransitionEvent インスタンスです。</span>
		 * <span lang="en">A new TransitionEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new TransitionEvent( type, bubbles, cancelable );
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
			return formatToString( "TransitionEvent", "type", "bubbles", "cancelable" );
		}
	}
}
