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
package jp.progression.events {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/*======================================================================*//**
	 * <p>CastButton クラスを継承したオブジェクトで MouseEvent が送出された際に CastMouseEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastMouseEvent extends MouseEvent {
		
		/*======================================================================*//**
		 * <p>castMouseDown イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastMouseEvent.CAST_MOUSE_DOWN constant defines the value of the type property of an castMouseDown event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_MOUSE_DOWN:String = "castMouseDown";
		
		/*======================================================================*//**
		 * <p>castMouseUp イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastMouseEvent.CAST_MOUSE_UP constant defines the value of the type property of an castMouseUp event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_MOUSE_UP:String = "castMouseUp";
		
		/*======================================================================*//**
		 * <p>castRollOver イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastMouseEvent.CAST_ROLL_OVER constant defines the value of the type property of an castRollOver event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_ROLL_OVER:String = "castRollOver";
		
		/*======================================================================*//**
		 * <p>castRollOut イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastMouseEvent.CAST_ROLL_OUT constant defines the value of the type property of an castRollOut event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_ROLL_OUT:String = "castRollOut";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CastMouseEvent インスタンスを作成します。</p>
		 * <p>Creates a new CastMouseEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>CastMouseEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as CastMouseEvent.type.</p>
		 * @param bubbles
		 * 	<p>CastMouseEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CastMouseEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>CastMouseEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CastMouseEvent object can be canceled. The default values is false.</p>
		 * @param localX
		 * 	<p>スプライトを基準とするイベント発生位置の水平座標です。</p>
		 * 	<p>The horizontal coordinate at which the event occurred relative to the containing sprite.</p>
		 * @param localY
		 * 	<p>スプライトを基準とするイベント発生位置の垂直座標です。</p>
		 * 	<p>The vertical coordinate at which the event occurred relative to the containing sprite.</p>
		 * @param relatedObject
		 * 	<p>イベントの影響を受ける補完的な InteractiveObject インスタンスです。たとえば、mouseOut イベントが発生した場合、relatedObject はポインティングデバイスが現在指している表示リストオブジェクトを表します。</p>
		 * 	<p>The complementary InteractiveObject instance that is affected by the event. For example, when a mouseOut event occurs, relatedObject represents the display list object to which the pointing device now points.</p>
		 * @param ctrlKey
		 * 	<p>Ctrl キーがアクティブになっているかどうかを示します。</p>
		 * 	<p>On Windows, indicates whether the Ctrl key is activated. On Mac, indicates whether either the Ctrl key or the Command key is activated.</p>
		 * @param altKey
		 * 	<p>将来の使用のために予約されています。</p>
		 * 	<p>Indicates whether the Alt key is activated (Windows only).</p>
		 * @param shiftKey
		 * 	<p>Shift キーがアクティブになっているかどうかを示します。</p>
		 * 	<p>Indicates whether the Shift key is activated.</p>
		 * @param buttonDown
		 * 	<p>マウスの主ボタンが押されているか押されていないかを示します。</p>
		 * 	<p>Indicates whether the primary mouse button is pressed.</p>
		 * @param delta
		 * 	<p>ユーザーがマウスホイールを 1 目盛り回すごとにスクロールする行数を示します。正の delta 値は上方向へのスクロールを表します。負の値は下方向へのスクロールを表します。一般的な値は 1 ～ 3 の範囲ですが、ホイールの回転が速くなると、delta の値は大きくなります。このパラメータは、CastMouseEvent.mouseWheel イベントのみで使用されます。</p>
		 * 	<p>Indicates how many lines should be scrolled for each unit the user rotates the mouse wheel. A positive delta value indicates an upward scroll; a negative value indicates a downward scroll. Typical values are 1 to 3, but faster rotation may produce larger values. This parameter is used only for the MouseEvent.mouseWheel event.</p>
		 */
		public function CastMouseEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, localX:Number = 0, localY:Number = 0, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0 ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>CastMouseEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CastMouseEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい CastMouseEvent インスタンスです。</p>
		 * 	<p>A new CastMouseEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CastMouseEvent( type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta );
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
			return formatToString( "CastMouseEvent", "type", "bubbles", "cancelable", "localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta" );
		}
	}
}









