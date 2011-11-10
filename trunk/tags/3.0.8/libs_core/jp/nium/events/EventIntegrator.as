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
package jp.nium.events {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import jp.nium.core.namespaces.nium_internal;
	import jp.nium.events.IEventIntegrator;
	
	use namespace nium_internal;
	
	/*======================================================================*//**
	 * <p>EventIntegrator クラスは、IEventIntegrator インターフェイスを実装した、EventDispatcher クラスのサブクラスです。
	 * EventDispatcher クラスを拡張して、イベントをより統合的に扱うことができるようになります。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EventIntegrator extends EventDispatcher implements IEventIntegrator {
		
		/*======================================================================*//**
		 * 登録したイベントリスナー情報を取得します。
		 */
		private var _listeners:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 
		 */
		private var _stack:Array = [];
		
		/*======================================================================*//**
		 * 登録したイベントリスナー数を取得します。
		 */
		private var _numListeners:int = 0;
		
		/*======================================================================*//**
		 * 実際に使用する関数を取得します。
		 */
		private var _addEventListener:Function;
		private var _removeEventListener:Function;
		private var _hasEventListener:Function;
		private var _willTrigger:Function;
		private var _dispatchEvent:Function;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい EventIntegrator インスタンスを作成します。</p>
		 * <p>Creates a new EventIntegrator object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param integrator
		 * 	<p>EventIntegrator インスタンスに送出されるイベントのターゲットオブジェクトです。</p>
		 * 	<p>The target object for events dispatched to the EventIntegrator object.</p>
		 */
		public function EventIntegrator( integrator:IEventIntegrator = null ) {
			// スーパークラスを初期化する
			super( integrator );
			
			// 初期化する
			nium_internal::initialize( {
				addEventListener		:super.addEventListener,
				removeEventListener		:super.removeEventListener,
				hasEventListener		:super.hasEventListener,
				willTrigger				:super.willTrigger,
				dispatchEvent			:super.dispatchEvent
			} );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal function initialize( initObject:Object ):void {
			_addEventListener = initObject.addEventListener;
			_removeEventListener = initObject.removeEventListener;
			_hasEventListener = initObject.hasEventListener;
			_willTrigger = initObject.willTrigger;
			_dispatchEvent = initObject.dispatchEvent;
			
			// スタックが存在すれば再登録する
			while ( _stack.length > 0 ) {
				var array:Array = _stack.shift() as Array;
				var funcName:String = array.shift();
				this[funcName].apply( this, array );
			}
		}
		
		/*======================================================================*//**
		 * 
		 */
		private function _registerListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			// イベントリスナー情報を保存する
			_listeners[++_numListeners] = {
				id					:_numListeners,
				type				:type,
				listener			:listener,
				useCapture			:useCapture,
				priority			:priority,
				useWeakReference	:useWeakReference
			};
		}
		
		/*======================================================================*//**
		 * 
		 */
		private function _unregisterListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			// イベントリスナー情報を走査する
			for each ( var o:Object in _listeners ) {
				// 設定値が違っていれば次へ
				if ( o.type != type ) { continue; }
				if ( o.listener != listener ) { continue; }
				if ( o.useCapture != useCapture ) { continue; }
				
				// 登録情報を削除する
				delete _listeners[o.id];
				break;
			}
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			// 登録を削除する
			_unregisterListener( type, listener, useCapture );
			
			// 登録する
			_registerListener( type, listener, useCapture, priority, useWeakReference );
			
			// メソッドが正しく登録されていなければ
			if ( addEventListener == _addEventListener ) {
				_stack.push( [ "addEventListener", type, listener, useCapture, priority, useWeakReference ] );
				return;
			}
			
			// イベントリスナーを登録する
			_addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーは、IEventIntegrator インスタンスの管理外となるため、removeEventListener() メソッドで削除した場合にも、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			// イベントリスナーを登録する
			_addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			// メソッドが正しく登録されていなければ
			if ( removeEventListener == _removeEventListener ) {
				_stack.push( [ "removeEventListener", type, listener, useCapture ] );
				return;
			}
			
			// イベントリスナーを削除する
			_removeEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			// 登録を削除する
			_unregisterListener( type, listener, useCapture );
			
			// イベントリスナーを削除する
			_removeEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>イベントをイベントフローに送出します。</p>
		 * <p>Dispatches an event into the event flow.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</p>
		 * 	<p>The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</p>
		 * @return
		 * 	<p>値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</p>
		 * 	<p>A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</p>
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			return _dispatchEvent( event );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</p>
		 * <p>Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type is registered; false otherwise.</p>
		 */
		public override function hasEventListener( type:String ):Boolean {
			return _hasEventListener( type );
		}
		
		/*======================================================================*//**
		 * <p>指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</p>
		 * <p>Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type will be triggered; false otherwise.</p>
		 */
		public override function willTrigger( type:String ):Boolean {
			return _willTrigger( type );
		}
		
		/*======================================================================*//**
		 * <p>addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>情報を完全に削除するかどうかです。</p>
		 * 	<p></p>
		 */
		public function removeAllListeners( completely:Boolean = false ):void {
			// イベントリスナー情報を走査する
			for each ( var o:Object in _listeners ) {
				// イベントリスナーを解除する
				_removeEventListener( o.type, o.listener, o.useCapture );
			}
			
			// 完全に消去するなら初期化する
			if ( completely ) {
				_listeners = new Dictionary( true );
			}
		}
		
		/*======================================================================*//**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function restoreRemovedListeners():void {
			// イベントリスナー情報を走査する
			for each ( var o:Object in _listeners ) {
				// イベントリスナーを登録する
				_addEventListener( o.type, o.listener, o.useCapture, o.priority, o.useWeakReference );
			}
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
			return "[object EventIntegrator]";
		}
	}
}









