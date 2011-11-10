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
	import fl.transitions.easing.Regular;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import jp.progression.commands.DoTween;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">UnloadChild クラスは、対象の DisplayObjectContainer インスタンスのディスプレイリストから request プロパティに設定された外部 SWF ファイルを削除するコマンドクラスです。
	 * 読み込まれた対象の SWF のドキュメントクラスが ICastObject インターフェイスを実装している場合には、CastEvent.REMOVED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // SerialList インスタンスを作成します。
	 * var list:SerialList = new SerialList();
	 * 
	 * // コマンドを追加します。
	 * list.addCommand(
	 * 	new LoadChild( container, new URLRequest( "external.swf" ) ),
	 * 	function():void {
	 * 		this.parent.insertCommand(
	 * 			new UnloadChild( container, this.previous.loader )
	 * 		);
	 * 	}
	 * );
	 * 
	 * // SerialList コマンドを実行します。
	 * list.execute();
	 * </listing>
	 */
	public class UnloadChild extends Command {
		
		/**
		 * <span lang="ja">DisplayObject インスタンスを追加する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/**
		 * <span lang="ja">この UnloadChild オブジェクトに関係した CastLoader オブジェクトです。
		 * この値が省略されると事前に LoadChild コマンドまたは LoadChildAt コマンドによって読み込まれた Loader を検索して、自動的に対象に設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get loader():Loader { return _loader; }
		public function set loader( value:Loader ):void { _loader = value; }
		private var _loader:Loader;
		
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
		 * <span lang="ja">新しい UnloadChild インスタンスを作成します。</span>
		 * <span lang="en">Creates a new UnloadChild object.</span>
		 * 
		 * @param container
		 * <span lang="ja">読み込んだファイル内容を表示リストから削除する対象の DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param request
		 * <span lang="ja">読み込まれた SWF、JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function UnloadChild( container:DisplayObjectContainer, loader:Loader, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			_loader = loader;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 存在しなければ
			if ( !_loader ) {
				if ( latestData is Loader ) {
					// 直前の Loader を取得する。
					_loader = Loader( latestData );
				}
				else {
					// 終了する
					executeComplete();
					return;
				}
			}
			
			// すでに画面に配置されていなければ終了する
			if ( !_container.contains( _loader ) ) {
				executeComplete();
				return;
			}
			
			// executor プロパティが存在すれば
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__addExecutable( _loader.content );
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
		 * <span lang="ja">UnloadChild インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an UnloadChild subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい UnloadChild インスタンスです。</span>
		 * <span lang="en">A new UnloadChild object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new UnloadChild( _container, _loader, this ).setProperties( {
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
				_executor.progression_internal::__addCommand( new DoTween( _loader.content, { alpha:0 }, Regular.easeInOut, _autoAlpha ) );
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
			if ( _container.contains( _loader ) ) {
				_container.removeChild( _loader );
			}
			
			// executor プロパティが存在すれば
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__removeExecutable( _loader.content );
			}
			
			// 破棄する
			_loader.unload();
			
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
			if ( _container.contains( _loader.content ) ) {
				_container.removeChild( _loader.content );
			}
			
			// executor プロパティが存在すれば
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__removeExecutable( _loader.content );
			}
			
			// 破棄する
			_loader.unload();
			
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
