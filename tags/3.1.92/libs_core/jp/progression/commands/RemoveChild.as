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
	import fl.transitions.easing.Regular;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastObject;
	import jp.progression.commands.DoTween;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">RemoveAllChild クラスは、対象の DisplayObjectContainer インスタンスのディスプレイリストから ICastObject インスタンスを削除するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">DisplayObject インスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/**
		 * <span lang="ja">ディスプレイリストに追加したい DisplayObject インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
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
		
		/**
		 * DisplayObject オブジェクトを取得します。
		 */
		private var _display:DisplayObject;
		
		/**
		 * <span lang="ja">DisplayObject インスタンスを表示する際に、alpha プロパティを使用したアルファフェード効果を適用するミリ秒を取得または設定します。
		 * この値が 0 である場合には、アルファフェード効果は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		public function get autoAlpha():int { return _autoAlpha; }
		public function set autoAlpha( value:int ):void { _autoAlpha = Math.max( 0, value ); }
		private var _autoAlpha:int = 0;
		
		/**
		 * CommandExecutor インスタンスを取得します。
		 */
		private var _executor:CommandExecutor;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい RemoveChild インスタンスを作成します。</span>
		 * <span lang="en">Creates a new RemoveChild object.</span>
		 * 
		 * @param container
		 * <span lang="ja">DisplayObject インスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param child
		 * <span lang="ja">ディスプレイリストから削除したい DisplayObject インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function RemoveChild( container:DisplayObjectContainer, child:*, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			this.child = child;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
		}
		
		
		
		
		
		/**
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
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">RemoveChild インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an RemoveChild subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい RemoveChild インスタンスです。</span>
		 * <span lang="en">A new RemoveChild object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new RemoveChild( _container, _child, this ).setProperties( {
				autoAlpha:_autoAlpha
			} );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が開始された場合に送出されます。
		 */
		private function _commandStart( e:CommandEvent ):void {
			// オートアルファが有効化されていれば
			if ( _autoAlpha > 0 ) {
				// コマンドを追加する
				_executor.progression_internal::__addCommand( new DoTween( _display, { alpha:0 }, Regular.easeInOut, _autoAlpha ) );
			}
		}
		
		/**
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
		
		/**
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
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// 処理を実行する
			_catchError( this, e.errorObject );
		}
	}
}
