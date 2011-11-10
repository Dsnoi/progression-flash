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
	import flash.events.EventPhase;
	//import flash.display.NativeMenu;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExSprite;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.ui.ToolTip;
	
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
	 * <p>CastSprite クラスは、ExSprite クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // CastSprite を作成する
	 * var cast:CastSprite = new CastSprite();
	 * cast.graphics.beginFill( 0xFF000000 );
	 * cast.graphics.drawRect( 0, 0, 100, 100 );
	 * cast.graphics.endFill();
	 * cast.onCastAdded = function():void {
	 * 	trace( "CastSprite で CastEvent.CAST_ADDED イベントが送出されました。" );
	 * };
	 * cast.onCastRemoved = function():void {
	 * 	trace( "CastSprite で CastEvent.CAST_REMOVED イベントが送出されました。" );
	 * };
	 * 
	 * // Progression インスタンスを作成する
	 * var prog:Progression = new Progression( "index", stage );
	 * 
	 * // ルートシーンのイベントハンドラメソッドを設定します。
	 * prog.root.onLoad = function():void {
	 * 	// コマンドを実行する
	 * 	this.addCommand(
	 * 		// CastSprite を画面に表示する
	 * 		new AddChild( prog.container, cast )
	 * 	);
	 * };
	 * prog.root.onInit = function():void {
	 * 	// コマンドを実行する
	 * 	this.addCommand(
	 * 		// CastSprite を画面から削除する
	 * 		new RemoveChild( prog.container, cast )
	 * 	);
	 * };
	 * 
	 * // ルートシーンに移動します。
	 * prog.goto( new SceneId( "/index" ) );
	 * </listing>
	 */
	public class CastSprite extends ExSprite implements ICastObject {
		
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
		public function set eventHandlerEnabled( value:Boolean ):void { _castObject.eventHandlerEnabled = value; }
		
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
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CastSprite インスタンスを作成します。</p>
		 * <p>Creates a new CastSprite object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function CastSprite( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			_uiContextMenu = CastObjectContextMenu.progression_internal::__createInstance( this, super.contextMenu = new ContextMenu() );
			
			// 初期化する
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED, _added, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
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
		 * 表示オブジェクトが表示リストに追加されたときに送出されます。
		 */
		private function _added( e:Event ):void {
			// イベントがターゲット段階ではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// ICommandExecutable を取得する
			var executable:ICommandExecutable = parent as ICommandExecutable;
			
			// 存在すれば登録する
			if ( executable ) {
				executable.executor.progression_internal::__addExecutable( this );
			}
		}
		
		/*======================================================================*//**
		 * 表示オブジェクトが表示リストから削除されようとしているときに送出されます。
		 */
		private function _removed( e:Event ):void {
			// イベントがターゲット段階ではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// ICommandExecutable を取得する
			var executable:ICommandExecutable = parent as ICommandExecutable;
			
			// 存在すれば登録を削除する
			if ( executable ) {
				executable.executor.progression_internal::__removeExecutable( this );
			}
		}
	}
}









