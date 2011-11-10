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
	import fl.transitions.easing.Regular;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastObject;
	import jp.progression.commands.DoTween;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.errors.CommandExecuteError;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>RemoveAllChild クラスは、対象の DisplayObjectContainer インスタンスのディスプレイリストから ICastObject インスタンスを削除するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // 表示コンテナに追加する CastSprite インスタンスを作成します。
	 * var child:CastSprite = new CastSprite();
	 * 
	 * // container インスタンスの子として child インスタンスを登録します。
	 * container.addChild( child );
	 * 
	 * // RemoveChild コマンドを作成します。
	 * var com:RemoveChild = new RemoveChild( container, child );
	 * 
	 * // RemoveChild コマンドを実行します。
	 * com.execute();
	 * 
	 * // 結果を出力します。
	 * trace( container.contains( child ) ); // false
	 * </listing>
	 */
	public class RemoveChild extends Command {
		
		/*======================================================================*//**
		 * <p>DisplayObject インスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/*======================================================================*//**
		 * <p>ディスプレイリストに追加したい DisplayObject インスタンスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get child():* { return _child; }
		public function set child( value:* ):void {
			switch ( true ) {
				case value == null				: { _display = value; break; }
				case value is DisplayObject		: { _display = value as DisplayObject; break; }
				case value is CastObject		: { _display = CastObject( value ).target; break; }
				default							: { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9006" ) ); }
			}
			
			_child = value;
		}
		private var _child:*;
		
		/*======================================================================*//**
		 * DisplayObject オブジェクトを取得します。
		 */
		private var _display:DisplayObject;
		
		/*======================================================================*//**
		 * <p>DisplayObject インスタンスを表示する際に、alpha プロパティを使用したアルファフェード効果を適用するミリ秒を取得または設定します。
		 * この値が 0 である場合には、アルファフェード効果は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get autoAlpha():int { return _autoAlpha; }
		public function set autoAlpha( value:int ):void { _autoAlpha = Math.max( 0, value ); }
		private var _autoAlpha:int = 0;
		
		/*======================================================================*//**
		 * CommandExecutor インスタンスを取得します。
		 */
		private var _executor:CommandExecutor;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい RemoveChild インスタンスを作成します。</p>
		 * <p>Creates a new RemoveChild object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param container
		 * 	<p>DisplayObject インスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスです。</p>
		 * 	<p></p>
		 * @param child
		 * 	<p>ディスプレイリストから削除したい DisplayObject インスタンスです。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function RemoveChild( container:DisplayObjectContainer = null, child:* = null, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			this.child = child;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// 初期化する
			timeOut = initObject ? initObject.timeOut : 0;
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// すでに画面に配置されていなければ終了する
			if ( !_container.contains( _display ) ) {
				executeComplete();
				return;
			}
			
			// executor プロパティが存在すれば
			if ( _child && "executor" in _child ) {
				_executor.progression_internal::__addExecutable( _child );
			}
			
			// 実行する
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_START, _commandStart, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_REMOVED ), extra, true, false );
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>RemoveChild インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveChild subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい RemoveChild インスタンスです。</p>
		 * 	<p>A new RemoveChild object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveChild( _container, _child, this ).setProperties( {
				autoAlpha:_autoAlpha
			} );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * コマンドの処理が開始された場合に送出されます。
		 */
		private function _commandStart( e:CommandEvent ):void {
			// オートアルファが有効化されていれば
			if ( _autoAlpha > 0 ) {
				// コマンドを追加する
				_executor.progression_internal::__addCommand( new DoTween( _display, { alpha:0 }, Regular.easeInOut, _autoAlpha ) );
			}
		}
		
		/*======================================================================*//**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_START, _commandStart );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// 画面に配置されていればディスプレイリストから削除する
			if ( _container.contains( _display ) ) {
				_container.removeChild( _display );
			}
			
			// executor プロパティが存在すれば
			if ( _child && "executor" in _child ) {
				_executor.progression_internal::__removeExecutable( _child );
			}
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_START, _commandStart );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// 画面に配置されていればディスプレイリストから削除する
			if ( _container.contains( _display ) ) {
				_container.removeChild( _display );
			}
			
			// executor プロパティが存在すれば
			if ( _child && "executor" in _child ) {
				_executor.progression_internal::__removeExecutable( _child );
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// 処理を実行する
			_catchError( this, e.errorObject );
		}
	}
}









