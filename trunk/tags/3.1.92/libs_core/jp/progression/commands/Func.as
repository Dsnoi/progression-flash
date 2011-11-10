/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.commands {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Func クラスは、指定された関数を実行するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // SerialList インスタンスを作成します。
	 * var list:SerialList = new SerialList();
	 * 
	 * // コマンドを追加します。
	 * list.addCommand(
	 * 	// Func コマンドを作成します。
	 * 	new Func( trace, [ "出力されるストリングです。" ] ),
	 * 	
	 * 	// Func コマンドを作成します。
	 * 	new Func( function() {
	 * 		trace( "匿名関数から出力されるストリングです。" );
	 * 	} ),
	 * 	
	 * 	// SerialList および ParallelList に無名関数を登録した場合、自動的に Func コマンドに変換されます。
	 * 	function():void {
	 * 		trace( "Func コマンドに変換された無名関数から出力されるストリングです。" );
	 * 	}
	 * );
	 * 
	 * // SerialList コマンドを実行します。
	 * list.execute();
	 * </listing>
	 */
	public class Func extends Command {
		
		/**
		 * <span lang="ja">実行したい関数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get func():Function { return _func; }
		public function set func( value:Function ):void { _func = value; }
		private var _func:Function;
		
		/**
		 * <span lang="ja">関数を実行する際に引数として使用する配列を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get args():Array { return _args; }
		public function set args( value:Array ):void { _args = value; }
		private var _args:Array;
		
		/**
		 * <span lang="ja">処理の終了イベントを発行する EventDispatcher インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get dispatcher():IEventDispatcher { return _dispatcher; }
		public function set dispatcher( value:IEventDispatcher ):void {
			if ( _listening ) {
				_listening = false;
				_dispatcher.removeEventListener( _eventType, _listener );
			}
			
			_dispatcher = value;
			
			if ( running && _eventType ) {
				_listening = true;
				_dispatcher.addEventListener( _eventType, _listener, false, 0, true );
			}
		}
		private var _dispatcher:IEventDispatcher;
		
		/**
		 * <span lang="ja">発行される終了イベントの種類を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventType():String { return _eventType; }
		public function set eventType( value:String ):void {
			if ( _listening ) {
				_listening = false;
				_dispatcher.removeEventListener( _eventType, _listener );
			}
			
			_eventType = value;
			
			if ( running && _dispatcher ) {
				_listening = true;
				_dispatcher.addEventListener( _eventType, _listener, false, 0, true );
			}
		}
		private var _eventType:String;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function get listening():Boolean { return _listening; }
		private var _listening:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Func インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Func object.</span>
		 * 
		 * @param func
		 * <span lang="ja">実行したい関数です。</span>
		 * <span lang="en"></span>
		 * @param args
		 * <span lang="ja">関数を実行する際に引数として使用する配列です。</span>
		 * <span lang="en"></span>
		 * @param dispatcher
		 * <span lang="ja">処理の終了イベントを発行する EventDispatcher インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param eventType
		 * <span lang="ja">発行される終了イベントの種類です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Func( func:Function, args:Array = null, dispatcher:IEventDispatcher = null, eventType:String = null, initObject:Object = null ) {
			// 引数を設定する
			_func = func;
			_args = args;
			_dispatcher = dispatcher;
			_eventType = eventType;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// イベントが存在するかどうか確認する
			_listening = Boolean( _dispatcher && _eventType );
			
			// イベントが存在すれば登録する
			if ( _listening ) {
				_dispatcher.addEventListener( _eventType, _listener, false, 0, true );
			}
			
			// 関数を実行する
			_func.apply( this, _args );
			
			// イベントが存在すれば終了する
			if ( _listening ) { return; }
			
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
		 * <span lang="ja">Func インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Func subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Func インスタンスです。</span>
		 * <span lang="en">A new Func object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Func( _func, _args, _dispatcher, _eventType, this );
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
