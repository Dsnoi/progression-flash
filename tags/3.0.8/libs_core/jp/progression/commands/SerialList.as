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
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.commands.Func;
	import jp.progression.commands.ParallelList;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandList;
	import jp.progression.events.CommandEvent;
	
	/*======================================================================*//**
	 * <p>SerialList クラスは、指定された複数のコマンドを 1 つづつ順番に実行させる為のコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
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
		
		/*======================================================================*//**
		 * 現在処理中の Command インスタンスを取得します。 
		 */
		private var _currentCommand:Command;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい SerialList インスタンスを作成します。</p>
		 * <p>Creates a new SerialList object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @param commands
		 * 	<p>登録したいコマンド、関数、配列を含む配列です。</p>
		 * 	<p></p>
		 */
		public function SerialList( initObject:Object = null, ... commands:Array ) {
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// 初期化する
			timeOut = initObject ? initObject.timeOut : 0;
			
			// コマンドリストに登録する
			addCommand.apply( null, commands );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 処理ポイントを初期化する
			reset();
			
			// 処理を実行する
			_executeLoop();
		}
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList に変換されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public override function addCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			return super.addCommand.apply( null, _convertCommand( commands ) );
		}
		
		/*======================================================================*//**
		 * <p>現在実行中のコマンドの次の位置に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に ParallelList に変換されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public override function insertCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			return super.insertCommand.apply( null, _convertCommand( commands ) );
		}
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>SerialList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SerialList subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい SerialList インスタンスです。</p>
		 * 	<p>A new SerialList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new SerialList( this );
		}
		
		/*======================================================================*//**
		 * <p>元のオブジェクトと同じコマンドを格納した新しい ParallelList インスタンスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じコマンドを格納した ParallelList インスタンスです。</p>
		 * 	<p></p>
		 */
		public function toParallelList():ParallelList {
			return new ParallelList( this );
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// エラー処理を実行する
			_catchError( Command( e.target ), e.errorObject );
		}
	}
}









