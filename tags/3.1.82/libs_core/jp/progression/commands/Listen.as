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
package jp.progression.commands {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja"></span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Listen extends Command {
		
		/**
		 * <span lang="ja">イベントを発行する EventDispatcher インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get dispatcher():IEventDispatcher { return _dispatcher; }
		public function set dispatcher( value:IEventDispatcher ):void { _dispatcher = value; }
		private var _dispatcher:IEventDispatcher;
		
		/**
		 * <span lang="ja">発行される終了イベントの種類を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventType():String { return _eventType; }
		public function set eventType( value:String ):void { _eventType = value; }
		private var _eventType:String;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Func インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Func object.</span>
		 * 
		 * @param dispatcher
		 * <span lang="ja">イベントを発行する EventDispatcher インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param eventType
		 * <span lang="ja">発行される終了イベントの種類です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Listen( dispatcher:IEventDispatcher, eventType:String, initObject:Object = null ) {
			// 引数を設定する
			_dispatcher = dispatcher;
			_eventType = eventType;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
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
		
		/**
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
		
		/**
		 * <span lang="ja">Listen インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Listen subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Func インスタンスです。</span>
		 * <span lang="en">A new Func object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Listen( _dispatcher, _eventType, this );
		}
		
		
		
		
		
		/**
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
