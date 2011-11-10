/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.external {
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.Security;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <span lang="ja">BrowserInterface クラスは、SWF ファイルを再生中のブラウザと、JavaScript を使用して通信を行うクラスです。
	 * BrowserInterface クラスを直接インスタンス化することはできません。
	 * new BrowserInterface() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The BrowserInterface class communicates with the browser which are playing the SWF file, using JavaScript.
	 * BrowserInterface class can not instanciate directly.
	 * When call the new BrowserInterface() constructor, the ArgumentError exception will be thrown.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public final class BrowserInterface {
		
		// 初期化する
		( function():void {
			// プレイヤー種別が対応していなければ終了する
			switch ( Capabilities.playerType ) {
				case "ActiveX"		:
				case "PlugIn"		: { break; }
				case "Desktop"		:
				case "External"		:
				case "StandAlone"	: { return; }
			}
			
			// セキュリティサンドボックスが対応していなければ終了する
			switch ( Security.sandboxType ) {
				case Security.REMOTE				:
				case Security.LOCAL_TRUSTED			: { break; }
				case Security.LOCAL_WITH_FILE		:
				case Security.LOCAL_WITH_NETWORK	: { return; }
				}
			
			// ExternalInterface が有効でなければ終了する
			if ( !ExternalInterface.available ) { return; }
			if ( !ExternalInterface.objectID ) { return; }
			
			// 実際にスクリプトが実行できなければ終了する
			try {
				if ( ExternalInterface.call( 'function() { return "enabled"; }' ) != "enabled" ) { return; }
			}
			catch ( e:Error ) {
				return;
			}
			
			// 有効化する
			_enabled = true;
			
			// ブラウザ情報を取得する
			_appCodeName = call( 'function() { return navigator.appCodeName; }' );
			_appName = call( 'function() { return navigator.appName; }' );
			_appVersion = call( 'function() { return navigator.appVersion; }' );
			_platform = call( 'function() { return navigator.platform; }' );
			_userAgent = call( 'function() { return navigator.userAgent; }' );
		} )();
		
		/**
		 * <span lang="ja">Flash IDE との JSFL 通信が可能かどうかを取得します。</span>
		 * <span lang="en">Returns if it is able to communicate with Flash IDE via JSFL.</span>
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = false;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザのコード名を取得します。</span>
		 * <span lang="en">Returns the code name of the browser which playing the SWF file.</span>
		 */
		public static function get appCodeName():String { return _appCodeName; }
		private static var _appCodeName:String;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザからアプリケーション名を取得します。</span>
		 * <span lang="en">Get the application name from the browser which playing the SWF file.</span>
		 */
		public static function get appName():String { return _appName; }
		private static var _appName:String;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザからバージョンと機種名を取得します。</span>
		 * <span lang="en">Get the version and machine name from the browser which playing the SWF file.</span>
		 */
		public static function get appVersion():String { return _appVersion; }
		private static var _appVersion:String;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザからプラットフォーム名を取得します。</span>
		 * <span lang="en">Get the platform name from the browser which playing the SWF file.</span>
		 */
		public static function get platform():String { return _platform; }
		private static var _platform:String;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザからエージェント名を取得します。</span>
		 * <span lang="en">Get the agent name from the browser which playing the SWF file.</span>
		 */
		public static function get userAgent():String { return _userAgent; }
		private static var _userAgent:String;
		
		/**
		 * <span lang="ja">SWF ファイルを再生中のブラウザから URL を取得します。</span>
		 * <span lang="en">Get the URL from the browser which playing the SWF file.</span>
		 */
		public static function get locationHref():String { return call( "function() { return window.location.href; }" ); }
		
		/**
		 * EventIntegrator インスタンスを取得します。
		 */
		private static var _integrator:EventIntegrator;
		
		
		
		
		
		/**
		 * @private
		 */
		public function BrowserInterface() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "BrowserInterface" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">Flash Player コンテナで公開されている関数を呼び出し、必要に応じてパラメータを渡します。</span>
		 * <span lang="en">Call the function which the Flash Player container opens and pass the parameter if needed.</span>
		 * 
		 * @param funcName
		 * <span lang="ja">実行したい関数名です。</span>
		 * <span lang="en">The name of the function to execute.</span>
		 * @param args
		 * <span lang="ja">引数に指定したい配列です。</span>
		 * <span lang="en">The array to specify as argument.</span>
		 * @return
		 * <span lang="ja">関数の戻り値を返します。</span>
		 * <span lang="en">The return value of the function.</span>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			if ( !enabled ) { return ""; }
			
			args.unshift( funcName );
			var result:String = ExternalInterface.call.apply( null, args );
			
			return StringUtil.toProperType( result );
		}
		
		/**
		 * <span lang="ja">ActionScript メソッドをコンテナから呼び出し可能なものとして登録します。</span>
		 * <span lang="en">Register the ActionScript method as callable from the container.</span>
		 * 
		 * @param funcName
		 * <span lang="ja">コンテナが関数を呼び出すことができる名前です。</span>
		 * <span lang="en">The name that the container can function call.</span>
		 * @param closure
		 * <span lang="ja">呼び出す関数閉包です。これは独立した関数にすることも、オブジェクトインスタンスのメソッドを参照するメソッド閉包とすることもできます。メソッド閉包を渡すことで、特定のオブジェクトインスタンスのメソッドでコールバックを実際にダイレクトできます。</span>
		 * <span lang="en">The function closure to call. This can be an independent function or method closure which refer the method of the object instance. By passing the method closure, it is actually able to direct the callback by method of the perticular object instance.</span>
		 */
		public static function addCallback( funcName:String, closure:Function ):void {
			if ( !enabled ) { return; }
			
			ExternalInterface.addCallback( funcName, closure );
		}
		
		/**
		 * <span lang="ja">JavaScript を使用したアラートを表示します。</span>
		 * <span lang="en">Displays the alert using JavaScript.</span>
		 * 
		 * @param messages
		 * <span lang="ja">出力したいストリングです。</span>
		 * <span lang="en">The strings to display.</span>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = messages.join( " " );
			
			trace( "BrowserInterface.alert() :", message );
			
			call( "function() { alert( \"" + message + "\" ); }" );
		}
		
		/**
		 * <span lang="ja">JavaScript を使用した問い合わせダイアログを表示します。</span>
		 * <span lang="en">Displays the inquiry dialog using JavaScript.</span>
		 * 
		 * @param messages
		 * <span lang="ja">出力したいストリングです。</span>
		 * <span lang="en">The strings to display.</span>
		 * @return
		 * <span lang="ja">ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</span>
		 * <span lang="en">Returns true when the user clicked "OK" and false when clicked "Cancel".</span>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = messages.join( " " );
			
			trace( "BrowserInterface.confirm() :", message );
			
			return !!StringUtil.toProperType( call( "function() { alert( \"" + message + "\" ); }" ) );
		}
		
		/**
		 * <span lang="ja">ブラウザを再読み込みします。</span>
		 * <span lang="en">Reload the browser.</span>
		 */
		public static function reload():void {
			call( "function() { window.location.reload(); }" );
		}
		
		/**
		 * <span lang="ja">ブラウザの印刷ダイアログを表示します。</span>
		 * <span lang="en">Displays the print dialog of the browser.</span>
		 */
		public static function print():void {
			call( "function() { window.print(); }" );
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
		public static function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
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
		public static function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
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
		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
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
		public static function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
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
		public static function dispatchEvent( event:Event ):Boolean {
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
		public static function hasEventListener( type:String ):Boolean {
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
		public static function willTrigger( type:String ):Boolean {
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
		public static function removeAllListeners( completely:Boolean = false ):void {
			_integrator.removeAllListeners( completely );
		}
		
		/**
		 * <span lang="ja">removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</span>
		 * <span lang="en">Re-register the whole event listener removed via removeEventListener() or removeAllListeners() method.</span>
		 */
		public static function restoreRemovedListeners():void {
			_integrator.restoreRemovedListeners();
		}
	}
}
