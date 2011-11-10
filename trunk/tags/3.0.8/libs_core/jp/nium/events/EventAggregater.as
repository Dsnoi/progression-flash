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
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import jp.nium.events.EventIntegrator;
	
	/*======================================================================*//**
	 * <p>登録されている全ての EventDispatcher インスタンスがイベントを送出した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>EventAggregater クラスは、複数のイベント発生をまとめて処理し、全てのイベントが送出されたタイミングで Event.COMPLETE イベントを送出します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EventAggregater extends EventIntegrator {
		
		/*======================================================================*//**
		 * 登録したイベントリスナー情報を取得します。
		 */
		private var _dispatchers:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 登録したイベントリスナー数を取得します。
		 */
		private var _numDispatchers:int = 0;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい EventAggregater インスタンスを作成します。</p>
		 * <p>Creates a new EventAggregater object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function EventAggregater() {
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>IEventDispatcher インスタンスを登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>登録したい IEventDispatcher インスタンスです。</p>
		 * 	<p></p>
		 * @param type
		 * 	<p>登録したいイベントタイプです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>IEventDispatcher インスタンスの登録を削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>削除したい EventDispatcher インスタンスです。</p>
		 * 	<p></p>
		 * @param type
		 * 	<p>削除したいイベントタイプです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>全ての登録を削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>登録済みのイベントを全て未発生状態に設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function reset():void {
			// イベントディスパッチャー情報を走査する
			for each ( var o:Object in _dispatchers ) {
				// イベント発生を無効化する
				o.dispatched = false;
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
			return "[object EventAggregater]";
		}
		
		
		
		
		
		/*======================================================================*//**
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









