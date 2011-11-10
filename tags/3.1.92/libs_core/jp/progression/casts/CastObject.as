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
package jp.progression.casts {
	import flash.display.DisplayObject;
	import jp.nium.events.EventIntegrator;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	
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
	 * <span lang="ja">CastObject クラスは、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトに必要な機能を実装した委譲クラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CastObject extends EventIntegrator implements ICastObject {
		
		/**
		 * <span lang="ja">委譲元となる DisplayObject インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():DisplayObject { return _target; }
		private var _target:DisplayObject;
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _executor.progression_internal::__parallelMode; }
		public function set parallelMode( value:Boolean ):void { _executor.progression_internal::__parallelMode = value; }
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _executor; }
		private var _executor:CommandExecutor;
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( CastEvent.CAST_ADDED, _castAdded, false, 0, true );
				addExclusivelyEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( CastEvent.CAST_ADDED, _castAdded );
				completelyRemoveEventListener( CastEvent.CAST_REMOVED, _castRemoved );
			}
		}
		private var _eventHandlerEnabled:Boolean = true;
		
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
		 * <span lang="ja">新しい CastObject インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastObject object.</span>
		 * 
		 * @param target
		 * <span lang="ja">委譲元となる DisplayObject インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function CastObject( target:DisplayObject ) {
			// 引数を設定する
			_target = target;
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
			
			// 初期化する
			eventHandlerEnabled = true;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CastEvent.CAST_ADDED, _target.dispatchEvent, false, 0, true );
			addExclusivelyEventListener( CastEvent.CAST_REMOVED, _target.dispatchEvent, false, 0, true );
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
			_executor.progression_internal::__addCommand.apply( null, commands );
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
			_executor.progression_internal::__insertCommand.apply( null, commands );
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
			_executor.progression_internal::__clearCommand( completely );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return "[object CastObject]";
		}
		
		
		
		
		
		/**
		 * ICastObject オブジェクトが AddChild コマンド経由でディスプレイリストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// ICastObject を取得する
			var cast:ICastObject = ( _target as ICastObject ) || this;
			
			// イベントハンドラメソッドを実行する
			cast.onCastAdded.apply( cast );
		}
		
		/**
		 * ICastObject オブジェクトが RemoveChild コマンド経由でディスプレイリストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			// ICastObject を取得する
			var cast:ICastObject = ( _target as ICastObject ) || this;
			
			// イベントハンドラメソッドを実行する
			cast.onCastRemoved.apply( cast );
		}
	}
}
