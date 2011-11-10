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
	public class ComponentEvent extends Event {
		
		/*======================================================================*//**
		 * <p>componentAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_ADDED constant defines the value of the type property of an componentAdded event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMPONENT_ADDED:String = "componentAdded";
		
		/*======================================================================*//**
		 * <p>componentRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ComponentEvent.COMPONENT_REMOVED constant defines the value of the type property of an componentRemoved event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMPONENT_REMOVED:String = "componentRemoved";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ComponentEvent インスタンスを作成します。</p>
		 * <p>Creates a new ComponentEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>ComponentEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as ComponentEvent.type.</p>
		 * @param bubbles
		 * 	<p>ComponentEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the ComponentEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>ComponentEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the ComponentEvent object can be canceled. The default values is false.</p>
		 */
		public function ComponentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ComponentEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ComponentEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい ComponentEvent インスタンスです。</p>
		 * 	<p>A new ComponentEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ComponentEvent( type, bubbles, cancelable );
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
			return formatToString( "ComponentEvent", "type", "bubbles", "cancelable" );
		}
	}
}









