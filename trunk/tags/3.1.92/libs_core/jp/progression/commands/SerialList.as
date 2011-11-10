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
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.commands.Func;
	import jp.progression.commands.ParallelList;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandList;
	import jp.progression.events.CommandEvent;
	
	/**
	 * <span lang="ja">SerialList クラスは、指定された複数のコマンドを 1 つづつ順番に実行させる為のコマンドリストクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // SerialList インスタンスを作成します。
	 * var list:SerialList = new SerialList();
	 * 
	 * // コマンドを追加します。
	 * list.addCommand(
	 * 	// SerialList を作成します。
	 * 	new SerialList( null,
	 * 		new Trace( "最初の Trace コマンドです。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "2 番目の Trace コマンドです。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "3 番目の Trace コマンドです。" )
	 * 	),
	 * 	// SerialList にコマンドを含む配列を指定すると、自動的に ParallelList コマンドに変換されます。
	 * 	[
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" )
	 * 	]
	 * );
	 * 
	 * // SerialList コマンドを実行します。
	 * list.execute();
	 * </listing>
	 */
	public class SerialList extends CommandList {
		
		/**
		 * 現在処理中の Command インスタンスを取得します。 
		 */
		private var _currentCommand:Command;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい SerialList インスタンスを作成します。</span>
		 * <span lang="en">Creates a new SerialList object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param commands
		 * <span lang="ja">登録したいコマンド、関数、配列を含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function SerialList( initObject:Object = null, ... commands:Array ) {
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// コマンドリストに登録する
			addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 処理ポイントを初期化する
			reset();
			
			// 処理を実行する
			_executeLoop();
		}
		
		/**
		 * 実行されるコマンドのループ実装です。
		 */
		private function _executeLoop():void {
			// 次のコマンドが存在すれば
			if ( hasNextCommand() ) {
				// 現在の対象コマンドを取得する
				_currentCommand = nextCommand();
				
				// 処理を実行する
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, 0, true );
				_currentCommand.execute( extra );
				return;
			}
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// すでに実行中のコマンドが存在していれば
			if ( _currentCommand ) {
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, 0, true );
				_currentCommand.interrupt( enforcedInterrupting, extra );
				return;
			}
			
			// 処理を実行する
			_interruptLoop();
		}
		
		/**
		 * 中断実行されるコマンドのループ実装です。
		 */
		private function _interruptLoop():void {
			// 強制中断であれば終了する
			if ( enforcedInterrupting ) {
				// 処理を終了する
				interruptComplete();
				return;
			}
			
			// 次のコマンドが存在すれば
			if ( hasNextCommand() ) {
				// 現在の対象コマンドを取得する
				_currentCommand = nextCommand();
				
				// 処理を実行する
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, 0, true );
				_currentCommand.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, 0, true );
				_currentCommand.interrupt( enforcedInterrupting, extra );
				return;
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList に変換されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public override function addCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			return super.addCommand.apply( null, _convertCommand( commands ) );
		}
		
		/**
		 * <span lang="ja">現在実行中のコマンドの次の位置に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList に変換されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public override function insertCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			return super.insertCommand.apply( null, _convertCommand( commands ) );
		}
		
		/**
		 * 特定の型のオブジェクトを変換します。
		 */
		private function _convertCommand( commands:Array ):Array {
			// 型に応じて変換する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				var command:* = commands[i];
				
				switch ( true ) {
					// Command または "" であれば次へ
					case command == ""			:
					case command == null		:
					case command is Command		: { break; }
					
					// 関数であれば Command に変換する
					case command is Function	: { commands[i] = new Func( command ); break; }
					
					// 配列であればシンタックスシュガーとして処理する
					case command is Array		: { commands[i] = new ParallelList().addCommand.apply( null, command as Array ); break; }
					
					default						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9028" ) ); }
				}
			}
			
			return commands;
		}
		
		/**
		 * <span lang="ja">SerialList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an SerialList subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい SerialList インスタンスです。</span>
		 * <span lang="en">A new SerialList object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new SerialList( this );
		}
		
		/**
		 * <span lang="ja">元のオブジェクトと同じコマンドを格納した新しい ParallelList インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じコマンドを格納した ParallelList インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function toParallelList():ParallelList {
			return new ParallelList( this );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// コマンドを消去する
			_currentCommand = null;
			
			// 処理を実行する
			_executeLoop();
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_currentCommand.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// コマンドを消去する
			_currentCommand = null;
			
			// 中断処理を実行する
			if ( interrupting ) {
				_interruptLoop();
			}
			else {
				interrupt( e.enforcedInterrupted, extra );
			}
		}
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// エラー処理を実行する
			_catchError( Command( e.target ), e.errorObject );
		}
	}
}
