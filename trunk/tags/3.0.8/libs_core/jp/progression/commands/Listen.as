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
package jp.progression.commands {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p></p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Listen extends Command {
		
		/*======================================================================*//**
		 * <p>イベントを発行する EventDispatcher インスタンスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get dispatcher():IEventDispatcher { return _dispatcher; }
		public function set dispatcher( value:IEventDispatcher ):void { _dispatcher = value; }
		private var _dispatcher:IEventDispatcher;
		
		/*======================================================================*//**
		 * <p>発行される終了イベントの種類を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get eventType():String { return _eventType; }
		public function set eventType( value:String ):void { _eventType = value; }
		private var _eventType:String;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Func インスタンスを作成します。</p>
		 * <p>Creates a new Func object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param dispatcher
		 * 	<p>イベントを発行する EventDispatcher インスタンスです。</p>
		 * 	<p></p>
		 * @param eventType
		 * 	<p>発行される終了イベントの種類です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Listen( dispatcher:IEventDispatcher = null, eventType:String = null, initObject:Object = null ) {
			// 引数を設定する
			_dispatcher = dispatcher;
			_eventType = eventType;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// イベントが存在すれば
			if ( _dispatcher && _eventType ) {
				// イベントリスナーを登録する
				_dispatcher.addEventListener( _eventType, _listener, false, 0, true );
				return;
			}
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// イベントが存在すれば
			if ( _dispatcher && _eventType ) {
				// イベントリスナーを解除する
				_dispatcher.removeEventListener( _eventType, _listener );
			}
			
			// 停止処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>Listen インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Listen subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Func インスタンスです。</p>
		 * 	<p>A new Func object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Listen( _dispatcher, _eventType, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * dispatcher の eventType イベントが発生した瞬間に送出されます。
		 */
		private function _listener( e:Event ):void {
			// イベントリスナーを解除する
			_dispatcher.removeEventListener( _eventType, _listener );
			
			// 処理を終了する
			executeComplete();
		}
	}
}









