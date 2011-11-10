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
	 * <p>対象の SceneObject オブジェクトがシーンイベントフロー上で処理ポイントに位置した場合や、状態が変化した場合に SceneEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneEvent extends Event {
		
		/*======================================================================*//**
		 * <p>load イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.LOAD constant defines the value of the type property of an load event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const LOAD:String = "load";
		
		/*======================================================================*//**
		 * <p>unload イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.UNLOAD constant defines the value of the type property of an unload event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const UNLOAD:String = "unload";
		
		/*======================================================================*//**
		 * <p>init イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.INIT constant defines the value of the type property of an init event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const INIT:String = "init";
		
		/*======================================================================*//**
		 * <p>goto イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.GOTO constant defines the value of the type property of an goto event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const GOTO:String = "goto";
		
		/*======================================================================*//**
		 * <p>descend イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.DESCEND constant defines the value of the type property of an descend event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const DESCEND:String = "descend";
		
		/*======================================================================*//**
		 * <p>ascend イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.ASCEND constant defines the value of the type property of an ascend event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ASCEND:String = "ascend";
		
		/*======================================================================*//**
		 * <p>sceneAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_ADDED constant defines the value of the type property of an sceneAdded event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_ADDED:String = "sceneAdded";
		
		/*======================================================================*//**
		 * <p>sceneAddedToRoot イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_ADDED_TO_ROOT constant defines the value of the type property of an sceneAddedToRoot event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_ADDED_TO_ROOT:String = "sceneAddedToRoot";
		
		/*======================================================================*//**
		 * <p>sceneRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_REMOVED constant defines the value of the type property of an sceneRemoved event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_REMOVED:String = "sceneRemoved";
		
		/*======================================================================*//**
		 * <p>sceneRemovedFromRoot イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_REMOVED_FROM_ROOT constant defines the value of the type property of an sceneRemovedFromRoot event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_REMOVED_FROM_ROOT:String = "sceneRemovedFromRoot";
		
		/*======================================================================*//**
		 * <p>sceneTitle イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_TITLE constant defines the value of the type property of an sceneTitle event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_TITLE:String = "sceneTitle";
		
		/*======================================================================*//**
		 * <p>sceneStateChange イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_STATE_CHANGE constant defines the value of the type property of an sceneStateChange event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_STATE_CHANGE:String = "sceneStateChange";
		
		/*======================================================================*//**
		 * <p>sceneQuery イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The SceneEvent.SCENE_QUERY constant defines the value of the type property of an sceneQuery event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const SCENE_QUERY:String = "sceneQuery";
		
		
		
		
		
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
		 * <p>新しい SceneEvent インスタンスを作成します。</p>
		 * <p>Creates a new SceneEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>SceneEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as SceneEvent.type.</p>
		 * @param bubbles
		 * 	<p>SceneEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the SceneEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>SceneEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the SceneEvent object can be canceled. The default values is false.</p>
		 * @param scene
		 * 	<p>イベント発生時のカレントシーンです。</p>
		 * 	<p></p>
		 * @param eventType
		 * 	<p>イベント発生時のカレントイベントタイプです。</p>
		 * 	<p></p>
		 */
		public function SceneEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, scene:SceneObject = null, eventType:String = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_scene = scene;
			_eventType = eventType;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>SceneEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SceneEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい SceneEvent インスタンスです。</p>
		 * 	<p>A new SceneEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new SceneEvent( type, bubbles, cancelable, _scene, _eventType );
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
			return formatToString( "SceneEvent", "type", "bubbles", "cancelable", "scene", "eventType" );
		}
	}
}









