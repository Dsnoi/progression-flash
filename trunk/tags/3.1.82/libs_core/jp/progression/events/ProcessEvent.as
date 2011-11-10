/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.events {
	import flash.events.Event;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <span lang="ja">SceneManager オブジェクトが処理を実行、完了、中断、等を行った場合に ProcessEvent オブジェクトが送出されます。
	 * 通常は、Progression オブジェクトを経由してイベントを受け取ります。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ProcessEvent extends Event {
		
		/**
		 * <span lang="ja">processStart イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_START constant defines the value of the type property of an processStart event object.</span>
		 */
		public static const PROCESS_START:String = "processStart";
		
		/**
		 * <span lang="ja">processComplete イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_COMPLETE constant defines the value of the type property of an processComplete event object.</span>
		 */
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * <span lang="ja">processInterrupt イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_INTERRUPT constant defines the value of the type property of an processInterrupt event object.</span>
		 */
		public static const PROCESS_INTERRUPT:String = "processInterrupt";
		
		/**
		 * <span lang="ja">processScene イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_SCENE constant defines the value of the type property of an processScene event object.</span>
		 */
		public static const PROCESS_SCENE:String = "processScene";
		
		/**
		 * <span lang="ja">processEvent イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_EVENT constant defines the value of the type property of an processEvent event object.</span>
		 */
		public static const PROCESS_EVENT:String = "processEvent";
		
		/**
		 * <span lang="ja">processError イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The ProcessEvent.PROCESS_ERROR constant defines the value of the type property of an processError event object.</span>
		 */
		public static const PROCESS_ERROR:String = "processError";
		
		
		
		
		
		/**
		 * <span lang="ja">イベント発生時のカレントシーンを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get scene():SceneObject { return _scene; }
		private var _scene:SceneObject;
		
		/**
		 * <span lang="ja">イベント発生時のカレントイベントタイプを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventType():String { return _eventType; }
		private var _eventType:String;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ProcessEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ProcessEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">ProcessEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as ProcessEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">ProcessEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the ProcessEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">ProcessEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the ProcessEvent object can be canceled. The default values is false.</span>
		 * @param scene
		 * <span lang="ja">イベント発生時のカレントシーンです。</span>
		 * <span lang="en"></span>
		 * @param eventType
		 * <span lang="ja">イベント発生時のカレントイベントタイプです。</span>
		 * <span lang="en"></span>
		 */
		public function ProcessEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, scene:SceneObject = null, eventType:String = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_scene = scene;
			_eventType = eventType;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">ProcessEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an ProcessEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい ProcessEvent インスタンスです。</span>
		 * <span lang="en">A new ProcessEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new ProcessEvent( type, bubbles, cancelable, _scene, _eventType );
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
			return formatToString( "ProcessEvent", "type", "bubbles", "cancelable", "scene", "eventType" );
		}
	}
}
