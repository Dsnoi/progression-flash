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
	import jp.progression.core.commands.ICommandExecutable;
	
	/**
	 * <span lang="ja">ICastObject インターフェイスは、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトに必要な機能を実装します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ICastObject extends ICommandExecutable {
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		function get parallelMode():Boolean;
		function set parallelMode( value:Boolean ):void;
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		function get onCastAdded():Function;
		function set onCastAdded( value:Function ):void;
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		function get onCastRemoved():Function;
		function set onCastRemoved( value:Function ):void;
		
		
		
		
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		function addCommand( ... commands:Array ):void;
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		function insertCommand( ... commands:Array ):void;
		
		/**
		 * <span lang="ja">登録されている Command インスタンスを削除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param completely
		 * <span lang="ja">true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</span>
		 * <span lang="en"></span>
		 */
		function clearCommand( completely:Boolean = false ):void;
	}
}
