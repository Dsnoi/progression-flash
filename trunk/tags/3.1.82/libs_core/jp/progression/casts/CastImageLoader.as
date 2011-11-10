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
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jp.nium.display.ExImageLoader;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.ui.ToolTip;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
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
	 * <span lang="ja">オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_START
	 */
	[Event( name="castLoadStart", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_COMPLETE
	 */
	[Event( name="castLoadComplete", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">CastImageLoader クラスは、ExImageLoader クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastImageLoader extends ExImageLoader implements ICastObject {
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _castObject.parallelMode; }
		public function set parallelMode( value:Boolean ):void { _castObject.parallelMode = value; }
		
		/**
		 * <span lang="ja">このオブジェクトに関連付けられている ToolTip インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get toolTip():ToolTip { return _toolTip; }
		private var _toolTip:ToolTip;
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _castObject.executor; }
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _castObject.eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _castObject.eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( CastEvent.CAST_LOAD_START, _castLoadStart, false, 0, true );
				addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( CastEvent.CAST_LOAD_START, _castLoadStart );
				completelyRemoveEventListener( CastEvent.CAST_LOAD_COMPLETE, _castLoadComplete );
			}
		}
		
		/**
		 * <span lang="ja">このオブジェクトに関連付けられている CastObjectContextMenu インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get uiContextMenu():CastObjectContextMenu { return _uiContextMenu; }
		private var _uiContextMenu:CastObjectContextMenu;
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastAdded():Function { return __onCastAdded || _onCastAdded; }
		public function set onCastAdded( value:Function ):void { __onCastAdded = value; }
		private var __onCastAdded:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastAdded イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastAdded プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastAdded():void {}
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastRemoved():Function { return __onCastRemoved || _onCastRemoved; }
		public function set onCastRemoved( value:Function ):void { __onCastRemoved = value; }
		private var __onCastRemoved:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastRemoved イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRemoved プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastRemoved():void {}
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_LOAD_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
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
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_LOAD_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
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
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		/**
		 * URLRequest インスタンスを取得します。
		 */
		private var _request:URLRequest;
		
		/**
		 * LoaderContext インスタンスを取得します。
		 */
		private var _context:LoaderContext;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastImageLoader インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastImageLoader object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function CastImageLoader( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			Object( this )._initContextMenu();
			
			// 初期化する
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			_castObject.addExclusivelyEventListener( CastEvent.CAST_LOAD_START, dispatchEvent, false, 0, true );
			_castObject.addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, dispatchEvent, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">イメージファイルを読み込みます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param request
		 * <span lang="ja">読み込む JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</span>
		 * <span lang="en"></span>
		 * @param context
		 * <span lang="ja">LoaderContext オブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public override function load( request:URLRequest, context:LoaderContext = null ):void {
			// 引数を設定する
			_request = request;
			_context = context;
			
			// イベントリスナーを登録する
			contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			
			// 実行する
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoad, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptLoad, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandErrorLoad, false, int.MAX_VALUE, true );
			executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_LOAD_START ), {}, false, true );
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
			_castObject.addCommand.apply( this, commands );
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
			_castObject.insertCommand.apply( this, commands );
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
			_castObject.clearCommand( completely );
		}
		
		
		
		
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
		 */
		private function _castLoadStart( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadStart.apply( this );
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
		 */
		private function _castLoadComplete( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadComplete.apply( this );
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandCompleteLoad( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorLoad );
			
			// 読み込みを開始する
			super.load( _request, _context );
			
			// 内容を破棄する
			_request = null;
			_context = null;
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterruptLoad( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorLoad );
		}
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandErrorLoad( e:CommandEvent ):void {
			// エラーを送出する
			throw e.errorObject;
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// 実行する
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete, false, int.MAX_VALUE, true );
			executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_LOAD_COMPLETE ), {}, true, true );
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandCompleteComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete );
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterruptComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete );
		}
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandErrorComplete( e:CommandEvent ):void {
			// エラーを送出する
			throw e.errorObject;
		}
		
		
		
		
		
		/**
		 * 
		 */
		include "../core/includes/CastObject_contextMenu.inc"
	}
}
