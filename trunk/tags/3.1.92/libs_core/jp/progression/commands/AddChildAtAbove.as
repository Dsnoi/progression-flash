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
	import jp.nium.core.display.IExDisplayObjectContainer;
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
	 * <span lang="ja">AddChildAtAbove クラスは、対象の DisplayObjectContainer インスタンスのディスプレイリストに DisplayObject インスタンスを追加するコマンドクラスです。
	 * 追加するインスタンスが ICastObject インターフェイスを実装している場合には、CastEvent.ADDED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // 表示コンテナに追加する CastSprite インスタンスを作成します。
	 * var child:CastSprite = new CastSprite();
	 * 
	 * // AddChildAtAbove コマンドを作成します。
	 * var com:AddChildAtAbove = new AddChildAtAbove( container, child, 100 );
	 * 
	 * // AddChildAtAbove コマンドを実行します。
	 * com.execute();
	 * 
	 * // 結果を出力します。
	 * trace( container.contains( child ) ); // true
	 * </listing>
	 */
	public class AddChildAtAbove extends Command {
		
		/**
		 * <span lang="ja">DisplayObject インスタンスを追加する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</span>
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
		 * <span lang="ja">DisplayObject を追加するインデックス位置を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get index():int { return _index; }
		public function set index( value:int ):void { _index = value; }
		private var _index:int = 0;
		
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
		 * <span lang="ja">新しい AddChildAtAbove インスタンスを作成します。</span>
		 * <span lang="en">Creates a new AddChildAtAbove object.</span>
		 * 
		 * @param container
		 * <span lang="ja">指定された DisplayObject インスタンスを表示リストを追加する対象の DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param child
		 * <span lang="ja">表示リストに追加したい DisplayObject インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function AddChildAtAbove( container:DisplayObjectContainer, child:*, index:int, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			this.child = child;
			_index = index;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// すでに画面に配置されていれば終了する
			if ( _container.contains( _display ) ) {
				executeComplete();
				return;
			}
			
			// ディスプレイリストに追加する
			if ( _container is IExDisplayObjectContainer ) {
				IExDisplayObjectContainer( _container ).addChildAtAbove( _display, _index );
			}
			else {
				_container.addChildAt( _display, _index );
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
			_executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_ADDED ), extra, false, false );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 画面に配置されていなければ
			if ( !_container.contains( _display ) ) {
				// ディスプレイリストに追加する
				if ( _container is IExDisplayObjectContainer ) {
					IExDisplayObjectContainer( _container ).addChildAtAbove( _display, _index );
				}
				else {
					_container.addChildAt( _display, _index );
				}
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
			_executor.progression_internal::__interrupt( new CastEvent( CastEvent.CAST_ADDED ), extra, false, false );
		}
		
		/**
		 * <span lang="ja">AddChildAtAbove インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an AddChildAtAbove subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい AddChildAtAbove インスタンスです。</span>
		 * <span lang="en">A new AddChildAtAbove object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new AddChildAtAbove( _container, _child, _index, this ).setProperties( {
				autoAlpha:_autoAlpha
			} );
		}
		
		
		
		
		
		/**
		 * コマンドの処理が開始された場合に送出されます。
		 */
		private function _commandStart( e:CommandEvent ):void {
			// オートアルファが有効化されていれば
			if ( _autoAlpha > 0 ) {
				// 透明にする
				_display.alpha = 0;
				
				// コマンドを追加する
				_executor.progression_internal::__insertCommand( new DoTween( _display, { alpha:1 }, Regular.easeInOut, _autoAlpha ) );
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
			
			// executor プロパティが存在すれば
			if ( _child && "executor" in _child ) {
				_executor.progression_internal::__removeExecutable( _child );
			}
			
			// 処理を終了する
			if ( interrupting ) {
				interruptComplete();
			}
			else {
				interrupt( enforcedInterrupting, extra );
			}
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
