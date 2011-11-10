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
package jp.nium.text {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextField;
	import jp.nium.core.display.ExDisplayObject;
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.core.namespaces.nium_internal;
	import jp.nium.events.IEventIntegrator;
	
	use namespace nium_internal;
	
	/**
	 * <span lang="ja">ExTextField クラスは、TextField クラスの基本機能を拡張した jp.nium パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en">ExTextField class is a basic display object class used at jp.nium package which extends the basic function of TextField class.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class ExTextField extends TextField implements IExDisplayObject, IEventIntegrator {
		
		/**
		 * <span lang="ja">インスタンスのクラス名を取得します。</span>
		 * <span lang="en">Indicates the instance className of the IExDisplayObject.</span>
		 */
		public function get className():String { return _exDisplayObject.className; }
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得または設定します。</span>
		 * <span lang="en">Indicates the instance id of the IExDisplayObject.</span>
		 */
		public function get id():String { return _exDisplayObject.id; }
		public function set id( value:String ):void { _exDisplayObject.id = value; }
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the IExDisplayObject.</span>
		 */
		public function get group():String { return _exDisplayObject.group; }
		public function set group( value:String ):void { _exDisplayObject.group = value; }
		
		/**
		 * ExDisplayObject インスタンスを取得します。
		 */
		private var _exDisplayObject:ExDisplayObject;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ExTextField インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ExTextField object.</span>
		 */
		public function ExTextField() {
			// ExDisplayObject を作成する
			_exDisplayObject = new ExDisplayObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ExDisplayObject を初期化する
			_exDisplayObject.nium_internal::initialize( {
				addEventListener		:super.addEventListener,
				removeEventListener		:super.removeEventListener,
				hasEventListener		:super.hasEventListener,
				willTrigger				:super.willTrigger,
				dispatchEvent			:super.dispatchEvent
			} );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">newText パラメータで指定されたストリングを、テキストフィールドのキャレット位置に付加します。</span>
		 * <span lang="en">Add the string specified as newText parameter to the caret position of the TextField.</span>
		 * 
		 * @param newText
		 * <span lang="ja">既存のテキストに追加するストリングです。</span>
		 * <span lang="en">The string to add to the existence text.</span>
		 */
		public function appendTextAtCaretIndex( newText:String ):void {
			var s:String = text.slice( 0, caretIndex );
			var e:String = text.slice( caretIndex, text.length );
			text = s + newText + e;
			setSelection( s.length + 1, e.length + 1 );
		}
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</span>
		 * <span lang="en">Returns the instance implements the IExDisplayObject interface which is set the same value of the specified id.</span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en">The string that becomes a condition.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstanceById( id:String ):DisplayObject {
			return DisplayObject( _exDisplayObject.getInstanceById( id ) );
		}
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that has the same value of the specified group.</span>
		 * 
		 * @param group
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en">The string that becomes a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByGroup( group, sort );
		}
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that match the condition to the specified fieldName.</span>
		 * 
		 * @param fieldName
		 * <span lang="ja">調査するフィールド名です。</span>
		 * <span lang="en">The field name to check.</span>
		 * @param pattern
		 * <span lang="ja">条件となる正規表現です。</span>
		 * <span lang="en">The regular expression to become a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/**
		 * <span lang="ja">インスタンスに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en">Setup the several instance properties.</span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">設定対象の DisplayObject インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function setProperties( props:Object ):DisplayObject {
			return _exDisplayObject.setProperties( props );
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
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_exDisplayObject.addEventListener( type, listener, useCapture, priority, useWeakReference );
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
			_exDisplayObject.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
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
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_exDisplayObject.removeEventListener( type, listener, useCapture );
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
			_exDisplayObject.completelyRemoveEventListener( type, listener, useCapture );
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
		public override function dispatchEvent( event:Event ):Boolean {
			return _exDisplayObject.dispatchEvent( event );
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
		public override function hasEventListener( type:String ):Boolean {
			return _exDisplayObject.hasEventListener( type );
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
		public override function willTrigger( type:String ):Boolean {
			return _exDisplayObject.willTrigger( type );
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
			_exDisplayObject.removeAllListeners( completely );
		}
		
		/**
		 * <span lang="ja">removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</span>
		 * <span lang="en">Re-register the whole event listener removed via removeEventListener() or removeAllListeners() method.</span>
		 */
		public function restoreRemovedListeners():void {
			_exDisplayObject.restoreRemovedListeners();
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの BitmapData 表現を返します。</span>
		 * <span lang="en">Returns the BitmapData representation of the specified object.</span>
		 * 
		 * @param transparent
		 * <span lang="ja">ビットマップイメージがピクセル単位の透明度をサポートするかどうかを指定します。デフォルト値は true です (透明)。完全に透明なビットマップを作成するには、transparent パラメータの値を true に、fillColor パラメータの値を 0x00000000 (または 0) に設定します。transparent プロパティを false に設定すると、レンダリングのパフォーマンスが若干向上することがあります。</span>
		 * <span lang="en">Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.</span>
		 * @param fillColor
		 * <span lang="ja">ビットマップイメージ領域を塗りつぶすのに使用する 32 ビット ARGB カラー値です。デフォルト値は 0xFFFFFFFF (白) です。</span>
		 * <span lang="en">A 32-bit ARGB color value that you use to fill the bitmap image area.</span>
		 * @return
		 * <span lang="ja">オブジェクトの BitmapData 表現です。</span>
		 * <span lang="en">A BitmapData representation of the object.</span>
		 */
		public function toBitmapData( transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF ):BitmapData {
			return _exDisplayObject.toBitmapData( transparent, fillColor );
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
			return _exDisplayObject.toString();
		}
	}
}
