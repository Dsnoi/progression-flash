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
package jp.progression.loader {
	import flash.display.Stage;
	import flash.net.URLRequest;
	import jp.progression.core.parser.EasyCastingParser;
	import jp.progression.loader.PRMLLoader;
	import jp.progression.scenes.EasyCastingScene;
	
	/**
	 * <span lang="ja">EasyCastingLoader クラスは、読み込んだ拡張された PRML 形式の XML ファイルから自動的に、Progression インスタンスを作成するローダークラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class EasyCastingLoader extends PRMLLoader {
		
		/**
		 * <span lang="ja">新しい EasyCastingLoader インスタンスを作成します。</span>
		 * <span lang="en">Creates a new EasyCastingLoader object.</span>
		 * 
		 * @param stage
		 * <span lang="ja">関連付けたい Stage インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param request
		 * <span lang="ja">ダウンロードする URL を指定する URLRequest オブジェクトです。このパラメータを省略すると、ロード操作は開始されません。指定すると、直ちにロード操作が開始されます。詳細については、load を参照してください。</span>
		 * <span lang="en"></span>
		 */
		public function EasyCastingLoader( stage:Stage, request:URLRequest = null ) {
			// スーパークラスを初期化する
			super( stage, request );
			
			// クラスをコンパイルに含める
			EasyCastingScene;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">データをパースします。</span>
		 * <span lang="en"></span>
		 * 
		 * @param data
		 * <span lang="ja">パースしたいデータです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">パース後のデータです。</span>
		 * <span lang="en"></span>
		 */
		public override function parse( data:* ):* {
			var parser:EasyCastingParser = new EasyCastingParser( new XML( data ) );
			
			return super.parse( parser.data );
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
			return "[object EasyCastingLoader]";
		}
	}
}
