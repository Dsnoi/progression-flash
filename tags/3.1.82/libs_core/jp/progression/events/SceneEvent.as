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
	 * <span lang="ja">対象の SceneObject オブジェクトがシーンイベントフロー上で処理ポイントに位置した場合や、状態が変化した場合に SceneEvent オブジェクトが送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneEvent extends Event {
		
		/**
		 * <span lang="ja">load イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.LOAD constant defines the value of the type property of an load event object.</span>
		 */
		public static const LOAD:String = "load";
		
		/**
		 * <span lang="ja">unload イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.UNLOAD constant defines the value of the type property of an unload event object.</span>
		 */
		public static const UNLOAD:String = "unload";
		
		/**
		 * <span lang="ja">init イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.INIT constant defines the value of the type property of an init event object.</span>
		 */
		public static const INIT:String = "init";
		
		/**
		 * <span lang="ja">goto イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.GOTO constant defines the value of the type property of an goto event object.</span>
		 */
		public static const GOTO:String = "goto";
		
		/**
		 * <span lang="ja">descend イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.DESCEND constant defines the value of the type property of an descend event object.</span>
		 */
		public static const DESCEND:String = "descend";
		
		/**
		 * <span lang="ja">ascend イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.ASCEND constant defines the value of the type property of an ascend event object.</span>
		 */
		public static const ASCEND:String = "ascend";
		
		/**
		 * <span lang="ja">sceneAdded イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_ADDED constant defines the value of the type property of an sceneAdded event object.</span>
		 */
		public static const SCENE_ADDED:String = "sceneAdded";
		
		/**
		 * <span lang="ja">sceneAddedToRoot イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_ADDED_TO_ROOT constant defines the value of the type property of an sceneAddedToRoot event object.</span>
		 */
		public static const SCENE_ADDED_TO_ROOT:String = "sceneAddedToRoot";
		
		/**
		 * <span lang="ja">sceneRemoved イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_REMOVED constant defines the value of the type property of an sceneRemoved event object.</span>
		 */
		public static const SCENE_REMOVED:String = "sceneRemoved";
		
		/**
		 * <span lang="ja">sceneRemovedFromRoot イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_REMOVED_FROM_ROOT constant defines the value of the type property of an sceneRemovedFromRoot event object.</span>
		 */
		public static const SCENE_REMOVED_FROM_ROOT:String = "sceneRemovedFromRoot";
		
		/**
		 * <span lang="ja">sceneTitle イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_TITLE constant defines the value of the type property of an sceneTitle event object.</span>
		 */
		public static const SCENE_TITLE:String = "sceneTitle";
		
		/**
		 * <span lang="ja">sceneStateChange イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_STATE_CHANGE constant defines the value of the type property of an sceneStateChange event object.</span>
		 */
		public static const SCENE_STATE_CHANGE:String = "sceneStateChange";
		
		/**
		 * <span lang="ja">sceneQuery イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The SceneEvent.SCENE_QUERY constant defines the value of the type property of an sceneQuery event object.</span>
		 */
		public static const SCENE_QUERY:String = "sceneQuery";
		
		
		
		
		
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
		 * <span lang="ja">新しい SceneEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new SceneEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">SceneEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as SceneEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">SceneEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the SceneEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">SceneEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the SceneEvent object can be canceled. The default values is false.</span>
		 * @param scene
		 * <span lang="ja">イベント発生時のカレントシーンです。</span>
		 * <span lang="en"></span>
		 * @param eventType
		 * <span lang="ja">イベント発生時のカレントイベントタイプです。</span>
		 * <span lang="en"></span>
		 */
		public function SceneEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, scene:SceneObject = null, eventType:String = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_scene = scene;
			_eventType = eventType;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">SceneEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an SceneEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい SceneEvent インスタンスです。</span>
		 * <span lang="en">A new SceneEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new SceneEvent( type, bubbles, cancelable, _scene, _eventType );
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
			return formatToString( "SceneEvent", "type", "bubbles", "cancelable", "scene", "eventType" );
		}
	}
}
