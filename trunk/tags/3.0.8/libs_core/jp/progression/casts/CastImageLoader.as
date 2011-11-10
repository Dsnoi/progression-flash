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
package jp.progression.casts {
	//import flash.display.NativeMenu;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.ui.ContextMenu;
	import jp.nium.core.errors.ErrorMessageConstants;
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
	
	/*======================================================================*//**
	 * <p>ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED
	 */
	[Event( name="castAdded", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED
	 */
	[Event( name="castRemoved", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_START
	 */
	[Event( name="castLoadStart", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_LOAD_COMPLETE
	 */
	[Event( name="castLoadComplete", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>CastImageLoader クラスは、ExImageLoader クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastImageLoader extends ExImageLoader implements ICastObject {
		
		/*======================================================================*//**
		 * <p>CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parallelMode():Boolean { return _castObject.parallelMode; }
		public function set parallelMode( value:Boolean ):void { _castObject.parallelMode = value; }
		
		/*======================================================================*//**
		 * <p>このオブジェクトに関連付けられている ToolTip インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get toolTip():ToolTip { return _toolTip; }
		private var _toolTip:ToolTip;
		
		/*======================================================================*//**
		 * <p>コマンドを実行する CommandExecutor インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get executor():CommandExecutor { return _castObject.executor; }
		
		/*======================================================================*//**
		 * <p>オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>このオブジェクトに関連付けられている CastObjectContextMenu インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get uiContextMenu():CastObjectContextMenu { return _uiContextMenu; }
		private var _uiContextMenu:CastObjectContextMenu;
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get contextMenu():ContextMenu { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9022" ) ); }
		public override function set contextMenu( value:ContextMenu ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9022" ) ); }
		//public override function get contextMenu():NativeMenu { return super.contextMenu; }
		//public override function set contextMenu( value:NativeMenu ):void { super.contextMenu = value; }
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastAdded():Function { return __onCastAdded || _onCastAdded; }
		public function set onCastAdded( value:Function ):void { __onCastAdded = value; }
		private var __onCastAdded:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastAdded イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastAdded プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastAdded():void {}
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastRemoved():Function { return __onCastRemoved || _onCastRemoved; }
		public function set onCastRemoved( value:Function ):void { __onCastRemoved = value; }
		private var __onCastRemoved:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastRemoved イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRemoved プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastRemoved():void {}
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_LOAD_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastLoadStart():Function { return __onCastLoadStart || _onCastLoadStart; }
		public function set onCastLoadStart( value:Function ):void { __onCastLoadStart = value; }
		private var __onCastLoadStart:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastLoadStart イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastLoadStart プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastLoadStart():void {}
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_LOAD_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastLoadComplete():Function { return __onCastLoadComplete || _onCastLoadComplete; }
		public function set onCastLoadComplete( value:Function ):void { __onCastLoadComplete = value; }
		private var __onCastLoadComplete:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastLoadComplete イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastLoadComplete プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastLoadComplete():void {}
		
		/*======================================================================*//**
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		/*======================================================================*//**
		 * URLRequest インスタンスを取得します。
		 */
		private var _request:URLRequest;
		
		/*======================================================================*//**
		 * LoaderContext インスタンスを取得します。
		 */
		private var _context:LoaderContext;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CastImageLoader インスタンスを作成します。</p>
		 * <p>Creates a new CastImageLoader object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function CastImageLoader( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			_uiContextMenu = CastObjectContextMenu.progression_internal::__createInstance( this, super.contextMenu = new ContextMenu() );
			
			// 初期化する
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			_castObject.addExclusivelyEventListener( CastEvent.CAST_LOAD_START, dispatchEvent, false, 0, true );
			_castObject.addExclusivelyEventListener( CastEvent.CAST_LOAD_COMPLETE, dispatchEvent, false, 0, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>イメージファイルを読み込みます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param request
		 * 	<p>読み込む JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</p>
		 * 	<p></p>
		 * @param context
		 * 	<p>LoaderContext オブジェクトです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 */
		public function addCommand( ... commands:Array ):void {
			_castObject.addCommand.apply( this, commands );
		}
		
		/*======================================================================*//**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 */
		public function insertCommand( ... commands:Array ):void {
			_castObject.insertCommand.apply( this, commands );
		}
		
		/*======================================================================*//**
		 * <p>登録されている Command インスタンスを削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</p>
		 * 	<p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			_castObject.clearCommand( completely );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
		 */
		private function _castLoadStart( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadStart.apply( this );
		}
		
		/*======================================================================*//**
		 * オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
		 */
		private function _castLoadComplete( e:CastEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastLoadComplete.apply( this );
		}
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterruptLoad( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptLoad );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorLoad );
		}
		
		/*======================================================================*//**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandErrorLoad( e:CommandEvent ):void {
			// エラーを送出する
			throw e.errorObject;
		}
		
		/*======================================================================*//**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// 実行する
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete, false, int.MAX_VALUE, true );
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete, false, int.MAX_VALUE, true );
			executor.progression_internal::__execute( new CastEvent( CastEvent.CAST_LOAD_COMPLETE ), {}, true, true );
		}
		
		/*======================================================================*//**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
		}
		
		/*======================================================================*//**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandCompleteComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete );
		}
		
		/*======================================================================*//**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterruptComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterruptComplete );
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandErrorComplete );
		}
		
		/*======================================================================*//**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandErrorComplete( e:CommandEvent ):void {
			// エラーを送出する
			throw e.errorObject;
		}
	}
}









