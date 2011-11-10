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
	import jp.progression.scenes.SceneObject;
	
	/*======================================================================*//**
	 * <p>SceneManager オブジェクトが処理を実行、完了、中断、等を行った場合に ProcessEvent オブジェクトが送出されます。
	 * 通常は、Progression オブジェクトを経由してイベントを受け取ります。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ProcessEvent extends Event {
		
		/*======================================================================*//**
		 * <p>processStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_START constant defines the value of the type property of an processStart event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_START:String = "processStart";
		
		/*======================================================================*//**
		 * <p>processComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_COMPLETE constant defines the value of the type property of an processComplete event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/*======================================================================*//**
		 * <p>processInterrupt イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_INTERRUPT constant defines the value of the type property of an processInterrupt event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_INTERRUPT:String = "processInterrupt";
		
		/*======================================================================*//**
		 * <p>processScene イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_SCENE constant defines the value of the type property of an processScene event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_SCENE:String = "processScene";
		
		/*======================================================================*//**
		 * <p>processEvent イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_EVENT constant defines the value of the type property of an processEvent event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_EVENT:String = "processEvent";
		
		/*======================================================================*//**
		 * <p>processError イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The ProcessEvent.PROCESS_ERROR constant defines the value of the type property of an processError event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const PROCESS_ERROR:String = "processError";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>イベント発生時のカレントシーンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get scene():SceneObject { return _scene; }
		private var _scene:SceneObject;
		
		/*======================================================================*//**
		 * <p>イベント発生時のカレントイベントタイプを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get eventType():String { return _eventType; }
		private var _eventType:String;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ProcessEvent インスタンスを作成します。</p>
		 * <p>Creates a new ProcessEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>ProcessEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as ProcessEvent.type.</p>
		 * @param bubbles
		 * 	<p>ProcessEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the ProcessEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>ProcessEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the ProcessEvent object can be canceled. The default values is false.</p>
		 * @param scene
		 * 	<p>イベント発生時のカレントシーンです。</p>
		 * 	<p></p>
		 * @param eventType
		 * 	<p>イベント発生時のカレントイベントタイプです。</p>
		 * 	<p></p>
		 */
		public function ProcessEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, scene:SceneObject = null, eventType:String = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_scene = scene;
			_eventType = eventType;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ProcessEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ProcessEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい ProcessEvent インスタンスです。</p>
		 * 	<p>A new ProcessEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new ProcessEvent( type, bubbles, cancelable, _scene, _eventType );
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
			return formatToString( "ProcessEvent", "type", "bubbles", "cancelable", "scene", "eventType" );
		}
	}
}









