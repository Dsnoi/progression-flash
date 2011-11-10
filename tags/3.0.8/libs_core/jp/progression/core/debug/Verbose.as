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
package jp.progression.core.debug {
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.external.BrowserInterface;
	import jp.nium.utils.ArrayUtil;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Verbose クラスは、コンテンツ制作者向けの出力機能を制御するデバッギングクラスです。
	 * Verbose クラスを直接インスタンス化することはできません。
	 * new Verbose() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Verbose {
		
		/*======================================================================*//**
		 * プロジェクトパネルとの LocalConnection に使用する識別子を取得します。
		 */
		public static const PROGRESSION_PROJECT_PANEL:String = "progressionProjectPanel";
		
		/*======================================================================*//**
		 * デバッガーパネルとの LocalConnection に使用する識別子を取得します。
		 */
		public static const PROGRESSION_DEBUGGER_PANEL:String = "progressionDebuggerPanel";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>コンテンツ制作者向けのデバッグ機能を有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void {
			// 有効化されていれば
			if ( _enabled = value ) {
				// LocalConnection を作成する
				_connect ||= new LocalConnection();
				
				// イベントリスナーを登録する
				_connect.addEventListener( StatusEvent.STATUS, _status, false, int.MAX_VALUE, true );
				_connect.client = Verbose;
				try {
					_connect.connect( PROGRESSION_PROJECT_PANEL );
					_connect.connect( PROGRESSION_DEBUGGER_PANEL );
				}
				catch ( e:Error ) {
					warning( Verbose, "デバッグ接続に失敗しました。" );
				}
			}
			else if ( _connect ) {
				// 接続を閉じる
				_connect.close();
				
				// イベントリスナーを解除する
				_connect.removeEventListener( StatusEvent.STATUS, _status );
			}
		}
		private static var _enabled:Boolean = false;
		
		/*======================================================================*//**
		 * <p>出力されたログの一覧を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get records():Array { return _records.slice(); }
		private static var _records:Array = [];
		
		/*======================================================================*//**
		 * <p>Progression Debugger パネルと通信が確立されているかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get connecting():Boolean { return _connecting; }
		private static var _connecting:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ログ出力に使用するロギング関数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get loggingFunction():Function { return _loggingFunction; }
		public static function set loggingFunction( value:Function ):void { _loggingFunction = value || trace; }
		private static var _loggingFunction:Function = trace;
		
		/*======================================================================*//**
		 * フィルタリングするクラスを格納した配列を取得します。
		 */
		private static var _filters:Array = [];
		
		/*======================================================================*//**
		 * LocalConnection インスタンスを取得します。
		 */
		private static var _connect:LocalConnection;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function Verbose() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Verbose" ) );
		}
		
		
		
		
		/*======================================================================*//**
		 * <p>通常ログを出力します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>出力を実行するオブジェクトです。</p>
		 * 	<p></p>
		 * @param messages
		 * 	<p>出力したいストリングです。</p>
		 * 	<p></p>
		 * @param separateBefore
		 * 	<p>出力する直前にセパレータを表示するかどうかです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>警告ログを表示します。
		 * このログは enabled プロパティで無効化されている場合にも出力されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>出力を実行するオブジェクトです。</p>
		 * 	<p></p>
		 * @param messages
		 * 	<p>出力したいストリングです。</p>
		 * 	<p></p>
		 */
		public static function warning( target:* = null, message:String = null ):void {
			// ヘッダを追加する
			message = "[WARNING] " + message;
			
			// 出力する
			_loggingFunction.apply( null, [ message ] );
			
			// レコードに追加する
			_records.push( message );
		}
		
		/*======================================================================*//**
		 * <p>エラーログを表示します。
		 * このログは enabled プロパティで無効化されている場合にも出力されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>出力を実行するオブジェクトです。</p>
		 * 	<p></p>
		 * @param messages
		 * 	<p>出力したいストリングです。</p>
		 * 	<p></p>
		 */
		public static function error( target:* = null, message:String = null ):void {
			// ヘッダを追加する
			message = "[ERROR] " + message;
			
			// 出力する
			_loggingFunction.apply( null, [ message ] );
			
			// レコードに追加する
			_records.push( message );
		}
		
		/*======================================================================*//**
		 * <p>セパレータを出力します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function separate():void {
			if ( !enabled ) { return; }
			
			_loggingFunction( "\n----------------------------------------------------------------------" );
		}
		
		/*======================================================================*//**
		 * <p>フィルタリングしたいクラスを追加します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>フィルタリングしたいクラスの参照です。</p>
		 * 	<p></p>
		 */
		public static function addFilter( target:Class ):void {
			// すでに登録されていれば終了する
			if ( hasFilter( target ) ) { return; }
			
			// リストに登録する
			_filters.push( target );
		}
		
		/*======================================================================*//**
		 * <p>フィルタリング対象からクラスを削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>フィルタリング対象から削除したいクラスの参照です。</p>
		 * 	<p></p>
		 */
		public static function removeFilter( target:Class ):void {
			var index:int = ArrayUtil.getItemIndex( _filters, target );
			
			if ( index == -1 ) { return; }
			
			_filters.splice( index, 1 );
		}
		
		/*======================================================================*//**
		 * <p>全てのフィルタリング設定を削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function removeAllFilters():void {
			_filters = [];
		}
		
		/*======================================================================*//**
		 * <p>対象がフィルタリング指定されているかどうかを判別します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>テストしたいクラスの参照です。</p>
		 * 	<p></p>
		 */
		public static function hasFilter( target:Class ):Boolean {
			return ( ArrayUtil.getItemIndex( _filters, target ) != -1 );
		}
		
		/*======================================================================*//**
		 * <p>Command クラス、及び Command クラスを継承したサブクラスをフィルタリング対象とします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function filteringCommand():void {
			addFilter( Command );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		public static function reload():void {
			BrowserInterface.reload();
			BrowserInterface.call( "window.focus" );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * LocalConnection オブジェクトがステータスを報告するときに送出されます。
		 */
		private static function _status( e:StatusEvent ):void {
			// 接続状況を取得する
			switch ( e.level ) {
				case "status"	: { _connecting = true; break; }
				case "warning"	:
				case "error"	:
				default			: { _connecting = false; }
			}
		}
	}
}









