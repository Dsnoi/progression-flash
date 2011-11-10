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
package jp.progression.core.parser {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.progression.core.parser.PRMLParser;
	import jp.progression.scenes.EasyCastingScene;
	
	/*======================================================================*//**
	 * <p>PRMLLoader クラスは、拡張された PRML 形式に準拠した XML データを解析する機能を提供します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EasyCastingParser extends PRMLParser {
		
		/*======================================================================*//**
		 * <p>EasyCasting 機能用に拡張された PRML 形式の MIME タイプを表すストリングを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CONTENT_TYPE:String = "text/prml-easycasting";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい EasyCastingParser インスタンスを作成します。</p>
		 * <p>Creates a new EasyCastingParser object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param data
		 * 	<p>パースしたい XML オブジェクトです。</p>
		 * 	<p></p>
		 */
		public function EasyCastingParser( data:XML ) {
			// スーパークラスを初期化する
			super( data );
			
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
		public override function parse( data:XML ):XML {
			// <scene> を設定する
			for each ( var scene:XML in data..scene ) {
				var cls:String = String( scene.attribute( "cls" ) );
				
				// cls が存在していなければデフォルト値を設定する
				if ( !cls ) {
					scene.@cls = "jp.progression.scenes.EasyCastingScene";
				}
				
				// パッケージパスが省略されていれば、フルパスに変換する
				else if ( cls == "EasyCastingScene" ) {
					scene.@cls = "jp.progression.scenes.EasyCastingScene";
				}
				
				// EasyCastingScene 以外の値が設定されていたらエラーを送出する
				else if ( cls != "jp.progression.scenes.EasyCastingScene" ) {
					throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9019", "EasyCastingScene" ) );
				}
			}
			
			// <cast> を設定する
			for each ( var cast:XML in data..cast ) {
				// cls が存在しなければエラーを送出する
				if ( !String( cast.attribute( "cls" ) ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_9020", "<cast>", "cls" ) ); }
			}
			
			return super.parse( data );
		}
	}
}









