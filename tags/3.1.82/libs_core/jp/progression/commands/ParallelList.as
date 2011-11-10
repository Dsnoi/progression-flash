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
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.commands.Func;
	import jp.progression.commands.SerialList;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandList;
	import jp.progression.events.CommandEvent;

	/**
	 * <span lang="ja">ParallelList クラスは、指定された複数のコマンドを全て同時に実行させる為のコマンドリストクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // ParallelList インスタンスを作成します。
	 * var list:ParallelList = new ParallelList();
	 * 
	 * // コマンドを追加します。
	 * list.addCommand(
	 * 	// ParallelList を作成します。
	 * 	new ParallelList( null,
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "この Trace コマンドは同時に実行されます。" )
	 * 	),
	 * 	// ParallelList にコマンドを含む配列を指定すると、自動的に SerialList コマンドに変換されます。
	 * 	[
	 * 		new Trace( "最初の Trace コマンドです。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "2 番目の Trace コマンドです。" ),
	 * 		new Wait( 1000 ),
	 * 		new Trace( "3 番目の Trace コマンドです。" )
	 * 	]
	 * );
	 * 
	 * // ParallelList コマンドを実行します。
	 * list.execute();
	 * </listing>
	 */
	public class ParallelList extends CommandList {
		
		/**
		 * 現在処理中の Command インスタンスを保存した配列を取得します。 
		 */
		private var _commands:Array = [];
		
		/**
		 * 現在処理中の Command インスタンスを保存した配列を取得します。 
		 */
		private var _interrupted:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ParallelList インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ParallelList object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param commands
		 * <span lang="ja">登録したいコマンド、関数、配列を含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function ParallelList( initObject:Object = null, ... commands:Array ) {
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// コマンドリストに登録する
			addCommand.apply( null, commands );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 初期化する
			_commands = [];
			_interrupted = false;
			reset();
			
			// 現在登録されている全てのコマンドを取得する
			while ( hasNextCommand() ) {
				var com:Command = nextCommand();
				
				// イベントリスナーを登録する
				com.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
				com.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, 0, true );
				com.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, 0, true );
				
				// 登録する
				_commands.push( com );
			}
			
			// 登録されていなければ終了する
			if ( _commands.length == 0 ) {
				// 処理を終了する
				executeComplete();
				return;
			}
			
			// コマンドを同時に実行する
			var commands:Array = _commands.slice();
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				Command( commands[i] ).execute( extra );
			}
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 初期化する
			_commands = [];
			
			// 現在登録されている全てのコマンドを取得する
			while ( hasNextCommand() ) {
				var com:Command = nextCommand();
				
				// イベントリスナーを登録する
				com.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
				com.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, 0, true );
				com.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, 0, true );
				
				// 登録する
				_commands.push( com );
			}
			
			// 登録されていなければ終了する
			if ( _commands.length == 0 ) {
				// 処理を終了する
				interruptComplete();
				return;
			}
			
			// コマンドを同時に実行する
			var commands:Array = _commands.slice();
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				Command( commands[i] ).interrupt( false, extra );
			}
		}
		
		/**
		 * <span lang="ja">登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に SerialList に変換されます。</span>
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
		 * 配列を指定した場合には、自動的に SerialList に変換されます。</span>
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
					case command is Array		: { commands[i] = new SerialList().addCommand.apply( null, command as Array ); break; }
					
					default						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9028" ) ); }
				}
			}
			
			return commands;
		}
		
		/**
		 * <span lang="ja">ParallelList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an ParallelList subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい ParallelList インスタンスです。</span>
		 * <span lang="en">A new ParallelList object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new ParallelList( this );
		}
		
		/**
		 * <span lang="ja">元のオブジェクトと同じコマンドを格納した新しい SerialList インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じコマンドを格納した SerialList インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function toSerialList():SerialList {
			return new SerialList( this );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			var l:int = _commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				var com:Command = Command( _commands[i] );
				
				// 違っていれば次へ
				if ( com != e.target ) { continue; }
				
				// イベントリスナーを解除する
				com.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
				com.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
				com.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
				
				// 登録から削除する
				_commands.splice( i, 1 );
				break;
			}
			
			// まだ存在すれば終了する
			if ( _commands.length > 0 ) { return; }
			
			// 処理を終了する
			if ( interrupting ) {
				interruptComplete();
			}
			else if ( _interrupted ) {
				interrupt( enforcedInterrupting, extra );
			}
			else {
				executeComplete();
			}
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			_interrupted = true;
			
			_commandComplete( e );
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
