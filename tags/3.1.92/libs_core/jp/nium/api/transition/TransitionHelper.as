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
	import fl.transitions.TransitionManager;
	import flash.display.MovieClip;
	
	/**
	 * <span lang="ja">トランジション処理が実行される毎に送出されます。</span>
	 * <span lang="en">Dispatch whenever the transition processing is executed.</span>
	 * 
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_PROGRESS
	 */
	[Event( name="transitionProgress", type="jp.nium.api.transition.TransitionEvent" )]
	
	/**
	 * <span lang="ja">IN 方向のトランジション処理が完了した場合に送出されます。</span>
	 * <span lang="en">Dispatch when the transition processing in the IN direction is completed.</span>
	 * 
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_IN_DONE
	 */
	[Event( name="transitionInDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/**
	 * <span lang="ja">OUT 方向のトランジション処理が完了した場合に送出されます。</span>
	 * <span lang="en">Dispatch when the transition processing in the OUT direction is completed.</span>
	 * 
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_OUT_DONE
	 */
	[Event( name="transitionOutDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/**
	 * <span lang="ja">IN 方向の全てのトランジション処理が完了した場合に送出されます。</span>
	 * <span lang="en">Dispatch when the whole transition processing in the IN direction are completed.</span>
	 * 
	 * @eventType jp.nium.api.transition.TransitionEvent.ALL_TRANSITIONS_IN_DONE
	 */
	[Event( name="allTransitionsInDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/**
	 * <span lang="ja">OUT 方向の全てのトランジション処理が完了した場合に送出されます。</span>
	 * <span lang="en">Dispatch when the whole transition processing in the OUT direction are completed.</span>
	 * 
	 * @eventType jp.nium.api.transition.TransitionEvent.ALL_TRANSITIONS_OUT_DONE
	 */
	[Event( name="allTransitionsOutDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/**
	 * <span lang="ja">TransitionHelper クラスは、TransitionManager クラスの機能を拡張したアダプタクラスです。</span>
	 * <span lang="en">TransitionHelper class is a adopter class that extends the function of TransitionManager class.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class TransitionHelper extends TransitionManager {
		
		/**
		 * <span lang="ja">新しい TransitionHelper インスタンスを作成します。</span>
		 * <span lang="en">Creates a new TransitionHelper object.</span>
		 * 
		 * @param target
		 * <span lang="ja">Transition を適用する対象 MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to apply Transition.</span>
		 */
		public function TransitionHelper( target:MovieClip ) {
			// スーパークラスを初期化する
			super( target );
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
			return "[object TransitionHelper]";
		}
	}
}
