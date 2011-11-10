/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.external {
	import adobe.utils.MMExecute;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.StringUtil;
	
	/*======================================================================*//**
	 * <p>JSFLInterface クラスは、SWF ファイルを再生中の Flash IDE と、JSFL を使用して通信を行うクラスです。
	 * JSFLInterface クラスを直接インスタンス化することはできません。
	 * new JSFLInterface() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class JSFLInterface {
		
		/*======================================================================*//**
		 * <p>Flash IDE との JSFL 通信が可能かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get enabled():Boolean { return _enabled; }
		private static var _enabled:Boolean = function():Boolean {
			var result:String = MMExecute( "( function() { return fl.configURI; } )()" );
			
			// EventIntegrator を作成する
			_integrator = new EventIntegrator();
			
			// MMExecute の引数が存在しなければ false を返す
			if ( !result ) { return false; }
			
			// fl.configURI を設定する
			_configURI = result;
			
			return true;
		}.apply();
		
		/*======================================================================*//**
		 * <p>ローカルユーザーの "Configuration" ディレクトリを file:/// URI として表す完全パスを指定するストリングを取得します。</p>
		 * <p>a string that specifies the full path for the local user's Configuration directory as a file:/// URI.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get configURI():String { return _configURI; }
		private static var _configURI:String;
		
		/*======================================================================*//**
		 * EventIntegrator インスタンスを取得します。
		 */
		private static var _integrator:EventIntegrator;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function JSFLInterface() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "JSFLInterface" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>Flash JavaScript アプリケーションプログラミングインターフェイスを経由して、関数を実行します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param funcName
		 * 	<p>実行したい関数名です。</p>
		 * 	<p></p>
		 * @param args
		 * 	<p>funcName に渡すパラメータです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>funcName を指定した場合に、関数の結果をストリングで返します。</p>
		 * 	<p></p>
		 */
		public static function call( funcName:String, ... args:Array ):* {
			// 無効化されていれば終了する
			if ( !_enabled ) { return ""; }
			
			// 引数を String に変換する
			var arg:String = ArrayUtil.toString( args );
			arg = StringUtil.collectBreak( arg );
			arg = arg.replace( new RegExp( "\n", "g" ), "\\n" );
			
			// 実行する
			return StringUtil.toProperType( MMExecute( funcName + ".apply( null, " + arg + " );" ) );
		}
		
		/*======================================================================*//**
		 * <p>JavaScript ファイルを実行します。関数をパラメータの 1 つとして指定している場合は、その関数が実行されます。また関数内にないスクリプトのコードも実行されます。スクリプト内の他のコードは、関数の実行前に実行されます。</p>
		 * <p>executes a JavaScript file. If a function is specified as one of the arguments, it runs the function and also any code in the script that is not within the function. The rest of the code in the script runs before the function is run.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param fileURL
		 * 	<p>実行するスクリプトファイルの名前を指定した file:/// URI で表されるストリングです。</p>
		 * 	<p>string, expressed as a file:/// URI, that specifies the name of the script file to execute.</p>
		 * @param funcName
		 * 	<p>fileURI で指定した JSFL ファイルで実行する関数を識別するストリングです。</p>
		 * 	<p>A string that identifies a function to execute in the JSFL file that is specified in fileURI. This parameter is optional.</p>
		 * @param args
		 * 	<p>funcName に渡す省略可能なパラメータです。</p>
		 * 	<p>optional parameter that specifies one or more arguments to be passed to funcname.</p>
		 * @return
		 * 	<p>funcName を指定すると、関数の結果をストリングで返します。指定しない場合は、何も返されません。</p>
		 * 	<p>The function's result as a string, if funcName is specified; otherwise, nothing.</p>
		 */
		public static function runScript( fileURL:String, funcName:String = null, ... args:Array ):* {
			funcName ||= "";
			
			// 引数を String に変換する
			var arg:String = ArrayUtil.toString( args );
			arg = arg.slice( 1, -1 );
			arg = StringUtil.collectBreak( arg );
			arg = arg.replace( new RegExp( "\n", "g" ), "\\n" );
			
			// 実行する
			return StringUtil.toProperType( MMExecute( "fl.runScript.apply( null, [ \"" + fileURL + "\", \"" + funcName + "\", " + arg + " ] );" ) );
		}
		
		/*======================================================================*//**
		 * <p>テキストストリングを [出力] パネルに送ります。</p>
		 * <p>Sends a text string to the Output panel.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param messages
		 * 	<p>[出力] パネルに表示するストリングです。</p>
		 * 	<p>string that appears in the Output panel.</p>
		 */
		public static function fltrace( ... messages:Array ):void {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.fltrace() :", message );
			
			call( "fl.trace", message );
		}
		
		/*======================================================================*//**
		 * <p>モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンを表示します。</p>
		 * <p>displays a string in a modal Alert dialog box, along with an OK button.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param messages
		 * 	<p>警告ダイアログボックスに表示するメッセージを指定するストリングです。</p>
		 * 	<p>A string that specifies the message you want to display in the Alert dialog box.</p>
		 */
		public static function alert( ... messages:Array ):void {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.alert() :", message );
			
			call( "alert", message );
		}
		
		/*======================================================================*//**
		 * <p>モーダル警告ダイアログボックスに、ストリングおよび [OK] ボタンと [キャンセル] ボタンを表示します。</p>
		 * <p>displays a string in a modal Alert dialog box, along with OK and Cancel buttons.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param messages
		 * 	<p>警告ダイアログボックスに表示するメッセージを指定するストリングです。</p>
		 * 	<p>A string that specifies the message you want to display in the Alert dialog box.</p>
		 * @return
		 * 	<p>ユーザーが [OK] をクリックしたときは true、[キャンセル] をクリックしたときは false を返します。</p>
		 * 	<p>true if the user clicks OK; false if the user clicks Cancel.</p>
		 */
		public static function confirm( ... messages:Array ):Boolean {
			var message:String = messages.join( " " );
			message = StringUtil.collectBreak( message );
			message = message.replace( new RegExp( "\n", "g" ), "\\n" );
			
			trace( "JSFLInterface.confirm() :", message );
			
			return !!StringUtil.toProperType( call( "confirm", message ) );
		}
		
		/*======================================================================*//**
		 * <p>モーダル警告ダイアログボックスに、プロンプトとオプションのテキストおよび [OK] ボタンと [キャンセル] ボタンを表示します。</p>
		 * <p>displays a prompt and optional text in a modal Alert dialog box, along with OK and Cancel buttons.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param title
		 * 	<p>プロンプトダイアログボックスに表示するストリングです。</p>
		 * 	<p>A string to display in the Prompt dialog box.</p>
		 * @param messages
		 * 	<p>プロンプトダイアログボックスに表示するストリングです。</p>
		 * 	<p>An optional string to display as a default value for the text field.</p>
		 * @return
		 * 	<p>ユーザーが [OK] をクリックした場合はユーザーが入力したストリング、[キャンセル] をクリックした場合は null を返します。</p>
		 * 	<p>The string the user typed if the user clicks OK; null if the user clicks Cancel.</p>
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









