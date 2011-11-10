/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.net {
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.events.EventIntegrator;
	import jp.nium.events.IEventIntegrator;
	import jp.nium.utils.ObjectUtil;
	
	use namespace flash_proxy;
	
	/**
	 * <span lang="ja">クエリの値が変更された瞬間に送出されます。</span>
	 * <span lang="en">Dispatch when the value of the query changed.</span>
	 * 
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event( name="change", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">Query クラスは、URL のクエリパラメータを ActionScript で制御しやすい形に表現したモデルクラスです。</span>
	 * <span lang="en">Query class is a model class which express the query parameter of the URL that can handle by ActionScript easily.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public dynamic class Query extends Proxy implements IEventIntegrator {
		
		/**
		 * プロパティ名を判別する正規表現を取得します。
		 */
		private static const _NAME_REGEXP:RegExp = new RegExp( "^[a-z][a-z0-9-_]*$", "i" );
		
		
		
		
		
		/**
		 * 読み取り専用かどうかを取得します。
		 */
		private var _readOnly:Boolean = false;
		
		/**
		 * 設定されているプロパティを取得します。
		 */
		private var _properties:Object = {};
		
		/**
		 * 設定されているプロパティを配列で取得します。
		 */
		private var _propertyList:Array = [];
		
		/**
		 * EventIntegrator インスタンスを取得します。
		 */
		private var _integrator:EventIntegrator = new EventIntegrator();
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Query インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Query object.</span>
		 * 
		 * @param readOnly
		 * <span lang="ja">インスタンスを読み取り専用にするかどうかです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">初期値となるオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Query( readOnly:Boolean = false, initObject:Object = null ) {
			// 初期値を設定する
			for ( var p:String in initObject ) {
				flash_proxy::setProperty( p, initObject[p] );
			}
			
			// 引数を設定する
			_readOnly = readOnly;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Register the event listener object into the EventIntegrator instance to get the event notification.
		 * If the registered listener by this method removed by using removeEventListener() method, it can re-register using restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en">The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en">Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en">The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</span>
		 * @param useWeakReference
		 * <span lang="ja">リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</span>
		 * <span lang="en">Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</span>
		 */
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_integrator.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <span lang="ja">イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーは、IEventIntegrator インスタンスの管理外となるため、removeEventListener() メソッドで削除した場合にも、restoreRemovedListeners() メソッドで再登録させることができません。</span>
		 * <span lang="en">Register the event listener object into the EventIntegrator instance to get the event notification.
		 * The listener registered by this method can not re-registered by using restoreRemovedListeners() method in case it is removed by using removeEventListener() method, because it is not managed by IEventIntegrator instance</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en">The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en">Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en">The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</span>
		 * @param useWeakReference
		 * <span lang="ja">リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</span>
		 * <span lang="en">Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</span>
		 */
		public function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_integrator.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can re-register by restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 */
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_integrator.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができません。</span>
		 * <span lang="en">Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can not re-register by restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 */
		public function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_integrator.completelyRemoveEventListener( type, listener, useCapture );
		}
		
		/**
		 * <span lang="ja">イベントをイベントフローに送出します。</span>
		 * <span lang="en">Dispatches an event into the event flow.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</span>
		 * <span lang="en">The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</span>
		 * @return
		 * <span lang="ja">値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</span>
		 * <span lang="en">A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</span>
		 */
		public function dispatchEvent( event:Event ):Boolean {
			return _integrator.dispatchEvent( event );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</span>
		 * <span lang="en">Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type is registered; false otherwise.</span>
		 */
		public function hasEventListener( type:String ):Boolean {
			return _integrator.hasEventListener( type );
		}
		
		/**
		 * <span lang="ja">指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</span>
		 * <span lang="en">Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type will be triggered; false otherwise.</span>
		 */
		public function willTrigger( type:String ):Boolean {
			return _integrator.willTrigger( type );
		}
		
		/**
		 * <span lang="ja">addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</span>
		 * <span lang="en">Remove the whole event listener registered via addEventListener() method.
		 * If do not remove completely, removed event listener can restore by restoreRemovedListeners() method.</span>
		 * 
		 * @param completely
		 * <span lang="ja">情報を完全に削除するかどうかです。</span>
		 * <span lang="en">If it removes the information completely.</span>
		 */
		public function removeAllListeners( completely:Boolean = false ):void {
			_integrator.removeAllListeners( completely );
		}
		
		/**
		 * <span lang="ja">removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</span>
		 * <span lang="en">Re-register the whole event listener removed via removeEventListener() or removeAllListeners() method.</span>
		 */
		public function restoreRemovedListeners():void {
			_integrator.restoreRemovedListeners();
		}
		
		/**
		 * <span lang="ja">指定された Query オブジェクトが、対象 Query オブジェクトと同一内容かどうかを返します。</span>
		 * <span lang="en">Returns if the specified Query object has the same content with the Query object.</span>
		 * 
		 * @param sceneId
		 * <span lang="ja">テストする Query オブジェクトです。</span>
		 * <span lang="en">The Query object to test.</span>
		 * @return
		 * <span lang="ja">同一内容の Query オブジェクトであれば true に、それ以外の場合は false になります。</span>
		 * <span lang="en">Returns true if the Query object has same content, otherwise return false.</span>
		 */
		public function equals( query:Query ):Boolean {
			var props1:Array = [];
			var props2:Array = [];
			
			// 配列化する
			for ( var p1:String in _properties ) {
				props1.push( p1 );
			}
			for ( var p2:String in query._properties ) {
				props2.push( p2 );
			}
			
			// 長さが違っていれば
			if ( props1.length != props2.length ) { return false; }
			
			// 内容が違っていれば
			var l:int = props1.length;
			for ( var i:int = 0; i < l; i++ ) {
				var name:String = props1[i];
				if( _properties[name] != query._properties[name] ) { return false; };
			}
			
			return true;
		}
		
		/**
		 * <span lang="ja">Query インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Query subclass.</span>
		 * 
		 * @param readOnly
		 * <span lang="ja">インスタンスを読み取り専用にするかどうかです。</span>
		 * <span lang="en">If the instance is read only or not.</span>
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Query インスタンスです。</span>
		 * <span lang="en">A new SceneEvent object that is identical to the original.</span>
		 */
		public function clone( readOnly:Boolean = false ):Query {
			return new Query( readOnly, this );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return ObjectUtil.toQueryString( this );
		}
		
		/**
		 * @private
		 */
		flash_proxy override function callProperty( methodName:*, ... args:Array ):* {
			methodName;
			return null;
		}
		
		/**
		 * @private
		 */
		flash_proxy override function getProperty( name:* ):* {
			return _properties[name];
		}
		
		/**
		 * @private
		 */
		flash_proxy override function setProperty( name:*, value:* ):void {
			// 読み取り専用の値を変更しようとしたら
			if ( _readOnly ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1074", "Query", name ) ); }
			if ( name && !_NAME_REGEXP.test( name ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			
			switch ( true ) {
				case value is Boolean	:
				case value is Number	:
				case value is int		:
				case value is uint		:
				case value is String	: { break; }
				default					: { value = String( value ); }
			}
			
			// 現在の値を保存する
			var cache:* = _properties[name];
			
			// 値を設定する
			_properties[name] = value;
			
			// 変更されていれば
			if ( cache != value ) {
				// イベントを送出する
				_integrator.dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		/**
		 * @private
		 */
		flash_proxy override function deleteProperty( name:* ):Boolean {
			// 読み取り専用の値を消去しようとしたら
			if ( _readOnly ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1074", "Query", name ) ); }
			
			return delete _properties[name];
		}
		
		/**
		 * @private
		 */
		flash_proxy override function hasProperty( name:* ):Boolean {
			return name in _properties;
		}
		
		/**
		 * @private
		 */
		flash_proxy override function nextNameIndex( index:int ):int {
			if ( index == 0 ) {
				_propertyList = [];
				for ( var p:* in _properties ) {
					_propertyList.push( p );
				}
			}
			
			return ( index < _propertyList.length ) ? index + 1 : 0;
		}
		
		/**
		 * @private
		 */
		flash_proxy override function nextName( index:int ):String {
			return _propertyList[index - 1];
		}
		
		/**
		 * @private
		 */
		flash_proxy override function nextValue( index:int ):* {
			return _properties[_propertyList[index - 1]];
		}
	}
}
