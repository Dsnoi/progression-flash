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
package jp.progression.casts {
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExDocument;
	import jp.nium.events.DocumentEvent;
	import jp.nium.utils.StringUtil;
	import jp.progression.casts.CastLoader;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
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
	 * <span lang="ja">ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED
	 */
	[Event( name="castAdded", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED
	 */
	[Event( name="castRemoved", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">オブジェクトが読み込みを開始した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_START
	 */
	[Event( name="castLoadStart", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">オブジェクトが読み込みを完了した瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_COMPLETE
	 */
	[Event( name="castLoadComplete", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">CastPreloader クラスは、ExPreloader クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastPreloader extends ExDocument implements ICastObject {
		
		/**
		 * <span lang="ja">読み込む SWF ファイルの URL を取得または設定します。
		 * ただし、読み込み処理が開始された以降は設定を変更することはできません。</span>
		 * <span lang="en"></span>
		 */
		public function get url():String { return _url; }
		public function set url( value:String ):void {
			if ( _loaded ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9011", "url" ) ); }
			
			_url = value;
		}
		private var _url:String;
		
		/**
		 * <span lang="ja">オブジェクトをロードする前に、Flash Player がクロスドメインポリシーファイルの存在を確認するかどうかを取得または指定します。
		 * ただし、読み込み処理が開始された以降は設定を変更することはできません。</span>
		 * <span lang="en"></span>
		 */
		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }
		public function set checkPolicyFile( value:Boolean ):void {
			if ( _loaded ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9011", "checkPolicyFile" ) ); }
			
			_checkPolicyFile = value;
		}
		private var _checkPolicyFile:Boolean = false;
		
		/**
		 * <span lang="ja">url プロパティの値に相対パスを使用した際に、SWF ファイルの設置されているフォルダを基準とするかどうかを取得または設定します。
		 * ただし、読み込み処理が開始された以降は設定を変更することはできません。</span>
		 * <span lang="en"></span>
		 */
		public function get useSWFBasePath():Boolean { return _useSWFBasePath; }
		public function set useSWFBasePath( value:Boolean ):void {
			if ( _loaded ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9011", "useSWFBasePath" ) ); }
			
			_useSWFBasePath = value;
		}
		private var _useSWFBasePath:Boolean = false;
		
		/**
		 * <span lang="ja">すでに読み込み処理が開始されているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get loaded():Boolean { return _loaded; }
		private var _loaded:Boolean = false;
		
		/**
		 * <span lang="ja">そのメディアのロード済みのバイト数です。</span>
		 * <span lang="en">The number of bytes that are loaded for the media.</span>
		 */
		public function get bytesLoaded()				:int {
			try {
				return _loader.contentLoaderInfo.bytesLoaded;
			}
			catch ( e:Error ) {
			}
			
			return 0;
		}
		
		/**
		 * <span lang="ja">メディアファイル全体の圧縮後のバイト数です。</span>
		 * <span lang="en">The number of compressed bytes in the entire media file.</span>
		 */
		public function get bytesTotal()				:int {
			try {
				return _loader.contentLoaderInfo.bytesTotal;
			}
			catch ( e:Error ) {
			}
			
			return 0;
		}
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _loader.parallelMode; }
		public function set parallelMode( value:Boolean ):void { _loader.parallelMode = value; }
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _loader.executor; }
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _loader.eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _loader.eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( DocumentEvent.INIT, _init, false, 0, true );
				addExclusivelyEventListener( CastEvent.CAST_LOAD_START, _castLoadStart, false, 0, true );
				addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( DocumentEvent.INIT, _init );
				completelyRemoveEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
				completelyRemoveEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			}
		
		}
		
		/**
		 * @private
		 */
		public function get onCastAdded():Function { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastAdded" ) ); }
		public function set onCastAdded( value:Function ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastAdded" ) ); }
		
		/**
		 * @private
		 */
		protected final function _onCastAdded():void {}
		
		/**
		 * @private
		 */
		public function get onCastRemoved():Function { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastRemoved" ) ); }
		public function set onCastRemoved( value:Function ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastRemoved" ) ); }
		
		/**
		 * @private
		 */
		protected final function _onCastRemoved():void {}
		
		/**
		 * <span lang="ja">SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onInit():Function { return __onInit || _onInit; }
		public function set onInit( value:Function ):void { __onInit = value; }
		private var __onInit:Function;
		
		/**
		 * <span lang="ja">サブクラスで onInit イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onInit プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onInit():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが CastEvent.CAST_LOAD_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastLoadStart():Function { return __onCastLoadStart || _onCastLoadStart; }
		public function set onCastLoadStart( value:Function ):void { __onCastLoadStart = value; }
		private var __onCastLoadStart:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastLoadStart イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastLoadStart プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastLoadStart():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが CastEvent.CAST_LOAD_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastLoadComplete():Function { return __onCastLoadComplete || _onCastLoadComplete; }
		public function set onCastLoadComplete( value:Function ):void { __onCastLoadComplete = value; }
		private var __onCastLoadComplete:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastLoadComplete イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastLoadComplete プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastLoadComplete():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProgressEvent.PROGRESS イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onProgress():Function { return __onProgress || _onProgress; }
		public function set onProgress( value:Function ):void { __onProgress = value; }
		private var __onProgress:Function;
		
		/**
		 * <span lang="ja">サブクラスで onLoadProgress イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onLoadProgress プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProgress():void {}
		
		/**
		 * CastLoader インスタンスを取得します。 
		 */
		private var _loader:CastLoader = new CastLoader();
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastMovieClip インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastMovieClip object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function CastPreloader( initObject:Object = null ) {
			// stage が存在しなければ
			if ( !stage ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9013" ) ); }
			
			// CastObjectContextMenu を作成する
			Object( this )._initContextMenu();
			
			// 初期化する
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( DocumentEvent.INIT, _init, false, int.MAX_VALUE, true );
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
			_loader.addCommand.apply( this, commands );
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
			_loader.insertCommand.apply( this, commands );
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
			_loader.clearCommand( completely );
		}
		
		
		
		
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		private function _init( e:DocumentEvent ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( DocumentEvent.INIT, _init );
			
			// flashvars からファイルパスを取得する
			_url = loaderInfo.parameters.url || _url;
			_useSWFBasePath = StringUtil.toProperType( loaderInfo.parameters.useSWFBasePath ) || _useSWFBasePath;
			
			// イベントハンドラメソッドを実行する
			onInit();
			
			// 読み込むファイルの基点を設定する
			var url:String = _useSWFBasePath ? ExDocument.toSWFBasePath( _url ) : _url;
			
			// 読み込み処理を開始する
			_loaded = true;
			
			// イベントリスナーを登録する
			_loader.addExclusivelyEventListener( CastEvent.CAST_LOAD_START, dispatchEvent, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, dispatchEvent, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.UNLOAD, _unload, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			
			// 読み込みを開始する
			_loader.load( new URLRequest( url ), new LoaderContext( _checkPolicyFile, ApplicationDomain.currentDomain ) );
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
		 */
		private function _castLoadStart( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadStart();
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
		 */
		private function _castLoadComplete( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadComplete();
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
			
			// イベントを送出する
			dispatchEvent( e );
			
			// イベントリスナーを登録する
			_loader.executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
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
			
			// イベントハンドラメソッドを実行する
			onProgress();
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
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_loader.executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			
			// ディスプレイリストに追加する
			addChild( _loader );
		}
		
		
		
		
		
		/**
		 * 
		 */
		include "../core/includes/CastLoader_contextMenu.inc"
	}
}
