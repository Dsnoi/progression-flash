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
package jp.progression.core.debug {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.external.BrowserInterface;
	import jp.nium.utils.ArrayUtil;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Verbose クラスは、コンテンツ制作者向けの出力機能を制御するデバッギングクラスです。
	 * Verbose クラスを直接インスタンス化することはできません。
	 * new Verbose() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class Verbose {
		
		/**
		 * プロジェクトパネルとの LocalConnection に使用する識別子を取得します。
		 */
		public static const PROGRESSION_PROJECT_PANEL:String = "progressionProjectPanel";
		
		/**
		 * デバッガーパネルとの LocalConnection に使用する識別子を取得します。
		 */
		public static const PROGRESSION_DEBUGGER_PANEL:String = "progressionDebuggerPanel";
		
		
		
		
		
		/**
		 * <span lang="ja">コンテンツ制作者向けのデバッグ機能を有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void { _enabled = value; }
		private static var _enabled:Boolean = false;
		
		/**
		 * <span lang="ja">出力されたログの一覧を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get records():Array { return _records.slice(); }
		private static var _records:Array = [];
		
		/**
		 * <span lang="ja">Progression Debugger パネルと通信が確立されているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get connecting():Boolean { return _connecting; }
		private static var _connecting:Boolean = false;
		
		/**
		 * <span lang="ja">ログ出力に使用するロギング関数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get loggingFunction():Function { return _loggingFunction; }
		public static function set loggingFunction( value:Function ):void { _loggingFunction = value || trace; }
		private static var _loggingFunction:Function = trace;
		
		/**
		 * フィルタリングするクラスを格納した配列を取得します。
		 */
		private static var _filters:Array = [];
		
		
		
		
		
		/**
		 * @private
		 */
		public function Verbose() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Verbose" ) );
		}
		
		
		
		
		/**
		 * <span lang="ja">通常ログを出力します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">出力を実行するオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param messages
		 * <span lang="ja">出力したいストリングです。</span>
		 * <span lang="en"></span>
		 * @param separateBefore
		 * <span lang="ja">出力する直前にセパレータを表示するかどうかです。</span>
		 * <span lang="en"></span>
		 */
		public static function log( target:* = null, message:String = null, separateBefore:Boolean = false ):void {
			if ( !_enabled ) { return; }
			
			if ( separateBefore ) {
				separate();
			}
			
			// target を配列化する
			var list:Array = target as Array || [ target ];
			
			// フィルタリング対象が設定されていれば終了する
			var l:int = list.length;
			for ( var i:int = 0; i < l; i++ ) {
				var ll:int = _filters.length;
				for ( var ii:int = 0; ii < ll; ii++ ) {
					if ( list[i] is _filters[ii] ) { return; }
				}
			}
			
			// ヘッダを追加する
			message = "[LOG] " + message;
			
			// 出力する
			_loggingFunction.apply( null, [ message ] );
			
			// レコードに追加する
			_records.push( message );
		}
		
		/**
		 * <span lang="ja">警告ログを表示します。
		 * このログは enabled プロパティで無効化されている場合にも出力されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">出力を実行するオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param messages
		 * <span lang="ja">出力したいストリングです。</span>
		 * <span lang="en"></span>
		 */
		public static function warning( target:* = null, message:String = null ):void {
			target;
			
			// ヘッダを追加する
			message = "[WARNING] " + message;
			
			// 出力する
			_loggingFunction.apply( null, [ message ] );
			
			// レコードに追加する
			_records.push( message );
		}
		
		/**
		 * <span lang="ja">エラーログを表示します。
		 * このログは enabled プロパティで無効化されている場合にも出力されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">出力を実行するオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param messages
		 * <span lang="ja">出力したいストリングです。</span>
		 * <span lang="en"></span>
		 */
		public static function error( target:* = null, message:String = null ):void {
			target;
			
			// ヘッダを追加する
			message = "[ERROR] " + message;
			
			// 出力する
			_loggingFunction.apply( null, [ message ] );
			
			// レコードに追加する
			_records.push( message );
		}
		
		/**
		 * <span lang="ja">セパレータを出力します。</span>
		 * <span lang="en"></span>
		 */
		public static function separate():void {
			if ( !enabled ) { return; }
			
			_loggingFunction( "\n----------------------------------------------------------------------" );
		}
		
		/**
		 * <span lang="ja">フィルタリングしたいクラスを追加します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">フィルタリングしたいクラスの参照です。</span>
		 * <span lang="en"></span>
		 */
		public static function addFilter( target:Class ):void {
			// すでに登録されていれば終了する
			if ( hasFilter( target ) ) { return; }
			
			// リストに登録する
			_filters.push( target );
		}
		
		/**
		 * <span lang="ja">フィルタリング対象からクラスを削除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">フィルタリング対象から削除したいクラスの参照です。</span>
		 * <span lang="en"></span>
		 */
		public static function removeFilter( target:Class ):void {
			var index:int = ArrayUtil.getItemIndex( _filters, target );
			
			if ( index == -1 ) { return; }
			
			_filters.splice( index, 1 );
		}
		
		/**
		 * <span lang="ja">全てのフィルタリング設定を削除します。</span>
		 * <span lang="en"></span>
		 */
		public static function removeAllFilters():void {
			_filters = [];
		}
		
		/**
		 * <span lang="ja">対象がフィルタリング指定されているかどうかを判別します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">テストしたいクラスの参照です。</span>
		 * <span lang="en"></span>
		 */
		public static function hasFilter( target:Class ):Boolean {
			return ( ArrayUtil.getItemIndex( _filters, target ) != -1 );
		}
		
		/**
		 * <span lang="ja">Command クラス、及び Command クラスを継承したサブクラスをフィルタリング対象とします。</span>
		 * <span lang="en"></span>
		 */
		public static function filteringCommand():void {
			addFilter( Command );
		}
		
		/**
		 * @private
		 */
		public static function reload():void {
			BrowserInterface.reload();
			BrowserInterface.call( "window.focus" );
		}
	}
}
