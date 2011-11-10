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
	import jp.progression.commands.SerialList;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandList;
	import jp.progression.events.CommandEvent;

	/*======================================================================*//**
	 * <p>ParallelList クラスは、指定された複数のコマンドを全て同時に実行させる為のコマンドリストクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // ParallelList インスタンスを作成します。
	 * var list:SerialList = new ParallelList();
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
		
		/*======================================================================*//**
		 * 現在処理中の Command インスタンスを保存した配列を取得します。 
		 */
		private var _commands:Array = [];
		
		/*======================================================================*//**
		 * 現在処理中の Command インスタンスを保存した配列を取得します。 
		 */
		private var _interrupted:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ParallelList インスタンスを作成します。</p>
		 * <p>Creates a new ParallelList object.</p>
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
		public function ParallelList( initObject:Object = null, ... commands:Array ) {
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>登録されているコマンドの最後尾に新しくコマンドを追加します。
		 * 関数を指定した場合には、自動的に Func コマンドに変換され、
		 * 配列を指定した場合には、自動的に SerialList に変換されます。</p>
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
		 * 配列を指定した場合には、自動的に SerialList に変換されます。</p>
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
					case command is Array		: { commands[i] = new SerialList().addCommand.apply( null, command as Array ); break; }
					
					default						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9028" ) ); }
				}
			}
			
			return commands;
		}
		
		/*======================================================================*//**
		 * <p>ParallelList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an ParallelList subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい ParallelList インスタンスです。</p>
		 * 	<p>A new ParallelList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new ParallelList( this );
		}
		
		/*======================================================================*//**
		 * <p>元のオブジェクトと同じコマンドを格納した新しい SerialList インスタンスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じコマンドを格納した SerialList インスタンスです。</p>
		 * 	<p></p>
		 */
		public function toSerialList():SerialList {
			return new SerialList( this );
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			_interrupted = true;
			
			_commandComplete( e );
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









