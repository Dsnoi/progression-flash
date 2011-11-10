/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.external {
	import adobe.utils.MMExecute;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <span lang="ja">JSFLInterface クラスは、SWF ファイルを再生中の Flash IDE と、JSFL を使用して通信を行うクラスです。
	 * JSFLInterface クラスを直接インスタンス化することはできません。
	 * new JSFLInterface() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The JSFLInterface class communicates with the Flash IDE which are playing the SWF file, using JSFL.
	 * JSFLInterface class can not instanciate directly.
	 * When call the new JSFLInterface() constructor, the ArgumentError exception will be thrown.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public final class JSFLInterface {
		
		/**
		 * <span lang="ja">Flash IDE との JSFL 通信が可能かどうかを取得します。</span>
		 * <span lang="en">Returns if it is able to communicate with Flash IDE via JSFL.</span>
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = function():Boolean {
			var configURI:String = MMExecute( "( function() { return fl.configURI; } )()" );
			
			// EventIntegrator を作成する
			_integrator = new EventIntegrator();
			
			// MMExecute の引数が存在しなければ false を返す
			if ( !configURI ) { return false; }
			
			// 基本情報を取得する
			var version:String = MMExecute( '( function() { return fl.version; } )()' );
			_platform = version.split( " " )[0];
			_language = configURI.split( "/" ).slice( -3, -2 ).join( "/" );
			_majorVersion = parseInt( String( version.split( " " )[1] ).split( "," )[0] );
			_minorVersion = parseInt( String( version.split( " " )[1] ).split( "," )[1] );
			_buildVersion = parseInt( String( version.split( " " )[1] ).split( "," )[2] );
			_revisionVersion = parseInt( String( version.split( " " )[1] ).split( "," )[3] );
			_configURI = configURI;
			
			return true;
		}.apply();
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get platform():String { return _platform; }
		private static var _platform:String;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get language():String { return _platform; }
		private static var _language:String;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get majorVersion():int { return _majorVersion; }
		private static var _majorVersion:int;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get minorVersion():int { return _minorVersion; }
		private static var _minorVersion:int;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get revisionVersion():int { return _revisionVersion; }
		private static var _revisionVersion:int;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function get buildVersion():int { return _buildVersion; }
		private static var _buildVersion:int;
		
		/**
		 * <span lang="ja">ローカルユーザーの "Configuration" ディレクトリを file:/// URI として表す完全パスを指定するストリングを取得します。</span>
		 * <span lang="en">a string that specifies the full path for the local user's Configuration directory as a file:/// URI.</span>
		 */
		public static function get configURI():String { return _configURI; }
		private static var _configURI:String;
		
		/**
		 * EventIntegrator インスタンスを取得します。
		 */
		private static var _integrator:EventIntegrator;
		
		
		
		
		
		/**
		 * @private
		 */
		public function JSFLInterface() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "JSFLInterface" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">Flash JavaScript アプリケーションプログラミングインターフェイスを経由して、関数を実行します。</span>
		 * <span lang="en">Execute function via Flash JavaScript Application Programming Interface.</span>
		 * 
		 * @param funcName
		 * <span lang="ja">実行したい関数名です。</span>
		 * <span lang="en">The name of the function to execute.</span>
		 * @param args
		 * <span lang="ja">funcName に渡すパラメータです。</span>
		 * <span lang="en">The parameter to pass to funcName.</span>
		 * @return
		 * <span lang="ja">funcName を指定した場合に、関数の結果をストリングで返します。</span>
		 * <span lang="en">Return the result of the function as string if funcName specified.</span>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			// 無効化されていれば終了する
			if ( !_enabled ) { return ""; }
			
			// 引数を String に変換する
			var arg:String = ArrayUtil.toString( args );
			arg = StringUtil.collectBreak( arg );
			arg = arg.replace( new RegExp( "\n", "g" ), "\\n" );
			
			// 実行する
			return StringUtil.toProperType( MMExecute( "( function() { return eval( decodeURI( \"( " + encodeURI( funcName ) + " ).apply( null, " + encodeURI( arg ) + " );\" ) ); } )()" ) );
		}
		
		/**
		 * <span lang="ja">JavaScript ファイルを実行します。関数をパラメータの 1 つとして指定している場合は、その関数が実行されます。また関数内にないスクリプトのコードも実行されます。スクリプト内の他のコードは、関数の実行前に実行されます。</span>
		 * <span lang="en">executes a JavaScript file. If a function is specified as one of the arguments, it runs the function and also any code in the script that is not within the function. The rest of the code in the script runs before the function is run.</span>
		 * 
		 * @param fileURL
		 * <span lang="ja">実行するスクリプトファイルの名前を指定した file:/// URI で表されるストリングです。</span>
		 * <span lang="en">string, expressed as a file:/// URI, that specifies the name of the script file to execute.</span>
		 * @param funcName
		 * <span lang="ja">fileURI で指定した JSFL ファイルで実行する関数を識別するストリングです。</span>
		 * <span lang="en">A string that identifies a function to execute in the JSFL file that is specified in fileURI. This parameter is optional.</span>
		 * @param args
		 * <span lang="ja">funcName に渡す省略可能なパラメータです。</span>
		 * <span lang="en">optional parameter that specifies one or more arguments to be passed to funcname.</span>
		 * @return
		 * <span lang="ja">funcName を指定すると、関数の結果をストリングで返します。指定しない場合は、何も返されません。</span>
		 * <span lang="en">The function's result as a string, if funcName is specified; otherwise, nothing.</span>
		 */
		public static function runScript( fileURL:String, funcName:String = null, ... args:Array ):* {
			return call.apply( null, [ "fl.runScript", fileURL, funcName || "" ].concat( args ) );
		}
		

		/**
		 * <span lang="ja">テキストストリングを [出力] パネルに送ります。</span>
		 * <span lang="en">Sends a text string to the Output panel.</span>
		 * 
		 * @param messages
		 * <span lang="ja">[出力] パネルに表示するストリングです。</span>
		 * <span lang="en">string that appears in the Output panel.</span>
		 */
		public static function fltrace( ... messages:Array ):void {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.fltrace() :", message );
			
			call( "fl.trace", message );
		}
		
		/**
		 * <span lang="ja">モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンを表示します。</span>
		 * <span lang="en">displays a string in a modal Alert dialog box, along with an OK button.</span>
		 * 
		 * @param messages
		 * <span lang="ja">警告ダイアログボックスに表示するメッセージを指定するストリングです。</span>
		 * <span lang="en">A string that specifies the message you want to display in the Alert dialog box.</span>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.alert() :", message );
			
			call( "alert", message );
		}
		
		/**
		 * <span lang="ja">モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンと [キャンセル] ボタンを表示します。</span>
		 * <span lang="en">displays a string in a modal Alert dialog box, along with OK and Cancel buttons.</span>
		 * 
		 * @param messages
		 * <span lang="ja">警告ダイアログボックスに表示するメッセージを指定するストリングです。</span>
		 * <span lang="en">A string that specifies the message you want to display in the Alert dialog box.</span>
		 * @return
		 * <span lang="ja">ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</span>
		 * <span lang="en">true if the user clicks OK; false if the user clicks Cancel.</span>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.confirm() :", message );
			
			return !!StringUtil.toProperType( call( "confirm", message ) );
		}
		
		/**
		 * <span lang="ja">モーダル警告ダイアログボックスに、プロンプトとオプションのテキストおよび [OK] ボタンと [キャンセル] ボタンを表示します。</span>
		 * <span lang="en">displays a prompt and optional text in a modal Alert dialog box, along with OK and Cancel buttons.</span>
		 * 
		 * @param title
		 * <span lang="ja">プロンプトダイアログボックスに表示するストリングです。</span>
		 * <span lang="en">A string to display in the Prompt dialog box.</span>
		 * @param messages
		 * <span lang="ja">プロンプトダイアログボックスに表示するストリングです。</span>
		 * <span lang="en">An optional string to display as a default value for the text field.</span>
		 * @return
		 * <span lang="ja">ユーザーが [OK] をクリックした場合はユーザーが入力したストリング、[キャンセル] をクリックした場合は null を返します。</span>
		 * <span lang="en">The string the user typed if the user clicks OK; null if the user clicks Cancel.</span>
		 */
		public static function prompt( title:String, ... messages:Array ):String {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.prompt() :", title, message );
			
			return call( "prompt", title, message );
		}
	}
}
