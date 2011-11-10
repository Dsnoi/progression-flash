/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.api.transition {
	import fl.transitions.TransitionManager;
	import flash.display.MovieClip;
	
	/*======================================================================*//**
	 * <p>トランジション処理が実行される毎に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_PROGRESS
	 */
	[Event( name="transitionProgress", type="jp.nium.api.transition.TransitionEvent" )]
	
	/*======================================================================*//**
	 * <p>IN 方向のトランジション処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_IN_DONE
	 */
	[Event( name="transitionInDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/*======================================================================*//**
	 * <p>OUT 方向のトランジション処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.transition.TransitionEvent.TRANSITION_OUT_DONE
	 */
	[Event( name="transitionOutDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/*======================================================================*//**
	 * <p>IN 方向の全てのトランジション処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.transition.TransitionEvent.ALL_TRANSITIONS_IN_DONE
	 */
	[Event( name="allTransitionsInDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/*======================================================================*//**
	 * <p>OUT 方向の全てのトランジション処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.transition.TransitionEvent.ALL_TRANSITIONS_OUT_DONE
	 */
	[Event( name="allTransitionsOutDone", type="jp.nium.api.transition.TransitionEvent" )]
	
	/*======================================================================*//**
	 * <p>TransitionHelper クラスは、TransitionManager クラスの機能を拡張したアダプタクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class TransitionHelper extends TransitionManager {
		
		/*======================================================================*//**
		 * <p>新しい TransitionHelper インスタンスを作成します。</p>
		 * <p>Creates a new TransitionHelper object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>Transition を適用する対象 MovieClip インスタンスです。</p>
		 * 	<p></p>
		 */
		public function TransitionHelper( target:MovieClip ) {
			// スーパークラスを初期化する
			super( target );
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
			return "[object TransitionHelper]";
		}
	}
}









