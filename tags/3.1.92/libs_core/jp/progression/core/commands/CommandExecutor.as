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
package jp.progression.core.commands {
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.progression.commands.ParallelList;
	import jp.progression.commands.SerialList;
	import jp.progression.core.commands.CommandList;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">コマンドの処理が開始された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_START
	 */
	[Event( name="commandStart", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドの処理が完了した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event( name="commandComplete", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドの処理を停止した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_INTERRUPT
	 */
	[Event( name="commandInterrupt", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンド処理中にエラーが発生した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_ERROR
	 */
	[Event( name="commandError", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">CommandExecutor クラスは、シーンフローに沿って、登録されたコマンドを次々と実行するクラスです。
	 * CommandExecutor クラスを直接インスタンス化することはできません。
	 * new CommandExecutor() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CommandExecutor extends EventIntegrator {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * IEventDispatcher インスタンスを取得します。
		 */
		private var _target:IEventDispatcher;
		
		/**
		 * CommandExecutor ツリー構造の一番上に位置するコマンドを取得します。
		 */
		progression_internal function get __root():CommandExecutor { return _root; }
		private var _root:CommandExecutor;
		
		/**
		 * この CommandExecutor を子に含んでいる親の CommandExecutor インスタンスを取得します。
		 */
		progression_internal function get __parent():CommandExecutor { return _parent; }
		private var _parent:CommandExecutor;
		
		/**
		 * 子 CommandExecutor インスタンスが保存されている配列を取得します。
		 */
		private var _executors:Array = [];
		
		/**
		 * CommandList インスタンスを取得します。
		 */
		private var _commandList:CommandList = new SerialList();
		
		/**
		 * CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。
		 */
		progression_internal function get __parallelMode():Boolean { return _parallelMode; }
		progression_internal function set __parallelMode( value:Boolean ):void {
			if ( running ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9027" ) ); }
			
			if ( _parallelMode = value ) {
				_commandList = SerialList( _commandList ).toParallelList();
			}
			else {
				_commandList = ParallelList( _commandList ).toSerialList();
			}
		}
		private var _parallelMode:Boolean = false;
		
		/**
		 * <span lang="ja">コマンドが実行中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get running():Boolean {
			// 親が存在し、親が実行中であれば
			if ( _parent && _parent.running ) { return true; }
			
			return _commandList.running;
		}
		
		/**
		 * <span lang="ja">コマンドが中断処理中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get interrupting():Boolean { return _commandList.interrupting; }
		
		/**
		 * <span lang="ja">コマンドが強制中断処理中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get enforcedInterrupting():Boolean { return _commandList.enforcedInterrupting; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function CommandExecutor( target:IEventDispatcher ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CommandExecutor" ) ); };
			
			// 引数を設定する
			_target = target;
			
			// 初期化する
			_root = this;
			_internallyCalled = false;
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __createInstance( target:IEventDispatcher ):CommandExecutor {
			_internallyCalled = true;
			return new CommandExecutor( target );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal function __addExecutable( executable:* ):* {
			switch ( true ) {
				case executable is ICommandExecutable	: { break; }
				case executable is MovieClip			:
				case "executor" in executable			: { break; }
				default									: { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9023", "ICommandExecutable" ) ); }
			}
			
			// CommandExecutor を取得する
			var executor:CommandExecutor = Object( executable ).executor;
			
			// すでに親が設定されていれば
			if ( executor._parent ) {
				executor._parent.progression_internal::__removeExecutable( executable );
			}
			
			// 親子関係を設定する
			executor._root = _root;
			executor._parent = this;
			
			// 登録する
			_executors.push( executable );
			
			return executable;
		}
		
		/**
		 * @private
		 */
		progression_internal function __removeExecutable( executable:* ):* {
			switch ( true ) {
				case executable is ICommandExecutable	: { break; }
				case executable is MovieClip			:
				case "executor" in executable			: { break; }
				default									: { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9023", "ICommandExecutable" ) ); }
			}
			
			// CommandExecutor を取得する
			var executor:CommandExecutor = Object( executable ).executor;
			
			// 親子関係を設定する
			executor._root = executor;
			executor._parent = null;
			
			// 登録を削除する
			var l:int = _executors.length;
			for ( var i:int = 0; i < l; i++ ) {
				if ( _executors[i] != executable ) { continue; }
				
				_executors.splice( i, 1 );
			}
			
			return executable;
		}
		
		/**
		 * @private
		 */
		progression_internal function __execute( event:Event, extra:Object = null, reverse:Boolean = false, enforced:Boolean = false ):void {
			// 実行中なら中断する
			if ( _commandList.running ) {
				// 強制中断ではなければ終了する
				if ( !enforced ) { return; }
				
				// コマンドを強制中断する
				_commandList.interrupt( true, extra );
			}
			
			// コマンドを収集する
			_execute( event, reverse );
			
			// コマンドを実行する
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_START, dispatchEvent, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_commandList.execute( extra );
		}
		
		/**
		 * 実行処理をします。
		 */
		private function _execute( event:Event, reverse:Boolean ):void {
			// 既存のコマンドを削除する
			_commandList.clearCommand( true );
			
			// リバースフローでなければ
			if ( !reverse ) {
				// イベントを送出する
				_target.dispatchEvent( event );
			}
			
			// 子のイベントを保存する ParallelList を作成する
			var com:ParallelList = new ParallelList();
			
			// 子で登録されたコマンドを収集する
			var l:int = _executors.length;
			for ( var i:int = 0; i < l; i++ ) {
				var executor:CommandExecutor = Object( _executors[i] ).executor;
				executor._execute( event, reverse );
				
				// 1 つ以上のコマンドが登録されていれば
				if ( executor._commandList.numCommands > 0 ) {
					// 登録する
					com.addCommand( executor._commandList );
				}
			}
			
			// 1 つ以上のコマンドが登録されていれば
			if ( com.numCommands > 0 ) {
				// 親のコマンドリストに登録する
				_commandList.addCommand( com );
			}
			
			// リバースフローであれば
			if ( reverse ) {
				// イベントを送出する
				_target.dispatchEvent( event );
			}
		}
		
		/**
		 * @private
		 */
		progression_internal function __interrupt( event:Event, extra:Object = null, reverse:Boolean = false, enforced:Boolean = false ):void {
			reverse;
			
			// 中断実行中なら終了する
			if ( interrupting ) { return; }
			
			// コマンドを実行する
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_START, dispatchEvent, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_commandList.interrupt( enforced, extra );
		}
		
		/**
		 * 中断処理をします。
		 */
		private function _interrupt( event:Event, reverse:Boolean ):void {
			// 既存のコマンドを削除する
			_commandList.clearCommand( true );
			
			// リバースフローでなければ
			if ( !reverse ) {
				// イベントを送出する
				_target.dispatchEvent( event );
			}
			
			// 子のイベントを保存する ParallelList を作成する
			var com:ParallelList = new ParallelList();
			
			// 子で登録されたコマンドを収集する
			var l:int = _executors.length;
			for ( var i:int = 0; i < l; i++ ) {
				var executor:CommandExecutor = Object( _executors[i] ).executor;
				executor._interrupt( event, reverse );
				
				// 1 つ以上のコマンドが登録されていれば
				if ( executor._commandList.numCommands > 0 ) {
					// 登録する
					com.addCommand( executor._commandList );
				}
			}
			
			// 1 つ以上のコマンドが登録されていれば
			if ( com.numCommands > 0 ) {
				// 親のコマンドリストに登録する
				_commandList.addCommand( com );
			}
			
			// リバースフローであれば
			if ( reverse ) {
				// イベントを送出する
				_target.dispatchEvent( event );
			}
		}
		
		/**
		 * @private
		 */
		progression_internal function __addCommand( ...commands:Array ):void {
			_commandList.addCommand.apply( null, commands );
		}
		
		/**
		 * @private
		 */
		progression_internal function __insertCommand( ...commands:Array ):void {
			_commandList.insertCommand.apply( null, commands );
		}
		
		/**
		 * @private
		 */
		progression_internal function __clearCommand( completely:Boolean = false ):void {
			_commandList.clearCommand( completely );
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
			return "[object CommandExecutor]";
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_START, dispatchEvent );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_START, dispatchEvent );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_START, dispatchEvent );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// イベントを送出する
			dispatchEvent( e );
		}
	}
}
