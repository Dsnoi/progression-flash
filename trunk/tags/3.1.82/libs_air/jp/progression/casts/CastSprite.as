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
	import flash.events.EventPhase;
	import flash.events.Event;
	import jp.nium.display.ExSprite;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.ui.ToolTip;
	
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
	 * <span lang="ja">CastSprite クラスは、ExSprite クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en"></span>
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
		public function set eventHandlerEnabled( value:Boolean ):void { _castObject.eventHandlerEnabled = value; }
		
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
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastSprite インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastSprite object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function CastSprite( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			Object( this )._initContextMenu();
			
			// 初期化する
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED, _added, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
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
		
		/**
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
		
		
		
		
		
		/**
		 * 
		 */
		include "../core/includes/CastObject_contextMenu.inc"
	}
}
