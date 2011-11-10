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
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jp.progression.casts.CastLoader;
	import jp.progression.core.commands.Command;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.errors.CommandExecuteError;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">ロード操作が開始したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.OPEN
	 */
	[Event( name="open", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">データが正常にロードされたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">ロードされたオブジェクトが Loader オブジェクトの unload() メソッドを使用して削除されるたびに、LoaderInfo オブジェクトによって送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.UNLOAD
	 */
	[Event( name="unload", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">ダウンロード処理を実行中にデータを受信したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <span lang="ja">ネットワーク要求が HTTP を介して行われ、Flash Player が HTTP 状況コードを検出できる場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
	 */
	[Event( name="httpStatus", type="flash.events.HTTPStatusEvent" )]
	
	/**
	 * <span lang="ja">入出力エラーが発生してロード処理が失敗したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	/**
	 * <span lang="ja">LoadChildAt クラスは、対象の DisplayObjectContainer インスタンスのディスプレイリストに request プロパティに設定された外部 SWF ファイルを読み込んで追加するコマンドクラスです。
	 * 読み込む対象の SWF ファイルのドキュメントクラスが ICastObject インターフェイスを実装している場合には、CastEvent.ADDED イベントが送出され、
	 * 対象のイベント処理の実行中に、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // 表示コンテナとなる Sprite インスタンスを作成します。
	 * var container:Sprite = new Sprite();
	 * 
	 * // LoadChildAt コマンドを作成します。
	 * var com:LoadChildAt = new LoadChild( container, new URLRequest( "external.swf" ), 0 );
	 * 
	 * // オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
	 * com.loader.onCastLoadStart = function():void {
	 * 	this.addCommand(
	 * 		new Trace( "onCastLoadStart" )
	 * 	);
	 * };
	 * 
	 * // オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
	 * com.loader.onCastLoadComplete = function():void {
	 * 	this.addCommand(
	 * 		new Trace( "onCastLoadComplete" )
	 * 	);
	 * };
	 * 
	 * // エラー処理を設定します。
	 * com.error( function( e:Error ):void {
	 * 	// エラーを解決します。
	 * 	this.executeComplete();
	 * } );
	 * 
	 * // LoadChildAt コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class LoadChildAt extends Command {
		
		/**
		 * <span lang="ja">読み込んだファイル内容を追加する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/**
		 * <span lang="ja">読み込みたい SWF、JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get request():URLRequest { return _request; }
		public function set request( value:URLRequest ):void { _request = value; }
		private var _request:URLRequest;
		
		/**
		 * <span lang="ja">ポリシーファイルの存在の確認や、ApplicationDomain 及び SecurityDomain の設定を行う LoaderContext を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get context():LoaderContext { return _context; }
		public function set context( value:LoaderContext ):void { _context = value; }
		private var _context:LoaderContext;
		
		/**
		 * <span lang="ja">読み込んだファイル内容を追加するインデックス位置を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get index():int { return _index; }
		public function set index( value:int ):void { _index = value; }
		private var _index:int = 0;
		
		/**
		 * <span lang="ja">読み込んだファイル内容を表示する際に、alpha プロパティを使用したアルファフェード効果を適用するミリ秒を取得または設定します。
		 * この値が 0 である場合には、アルファフェード効果は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		public function get autoAlpha():int { return _autoAlpha; }
		public function set autoAlpha( value:int ):void { _autoAlpha = Math.max( 0, value ); }
		private var _autoAlpha:int = 0;
		
		/**
		 * <span lang="ja">この LoadChildAt オブジェクトに関係した CastLoader オブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function get loader():CastLoader { return _loader; }
		private var _loader:CastLoader = new CastLoader();
		
		/**
		 * CommandExecutor インスタンスを取得します。
		 */
		private var _executor:CommandExecutor;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい LoadChildAt インスタンスを作成します。</span>
		 * <span lang="en">Creates a new LoadChildAt object.</span>
		 * 
		 * @param container
		 * <span lang="ja">読み込んだファイル内容を表示リストを追加する対象の DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param request
		 * <span lang="ja">読み込みたい SWF、JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</span>
		 * <span lang="en"></span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function LoadChildAt( container:DisplayObjectContainer, request:URLRequest, index:int, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			_request = request;
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
			// イベントリスナーを登録する
			_loader.contentLoaderInfo.addEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.UNLOAD, _unload, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			
			// ファイルを読み込む
			_loader.load( request, _context );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">LoadChildAt インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an LoadChildAt subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい LoadChildAt インスタンスです。</span>
		 * <span lang="en">A new LoadChildAt object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new LoadChildAt( _container, _request, _index, this ).setProperties( {
				autoAlpha:_autoAlpha,
				context:_context
			} );
		}
		
		
		
		
		
		/**
		 * ロード操作が開始したときに送出されます。
		 */
		private function _open( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( Event.OPEN, _open );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( Event.UNLOAD, _unload );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// データを登録する
			latestData = _loader;
			
			// イベントを送出する
			dispatchEvent( e );
			
			// イベントリスナーを登録する
			_loader.executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoader, false, int.MAX_VALUE, true );
		}
		
		/**
		 * ロードされたオブジェクトが Loader オブジェクトの unload() メソッドを使用して削除されるたびに、LoaderInfo オブジェクトによって送出されます。
		 */
		private function _unload( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * ネットワーク要求が HTTP を介して行われ、Flash Player が HTTP 状況コードを検出できる場合に送出されます。
		 */
		private function _httpStatus( e:HTTPStatusEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( Event.OPEN, _open );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( Event.UNLOAD, _unload );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// イベントを送出する
			dispatchEvent( e );
			
			// エラー処理を実行する
			_catchError( this, new CommandExecuteError( "Error : " + e.text ) );
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandCompleteLoader( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_loader.executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoader );
			
			// すでに画面に配置されていれば終了する
			if ( _container.contains( _loader ) ) {
				executeComplete();
				return;
			}
			
			// ディスプレイリストに追加する
			_container.addChildAt( _loader, _index );
			
			// executor プロパティが存在すれば
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__addExecutable( _loader.content );
			}
			
			// 実行する
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_START, _commandStart, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_ADDED ), extra, false, false );
		}
		
		/**
		 * コマンドの処理が開始された場合に送出されます。
		 */
		private function _commandStart( e:CommandEvent ):void {
			// オートアルファが有効化されていれば
			if ( _autoAlpha > 0 ) {
				// 透明にする
				_loader.content.alpha = 0;
				
				// コマンドを追加する
				_executor.progression_internal::__insertCommand( new DoTween( _loader.content, { alpha:1 }, Regular.easeInOut, _autoAlpha ) );
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
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__removeExecutable( _loader.content );
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
			if ( "executor" in _loader.content ) {
				_executor.progression_internal::__removeExecutable( _loader.content );
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
