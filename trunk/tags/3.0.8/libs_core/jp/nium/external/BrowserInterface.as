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
package jp.nium.external {
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.StringUtil;
	
	/*======================================================================*//**
	 * <p>BrowserInterface クラスは、SWF ファイルを再生中のブラウザと、JavaScript を使用して通信を行うクラスです。
	 * BrowserInterface クラスを直接インスタンス化することはできません。
	 * new BrowserInterface() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class BrowserInterface {
		
		/*======================================================================*//**
		 * <p>Flash IDE との JSFL 通信が可能かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = function():Boolean {
			// EventIntegrator を作成する
			_integrator = new EventIntegrator();
			
			// ExternalInterface が有効でなければ false を返す
			if ( !ExternalInterface.available ) { return false; }
			
			// ブラウザで JavaScript を実行できなければ false を返す
			try {
				if ( ExternalInterface.call( "function() { return \"true\"; }" ) != "true" ) { return false; }
			}
			catch ( e:Error ) {
				return false;
			}
			
			// ブラウザ情報を取得する
			var data:Array = call( 'function() { return '
				+ 'navigator.appCodeName + "||||" + '
				+ 'navigator.appCodeName + "||||" + '
				+ 'navigator.appName + "||||" + '
				+ 'navigator.appVersion + "||||" + '
				+ 'navigator.platform + "||||" + '
				+ 'navigator.userAgent;'
				+ ' }' ).split( "||||" );
			_appCodeName = data[0];
			_appName = data[1];
			_appVersion = data[2];
			_platform = data[3];
			_userAgent = data[4];
			
			return true;
		}.apply();
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザのコード名を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get appCodeName():String { return _appCodeName; }
		private static var _appCodeName:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザからアプリケーション名を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get appName():String { return _appName; }
		private static var _appName:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザからバージョンと機種名を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get appVersion():String { return _appVersion; }
		private static var _appVersion:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザからプラットフォーム名を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get platform():String { return _platform; }
		private static var _platform:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザからエージェント名を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get userAgent():String { return _userAgent; }
		private static var _userAgent:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルを再生中のブラウザから URL を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get locationHref():String { return call( "function() { return window.location.href; }" ); }
		
		/*======================================================================*//**
		 * EventIntegrator インスタンスを取得します。
		 */
		private static var _integrator:EventIntegrator;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function BrowserInterface() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "BrowserInterface" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>Flash Player コンテナで公開されている関数を呼び出し、必要に応じてパラメータを渡します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param funcName
		 * 	<p>実行したい関数名です。</p>
		 * 	<p></p>
		 * @param args
		 * 	<p>引数に指定したい配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>関数の戻り値を返します。</p>
		 * 	<p></p>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			if ( !enabled ) { return ""; }
			
			args.unshift( funcName );
			var result:String = ExternalInterface.call.apply( null, args );
			
			return StringUtil.toProperType( result );
		}
		
		/*======================================================================*//**
		 * <p>ActionScript メソッドをコンテナから呼び出し可能なものとして登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param funcName
		 * 	<p>コンテナが関数を呼び出すことができる名前です。</p>
		 * 	<p></p>
		 * @param closure
		 * 	<p>呼び出す関数閉包です。これは独立した関数にすることも、オブジェクトインスタンスのメソッドを参照するメソッド閉包とすることもできます。メソッド閉包を渡すことで、特定のオブジェクトインスタンスのメソッドでコールバックを実際にダイレクトできます。</p>
		 * 	<p></p>
		 */
		public static function addCallback( funcName:String, closure:Function ):void {
			if ( !enabled ) { return; }
			
			ExternalInterface.addCallback( funcName, closure );
		}
		
		/*======================================================================*//**
		 * <p>JavaScript を使用したアラートを表示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param messages
		 * 	<p>出力したいストリングです。</p>
		 * 	<p></p>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = messages.join( " " );
			
			trace( "BrowserInterface.alert() :", message );
			
			call( "function() { alert( \"" + message + "\" ); }" );
		}
		
		/*======================================================================*//**
		 * <p>JavaScript を使用した問い合わせダイアログを表示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param messages
		 * 	<p>出力したいストリングです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</p>
		 * 	<p></p>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = messages.join( " " );
			
			trace( "BrowserInterface.confirm() :", message );
			
			return !!StringUtil.toProperType( call( "function() { alert( \"" + message + "\" ); }" ) );
		}
		
		/*======================================================================*//**
		 * <p>ブラウザを再読み込みします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function reload():void {
			call( "function() { window.location.reload(); }" );
		}
		
		/*======================================================================*//**
		 * <p>ブラウザの印刷ダイアログを表示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function print():void {
			call( "function() { window.print(); }" );
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
		public static function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_integrator.addEventListener( type, listener, useCapture, priority, useWeakReference );
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
		public static function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_integrator.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
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
		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_integrator.removeEventListener( type, listener, useCapture );
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
		public static function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_integrator.completelyRemoveEventListener( type, listener, useCapture );
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
		public static function dispatchEvent( event:Event ):Boolean {
			return _integrator.dispatchEvent( event );
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
		public static function hasEventListener( type:String ):Boolean {
			return _integrator.hasEventListener( type );
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
		public static function willTrigger( type:String ):Boolean {
			return _integrator.willTrigger( type );
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
		public static function removeAllListeners( completely:Boolean = false ):void {
			_integrator.removeAllListeners( completely );
		}
		
		/*======================================================================*//**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function restoreRemovedListeners():void {
			_integrator.restoreRemovedListeners();
		}
	}
}









