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
package jp.nium.events {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import jp.nium.events.EventIntegrator;
	
	/**
	 * <span lang="ja">登録されている全ての EventDispatcher インスタンスがイベントを送出した場合に送出されます。</span>
	 * <span lang="en">Dispatch when the whole registered EventDispatcher instance sent.</span>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">EventAggregater クラスは、複数のイベント発生をまとめて処理し、全てのイベントが送出されたタイミングで Event.COMPLETE イベントを送出します。</span>
	 * <span lang="en">EventAggregater class will process the several event generation and send the Event.COMPLETE event when the whole event sent.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EventAggregater extends EventIntegrator {
		
		/**
		 * 登録したイベントリスナー情報を取得します。
		 */
		private var _dispatchers:Dictionary = new Dictionary( true );
		
		/**
		 * 登録したイベントリスナー数を取得します。
		 */
		private var _numDispatchers:int = 0;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい EventAggregater インスタンスを作成します。</span>
		 * <span lang="en">Creates a new EventAggregater object.</span>
		 */
		public function EventAggregater() {
		}
		
		
		
		
		
		/**
		 * <span lang="ja">IEventDispatcher インスタンスを登録します。</span>
		 * <span lang="en">Register the IEventDispatcher instance.</span>
		 * 
		 * @param target
		 * <span lang="ja">登録したい IEventDispatcher インスタンスです。</span>
		 * <span lang="en">The IEventDispatcher instance to register.</span>
		 * @param type
		 * <span lang="ja">登録したいイベントタイプです。</span>
		 * <span lang="en">The event type to register.</span>
		 */
		public function addEventDispatcher( dispatcher:IEventDispatcher, type:String ):void {
			// 既存のイベントディスパッチャー登録があれば削除する
			removeEventDispatcher( dispatcher, type );
			
			// イベントディスパッチャー情報を保存する
			_dispatchers[++_numDispatchers] = {
				id:_numDispatchers,
				dispatcher:dispatcher,
				type:type,
				dispatched:false
			};
			
			// イベントリスナーを登録する
			dispatcher.addEventListener( type, _aggregate, false, int.MAX_VALUE, true );
		}
		
		/**
		 * <span lang="ja">IEventDispatcher インスタンスの登録を削除します。</span>
		 * <span lang="en">Remove the registered IEventDispatcher instance.</span>
		 * 
		 * @param target
		 * <span lang="ja">削除したい EventDispatcher インスタンスです。</span>
		 * <span lang="en">The IEventDispatcher instance to remove.</span>
		 * @param type
		 * <span lang="ja">削除したいイベントタイプです。</span>
		 * <span lang="en">The event type to remove.</span>
		 */
		public function removeEventDispatcher( dispatcher:IEventDispatcher, type:String ):void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// 設定値が違っていれば次へ
				if ( o.dispatcher != dispatcher ) { continue; }
				if ( o.type != type ) { continue; }
				
				// 登録情報を削除する
				delete _dispatchers[o.id];
				break;
			}
			
			// イベントリスナーを削除する
			dispatcher.removeEventListener( type, _aggregate );
		}
		
		/**
		 * <span lang="ja">全ての登録を削除します。</span>
		 * <span lang="en">Remove all registered object.</span>
		 */
		public function removeAllEventDispatcher():void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// イベントリスナーを解除する
				o.dispatcher.removeEventListener( o.type, _aggregate );
			}
			
			// 初期化する
			_dispatchers = new Dictionary( true );
		}
		
		/**
		 * <span lang="ja">登録済みのイベントを全て未発生状態に設定します。</span>
		 * <span lang="en">Set the whole registered event as unsent.</span>
		 */
		public function reset():void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// イベント発生を無効化する
				o.dispatched = false;
			}
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
			return "[object EventAggregater]";
		}
		
		
		
		
		
		/**
		 * 任意のイベントの送出を受け取ります。
		 */
		private function _aggregate( e:Event ):void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// 設定値が違っていれば次へ
				if ( o.dispatcher != e.target ) { continue; }
				if ( o.type != e.type ) { continue; }
				
				// イベント発生を有効化する
				o.dispatched = true;
				break;
			}
			
			// イベントディスパッチャー情報を走査する
			for each ( o in _dispatchers ) {
				// イベントが発生していなければ終了する
				if ( !o.dispatched ) { return; }
			}
			
			// イベントを送出する
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}
