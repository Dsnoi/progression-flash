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
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.commands.Command;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">CommandList クラスは、コマンドリストでコマンドコンテナとして機能する全てのコマンドの基本となるクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CommandList extends Command {
		
		/**
		 * @private
		 */
		progression_internal override function get __root():Command { return super.progression_internal::__root; }
		progression_internal override function set __root( value:Command ):void {
			super.progression_internal::__root = value;
			
			// 子の関連性を再設定する
			var l:int = _commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				Command( _commands[i] ).progression_internal::__root = root;
			}
		}
		
		/**
		 * @private
		 */
		progression_internal override function get __parent():CommandList { return super.progression_internal::__parent; }
		progression_internal override function set __parent( value:CommandList ):void {
			super.progression_internal::__parent = value;
			
			// 子の関連性を再設定する
			var l:int = _commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				Command( _commands[i] ).progression_internal::__parent = this;
			}
		}
		
		/**
		 * @private
		 */
		progression_internal override function get __next():Command { return super.progression_internal::__next; }
		progression_internal override function set __next( value:Command ):void { super.progression_internal::__next = value; }
		
		/**
		 * @private
		 */
		progression_internal override function get __previous():Command { return super.progression_internal::__previous; }
		progression_internal override function set __previous( value:Command ):void { super.progression_internal::__previous = value; }
		
		/**
		 * @private
		 */
		progression_internal override function get __length():int { return super.progression_internal::__length; }
		progression_internal override function set __length( value:int ):void {
			super.progression_internal::__length = value;
			
			var l:int = _commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				Command( _commands[i] ).progression_internal::__length = length + 1;
			}
			
			// インデントを設定する
			_indent = StringUtil.repeat( "  ", value );
		}
		
		/**
		 * <span lang="ja">登録されているコマンド配列を取得します。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en"></span>
		 */
		public function get commands():Array { return _commands.concat(); }
		private var _commands:Array = [];
		
		/**
		 * @private
		 */
		private var _indent:String = "  ";
		
		/**
		 * <span lang="ja">登録されているコマンド数を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get numCommands():int { return _commands.length; }
		
		/**
		 * <span lang="ja">現在処理しているコマンド位置を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get position():int { return Math.min( _position, numCommands - 1 ); }
		private var _position:int = 0;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CommandList インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CommandList object.</span>
		 * 
		 * @param executeFunction
		 * <span lang="ja">コマンドの実行関数です。</span>
		 * <span lang="en"></span>
		 * @param interruptFunction
		 * <span lang="ja">コマンドの中断関数です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function CommandList( executeFunction:Function = null, interruptFunction:Function = null, initObject:Object = null, ... commands:Array ) {
			// スーパークラスを初期化する
			super( executeFunction, interruptFunction, initObject );
			
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( Command ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CommandList" ) ); }
			
			// initObject が CommandList であれば
			if ( initObject is CommandList ) {
				// 特定のプロパティを継承する
				var orgin:Array = CommandList( initObject )._commands.slice();
				var l:int  = orgin.length;
				for ( var i:int = 0; i < l; i++ ) {
					orgin[i] = Command( orgin[i] ).clone();
				}
				commands = orgin;
			}
			
			// コマンドリストに登録する
			addCommand.apply( null, commands );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * コマンドを登録します。
		 */
		private function _registerCommand( command:Command, index:int ):void {
			// すでに親が存在していれば解除する
			if ( command.parent ) {
				command.parent._unregisterCommand( command );
			}
			
			// 登録する
			_commands.splice( index, 0, command );
			
			// 前後を取得する
			var next:Command = _commands[index + 1];
			var previous:Command = _commands[index - 1];
			
			// 親子関係を設定する
			command.progression_internal::__root = root;
			command.progression_internal::__parent = this;
			command.progression_internal::__next = next;
			command.progression_internal::__previous = previous;
			
			// 深度を設定する
			command.progression_internal::__length = length + 1;
			
			// 前後関係を設定する
			( next && ( next.progression_internal::__previous = command ) );
			( previous && ( previous.progression_internal::__next = command ) );
			
			// イベントを送出する
			command.dispatchEvent( new CommandEvent( CommandEvent.COMMAND_ADDED ) );
		}
		
		/**
		 * コマンド登録を削除します。
		 */
		private function _unregisterCommand( command:Command ):void {
			var l:int = _commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				var com:Command = Command( _commands[i] );
				
				// 違っていれば次へ
				if ( com != command ) { continue; }
				
				// 前後を取得する
				var next:Command = _commands[i + 1];
				var previous:Command = _commands[i - 1];
				
				// 親子関係を設定する
				command.progression_internal::__root = null;
				command.progression_internal::__parent = null;
				command.progression_internal::__next = null;
				command.progression_internal::__previous = null;
				
				// 深度を設定する
				command.progression_internal::__length = 1;
				
				// 前後関係を設定する
				if ( next ) {
					next.progression_internal::__previous = previous;
				}
				if ( previous ) {
					previous.progression_internal::__next = next;
				}
				
				// 登録を解除する
				_commands.splice( i, 1 );
				
				// イベントを送出する
				command.dispatchEvent( new CommandEvent( CommandEvent.COMMAND_REMOVED ) );
				return;
			}
		}
		
		/**
		 * <span lang="ja">登録されているコマンドの最後尾に新しくコマンドを追加します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function addCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				// コマンドを取得する
				var com:Command = commands[i] as Command;
				
				// 存在しなければ次へ
				if ( !com ) { continue; }
				
				// 登録する
				_registerCommand( com, numCommands );
			}
			
			return this;
		}
		
		/**
		 * <span lang="ja">現在実行中のコマンドの次の位置に新しくコマンドを追加します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function insertCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				// コマンドを取得する
				var com:Command = commands[i] as Command;
				
				// 存在しなければ次へ
				if ( !com ) { continue; }
				
				// 登録する
				_registerCommand( com, _position + i );
			}
			
			return this;
		}
		
		/**
		 * <span lang="ja">コマンド登録を解除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param completely
		 * <span lang="ja">true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function clearCommand( completely:Boolean = false ):CommandList {
			var commands:Array = _commands.slice();
			
			// 全て、もしくは現在の処理位置以降を削除する
			commands = completely ? commands.splice( 0 ) : commands.splice( _position );
			
			// 親子関係を再設定する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				_unregisterCommand( Command( commands[i] ) );
			}
			
			// 現在のカウントを再設定する
			_position = Math.min( _position, numCommands );
			
			return this;
		}
		
		/**
		 * <span lang="ja">次のコマンドを取得して、処理位置を次に進めます。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">次に位置するコマンドです。</span>
		 * <span lang="en"></span>
		 */
		public function nextCommand():Command {
			return Command( _commands[_position++] );
		}
		
		/**
		 * <span lang="ja">次のコマンドが存在するかどうかを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">次のコマンドが存在すれば true を、それ以外の場合には false です。</span>
		 * <span lang="en"></span>
		 */
		public function hasNextCommand():Boolean {
			return Boolean( _position < _commands.length );
		}
		
		/**
		 * <span lang="ja">コマンドの処理位置を最初に戻します。</span>
		 * <span lang="en"></span>
		 */
		public function reset():void {
			_position = 0;
		}
		
		/**
		 * <span lang="ja">CommandList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an CommandList subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい CommandList インスタンスです。</span>
		 * <span lang="en">A new CommandList object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new CommandList( null, null, this );
		}
		
		
		
		
		
		/**
		 */
		private function _commandComplete( e:CommandEvent ):void {
			Verbose.log( this, _indent + "</" + className + " : " + ( id || name ) + ">" );
		}
	}
}
