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
package jp.progression.commands.display {
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jp.progression.casts.CastLoader;
	import jp.progression.core.commands.Command;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	/**
	 * <span lang="ja">LoadObject クラスは、対象の Loader インスタンスの読み込み状態を監視するするコマンドクラスです。
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // 外部ファイルを読み込む CastLoader インスタンスを作成します。
	 * var loader:CastLoader = new CastLoader();
	 * 
	 * // 複数のコマンドを連続で実行するコマンドリストを作成します。
	 * var com:SerialList = new SerialList( null,
	 * 	// 外部ファイルの読み込みを制御します。
	 * 	new LoadObject( loader, new URLRequest( "external.swf" ), {
	 * 		// 読み込み処理が開始された際に実行したい関数を指定します。
	 * 		onCastLoadStart:function():void {
	 * 			this.addCommand(
	 * 				new Trace( "start" )
	 * 			);
	 * 		},
	 * 		// 読み込み処理中に実行したい関数を指定します。
	 * 		onProgress:function():void {
	 * 			trace( this.bytesLoaded / this.bytesTotal );
	 * 		},
	 * 		// 読み込み処理が完了した際に実行したい関数を指定します。
	 * 		onCastLoadComplete:function():void {
	 * 			this.addCommand(
	 * 				new Trace( "complete" )
	 * 			);
	 * 		}
	 * 	} ),
	 * 	// 画面に表示します。
	 * 	new AddChild( prog.container, loader ),
	 * 	// 画面から削除します。
	 * 	new RemoveChild( prog.container, loader ),
	 * 	// 読み込みを破棄します。
	 * 	new UnloadObject( loader )
	 * );
	 * 
	 * // コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class LoadObject extends Command {
		
		/**
		 * <span lang="ja">読み込み処理を監視したい CastLoader インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get loader():CastLoader { return _loader; }
		public function set loader( value:CastLoader ):void { _loader = value; }
		private var _loader:CastLoader;
		
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
		 * <span lang="ja">ロード操作中に、既にロード済みのデータのバイト数を示します。</span>
		 * <span lang="en"></span>
		 */
		public function get bytesLoaded():int { return _loader.contentLoaderInfo.bytesLoaded; }
		
		/**
		 * <span lang="ja">ダウンロードデータの合計バイト数を示します。</span>
		 * <span lang="en"></span>
		 */
		public function get bytesTotal():int { return _loader.contentLoaderInfo.bytesTotal; }
		
		/**
		 * <span lang="ja">シーンオブジェクトが CastEvent.CAST_LOAD_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastLoadStart():Function { return _onCastLoadStart; }
		public function set onCastLoadStart( value:Function ):void { _onCastLoadStart = value; }
		private var _onCastLoadStart:Function;
		
		/**
		 * <span lang="ja">シーンオブジェクトが CastEvent.CAST_LOAD_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastLoadComplete():Function { return _onCastLoadComplete; }
		public function set onCastLoadComplete( value:Function ):void { _onCastLoadComplete = value; }
		private var _onCastLoadComplete:Function;
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProgressEvent.PROGRESS イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onProgress():Function { return _onProgress; }
		public function set onProgress( value:Function ):void { _onProgress = value; }
		private var _onProgress:Function;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい LoadObject インスタンスを作成します。</span>
		 * <span lang="en">Creates a new LoadObject object.</span>
		 * 
		 * @param loader
		 * <span lang="ja">読み込み処理を監視したい CastLoader インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param request
		 * <span lang="ja">読み込みたい SWF、JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function LoadObject( loader:CastLoader, request:URLRequest, initObject:Object = null ) {
			// 引数を設定する
			_loader = loader;
			_request = request;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// イベントリスナーを登録する
			_loader.addExclusivelyEventListener( CastEvent.CAST_LOAD_START, _castLoadStart, false, 0, true );
			_loader.addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete, false, 0, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress, false, 0, true );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, 0, true );
			
			// ファイルを読み込む
			_loader.load( request, _context );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// イベントリスナーを解除する
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// 読み込み処理を中断する
			_loader.close();
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function addCommand( ... commands:Array ):void {
			_loader.addCommand.apply( _loader, commands );
		}
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function insertCommand( ... commands:Array ):void {
			_loader.insertCommand.apply( _loader, commands );
		}
		
		/**
		 * <span lang="ja">登録されている Command インスタンスを削除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param completely
		 * <span lang="ja">true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</span>
		 * <span lang="en"></span>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			_loader.clearCommand.apply( _loader, completely );
		}
		
		/**
		 * <span lang="ja">LoadObject インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an LoadObject subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい LoadObject インスタンスです。</span>
		 * <span lang="en">A new LoadObject object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new LoadObject( _loader, _request, this );
		}
		
		
		
		
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
		 */
		private function _castLoadStart( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			if ( _onCastLoadStart is Function ) {
				onCastLoadStart.apply( this );
			}
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
		 */
		private function _castLoadComplete( e:CastEvent ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			
			// イベントリスナーを登録する
			_loader.executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, 0, true );
			
			// イベントハンドラメソッドを実行する
			if ( _onCastLoadComplete is Function ) {
				onCastLoadComplete.apply( this  );
			}
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_loader.executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			
			// 設定情報を破棄する
			_loader = null;
			_request = null;
			_context = null;
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントハンドラメソッドを実行する
			if ( _onProgress is Function ) {
				onProgress.apply( this  );
			}
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
			_loader.completelyRemoveEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			
			// 設定情報を破棄する
			_loader = null;
			_request = null;
			_context = null;
			
			// エラーをハンドリングする
			_catchError( this, Error( e ) );
		}
	}
}
