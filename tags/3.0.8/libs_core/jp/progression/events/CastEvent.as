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
	import flash.events.Event;
	
	/*======================================================================*//**
	 * <p>ICastObject インターフェイスを実装したオブジェクトが AddChild コマンドや RemoveChild コマンドなどによって表示リストに追加された場合などに CastEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastEvent extends Event {
		
		/*======================================================================*//**
		 * <p>castAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_ADDED constant defines the value of the type property of an castAdded event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_ADDED:String = "castAdded";
		
		/*======================================================================*//**
		 * <p>castRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_REMOVED constant defines the value of the type property of an castRemoved event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_REMOVED:String = "castRemoved";
		
		/*======================================================================*//**
		 * <p>castLoadStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_LOAD_START constant defines the value of the type property of an castLoadStart event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_LOAD_START:String = "castLoadStart";
		
		/*======================================================================*//**
		 * <p>castLoadComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.CAST_LOAD_COMPLETE constant defines the value of the type property of an castLoadComplete event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CAST_LOAD_COMPLETE:String = "castLoadComplete";
		
		/*======================================================================*//**
		 * <p>update イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.UPDATE constant defines the value of the type property of an update event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const UPDATE:String = "update";
		
		/*======================================================================*//**
		 * <p>statusChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.STATUS_CHANGE constant defines the value of the type property of an statusChange event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const STATUS_CHANGE:String = "statusChange";
		
		/*======================================================================*//**
		 * <p>buttonEnabledChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CastEvent.BUTTON_ENABLED_CHANGE constant defines the value of the type property of an buttonEnabledChange event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const BUTTON_ENABLED_CHANGE:String = "buttonEnabledChange";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CastEvent インスタンスを作成します。</p>
		 * <p>Creates a new CastEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>CastEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as CastEvent.type.</p>
		 * @param bubbles
		 * 	<p>CastEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CastEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>CastEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CastEvent object can be canceled. The default values is false.</p>
		 */
		public function CastEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>CastEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CastEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい CastEvent インスタンスです。</p>
		 * 	<p>A new CastEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CastEvent( type, bubbles, cancelable );
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
			return formatToString( "CastEvent", "type", "bubbles", "cancelable" );
		}
	}
}









