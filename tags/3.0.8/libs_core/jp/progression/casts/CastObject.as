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
	import flash.display.DisplayObject;
	import jp.nium.events.EventIntegrator;
	import jp.progression.casts.ICastObject;
	import jp.progression.commands.ParallelList;
	import jp.progression.commands.SerialList;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	
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
	 * <p>CastObject クラスは、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトに必要な機能を実装した委譲クラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastObject extends EventIntegrator implements ICastObject {
		
		/*======================================================================*//**
		 * <p>委譲元となる DisplayObject インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get target():DisplayObject { return _target; }
		private var _target:DisplayObject;
		
		/*======================================================================*//**
		 * <p>CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parallelMode():Boolean { return _executor.progression_internal::__parallelMode; }
		public function set parallelMode( value:Boolean ):void { _executor.progression_internal::__parallelMode = value; }
		
		/*======================================================================*//**
		 * <p>コマンドを実行する CommandExecutor インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get executor():CommandExecutor { return _executor; }
		private var _executor:CommandExecutor;
		
		/*======================================================================*//**
		 * <p>オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		 * <p>新しい CastObject インスタンスを作成します。</p>
		 * <p>Creates a new CastObject object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>委譲元となる DisplayObject インスタンスです。</p>
		 * 	<p></p>
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
			_executor.progression_internal::__addCommand.apply( null, commands );
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
			_executor.progression_internal::__insertCommand.apply( null, commands );
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
			_executor.progression_internal::__clearCommand( completely );
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>オブジェクトのストリング表現です。</p>
		 * 	<p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return "[object CastObject]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * ICastObject オブジェクトが AddChild コマンド経由でディスプレイリストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// ICastObject を取得する
			var cast:ICastObject = ( _target as ICastObject ) || this;
			
			// イベントハンドラメソッドを実行する
			cast.onCastAdded.apply( cast );
		}
		
		/*======================================================================*//**
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









