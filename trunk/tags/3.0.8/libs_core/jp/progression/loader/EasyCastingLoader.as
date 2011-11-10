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
package jp.progression.loader {
	import flash.display.Stage;
	import flash.net.URLRequest;
	import jp.progression.core.parser.EasyCastingParser;
	import jp.progression.loader.PRMLLoader;
	import jp.progression.scenes.EasyCastingScene;
	
	/*======================================================================*//**
	 * <p>EasyCastingLoader クラスは、読み込んだ拡張された PRML 形式の XML ファイルから自動的に、Progression インスタンスを作成するローダークラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EasyCastingLoader extends PRMLLoader {
		
		/*======================================================================*//**
		 * <p>新しい EasyCastingLoader インスタンスを作成します。</p>
		 * <p>Creates a new EasyCastingLoader object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>関連付けたい Stage インスタンスです。</p>
		 * 	<p></p>
		 * @param request
		 * 	<p>ダウンロードする URL を指定する URLRequest オブジェクトです。このパラメータを省略すると、ロード操作は開始されません。指定すると、直ちにロード操作が開始されます。詳細については、load を参照してください。</p>
		 * 	<p></p>
		 */
		public function EasyCastingLoader( stage:Stage, request:URLRequest = null ) {
			// スーパークラスを初期化する
			super( stage, request );
			
			// クラスをコンパイルに含める
			EasyCastingScene;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>データをパースします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param data
		 * 	<p>パースしたいデータです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>パース後のデータです。</p>
		 * 	<p></p>
		 */
		public override function parse( data:* ):* {
			var parser:EasyCastingParser = new EasyCastingParser( new XML( data ) );
			
			return super.parse( parser.data );
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
			return "[object EasyCastingLoader]";
		}
	}
}









