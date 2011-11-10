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
package jp.progression.core.commands {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.MathUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.commands.Command;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>CommandList クラスは、コマンドリストでコマンドコンテナとして機能する全てのコマンドの基本となるクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CommandList extends Command {
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal override function get __next():Command { return super.progression_internal::__next; }
		progression_internal override function set __next( value:Command ):void { super.progression_internal::__next = value; }
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal override function get __previous():Command { return super.progression_internal::__previous; }
		progression_internal override function set __previous( value:Command ):void { super.progression_internal::__previous = value; }
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>登録されているコマンド配列を取得します。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get commands():Array { return _commands.concat(); }
		private var _commands:Array = [];
		
		/*======================================================================*//**
		 * @private
		 */
		private var _indent:String = "  ";
		
		/*======================================================================*//**
		 * <p>登録されているコマンド数を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get numCommands():int { return _commands.length; }
		
		/*======================================================================*//**
		 * <p>現在処理しているコマンド位置を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get position():int { return Math.min( _position, numCommands - 1 ); }
		private var _position:int = 0;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CommandList インスタンスを作成します。</p>
		 * <p>Creates a new CommandList object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param executeFunction
		 * 	<p>コマンドの実行関数です。</p>
		 * 	<p></p>
		 * @param interruptFunction
		 * 	<p>コマンドの中断関数です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
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
				var result:Array = [];
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
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>登録されているコマンドの最後尾に新しくコマンドを追加します。</p>
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
		public function addCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				_registerCommand( Command( commands[i] ), numCommands );
			}
			
			return this;
		}
		
		/*======================================================================*//**
		 * <p>現在実行中のコマンドの次の位置に新しくコマンドを追加します。</p>
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
		public function insertCommand( ...commands:Array ):CommandList {
			// コマンドリストに登録する
			var l:int = commands.length;
			for ( var i:int = 0; i < l; i++ ) {
				_registerCommand( Command( commands[i] ), _position + i );
			}
			
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンド登録を解除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>次のコマンドを取得して、処理位置を次に進めます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>次に位置するコマンドです。</p>
		 * 	<p></p>
		 */
		public function nextCommand():Command {
			return Command( _commands[_position++] );
		}
		
		/*======================================================================*//**
		 * <p>次のコマンドが存在するかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>次のコマンドが存在すれば true を、それ以外の場合には false です。</p>
		 * 	<p></p>
		 */
		public function hasNextCommand():Boolean {
			return ( _position < _commands.length );
		}
		
		/*======================================================================*//**
		 * <p>コマンドの処理位置を最初に戻します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function reset():void {
			_position = 0;
		}
		
		/*======================================================================*//**
		 * <p>CommandList インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CommandList subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい CommandList インスタンスです。</p>
		 * 	<p>A new CommandList object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new CommandList( null, null, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 
		 */
		private function _commandComplete( e:CommandEvent ):void {
			Verbose.log( this, _indent + "</" + className + " : " + ( id || name ) + ">" );
		}
	}
}









