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
package jp.progression.commands {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import jp.nium.net.ExURLLoader;
	import jp.progression.core.commands.Command;
	import jp.progression.core.errors.CommandExecuteError;
	
	/*======================================================================*//**
	 * <p>ロード操作が開始したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.OPEN
	 */
	[Event( name="open", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>データが正常にロードされたときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/*======================================================================*//**
	 * <p>ダウンロード処理を実行中にデータを受信したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/*======================================================================*//**
	 * <p>ネットワーク要求が HTTP を介して行われ、Flash Player が HTTP 状況コードを検出できる場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
	 */
	[Event( name="httpStatus", type="flash.events.HTTPStatusEvent" )]
	
	/*======================================================================*//**
	 * <p>URLLoader.load() を呼び出して HTTP 経由でデータへのアクセスを試みたときに Flash Player がその要求のステータスコードを検出して返すことが可能な環境にある場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
	 */
	[Event( name="securityError", type="flash.events.SecurityErrorEvent" )]
	
	/*======================================================================*//**
	 * <p>入出力エラーが発生してロード処理が失敗したときに送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	/*======================================================================*//**
	 * <p>LoadURL クラスは、指定されたファイルを読み込ませるコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // LoadURL インスタンスを作成します。
	 * var com:LoadURL = new LoadURL( new URLRequest( "external.xml" ) );
	 * 
	 * // エラー処理を設定します。
	 * com.error( function( e:Error ):void {
	 * 	// エラーを解決します。
	 * 	this.executeComplete();
	 * } );
	 * 
	 * // LoadURL コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class LoadURL extends Command {
		
		/*======================================================================*//**
		 * <p>読み込むファイルの絶対 URL または相対 URL を表す URLRequest インスタンスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get request():URLRequest { return _request; }
		public function set request( value:URLRequest ):void { _request = value; }
		private var _request:URLRequest;
		
		/*======================================================================*//**
		 * <p>ロード操作中に、既にロード済みのデータのバイト数を示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get bytesLoaded():int { return _loader.bytesLoaded; }
		
		/*======================================================================*//**
		 * <p>ダウンロードデータの合計バイト数を示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get bytesTotal():int { return _loader.bytesTotal; }
		
		/*======================================================================*//**
		 * <p>ロード操作によって受信したデータを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get data():Object { return _loader.data; }
		
		/*======================================================================*//**
		 * ExURLLoader インスタンスを取得します。 
		 */
		private var _loader:ExURLLoader = new ExURLLoader();
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい LoadURL インスタンスを作成します。</p>
		 * <p>Creates a new LoadURL object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param request
		 * 	<p>読み込むファイルの絶対 URL または相対 URL を表す URLRequest インスタンスです。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function LoadURL( request:URLRequest = null, initObject:Object = null ) {
			// 引数を設定する
			_request = request;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			_loader.addExclusivelyEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus, false, int.MAX_VALUE, true );
			_loader.addExclusivelyEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			_loader.load( _request );
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// イベントリスナーを解除する
			_loader.completelyRemoveEventListener( Event.OPEN, _open );
			_loader.completelyRemoveEventListener( Event.COMPLETE, _complete );
			_loader.completelyRemoveEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.completelyRemoveEventListener( SecurityErrorEvent.SECURITY_ERROR, _securityError );
			_loader.completelyRemoveEventListener( HTTPStatusEvent.HTTP_STATUS, _httpStatus );
			_loader.completelyRemoveEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// 読み込み中であれば中断する
			if (_loader.loading ) {
				_loader.close();
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>LoadURL インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an LoadURL subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい LoadURL インスタンスです。</p>
		 * 	<p>A new LoadURL object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new LoadURL( _request, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * URLLoader.load() メソッドの呼び出しによりダウンロード処理が開始されると送出されます。
		 */
		private function _open( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/*======================================================================*//**
		 * 受信したすべてのデータがデコードされて URLLoader インスタンスの data プロパティへの保存が完了したときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_loader.removeAllListeners( true );
			
			// データを登録する
			latestData = _loader.data;
			
			// イベントを送出する
			dispatchEvent( e );
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/*======================================================================*//**
		 * URLLoader.load() の呼び出しによってセキュリティサンドボックスの外部にあるサーバーからデータをロードしようとすると送出されます。
		 */
		private function _securityError( e:SecurityErrorEvent ):void {
			// イベントリスナーを解除する
			_loader.removeAllListeners( true );
			
			// イベントを送出する
			dispatchEvent( e );
			
			// エラー処理を実行する
			_catchError( this, new CommandExecuteError( "Error : " + e.text ) );
		}
		
		/*======================================================================*//**
		 * URLLoader.load() を呼び出して HTTP 経由でデータへのアクセスを試みたときに Flash Player がその要求のステータスコードを検出して返すことが可能な環境にある場合に送出されます。
		 */
		private function _httpStatus( e:HTTPStatusEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/*======================================================================*//**
		 * URLLoader.load() の呼び出し時に致命的なエラーが発生してダウンロードが終了した場合に送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			_loader.removeAllListeners( true );
			
			// イベントを送出する
			dispatchEvent( e );
			
			// エラー処理を実行する
			_catchError( this, new CommandExecuteError( "Error : " + e.text ) );
		}
	}
}









