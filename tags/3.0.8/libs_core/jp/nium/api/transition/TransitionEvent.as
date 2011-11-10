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
	import flash.events.Event;
	
	/*======================================================================*//**
	 * <p>TransitionHelper オブジェクトを実行した場合に TransitionEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class TransitionEvent extends Event {
		
		/*======================================================================*//**
		 * <p>transitionProgress イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TransitionEvent.TRANSITION_PROGRESS constant defines the value of the type property of an transitionProgress event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TRANSITION_PROGRESS:String = "transitionProgress";
		
		/*======================================================================*//**
		 * <p>transitionInDone イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TransitionEvent.TRANSITION_IN_DONE constant defines the value of the type property of an transitionInDone event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TRANSITION_IN_DONE:String = "transitionInDone";
		
		/*======================================================================*//**
		 * <p>transitionOutDone イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TransitionEvent.TRANSITION_OUT_DONE constant defines the value of the type property of an transitionOutDone event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const TRANSITION_OUT_DONE:String = "transitionOutDone";
		
		/*======================================================================*//**
		 * <p>allTransitionsInDone イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TransitionEvent.ALL_TRANSITIONS_IN_DONE constant defines the value of the type property of an allTransitionsInDone event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ALL_TRANSITIONS_IN_DONE:String = "allTransitionsInDone";
		
		/*======================================================================*//**
		 * <p>allTransitionsOutDone イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TransitionEvent.ALL_TRANSITIONS_OUT_DONE constant defines the value of the type property of an allTransitionsOutDone event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ALL_TRANSITIONS_OUT_DONE:String = "allTransitionsOutDone";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい TransitionEvent インスタンスを作成します。</p>
		 * <p>Creates a new TransitionEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>TransitionEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as TransitionEvent.type.</p>
		 * @param bubbles
		 * 	<p>TransitionEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the TransitionEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>TransitionEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the TransitionEvent object can be canceled. The default values is false.</p>
		 */
		public function TransitionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>TransitionEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an TransitionEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい TransitionEvent インスタンスです。</p>
		 * 	<p>A new TransitionEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new TransitionEvent( type, bubbles, cancelable );
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
			return formatToString( "TransitionEvent", "type", "bubbles", "cancelable" );
		}
	}
}









