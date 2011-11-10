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
package jp.progression.core.parser {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.progression.core.parser.PRMLParser;
	import jp.progression.scenes.EasyCastingScene;
	
	/**
	 * <span lang="ja">PRMLLoader クラスは、拡張された PRML 形式に準拠した XML データを解析する機能を提供します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EasyCastingParser extends PRMLParser {
		
		/**
		 * <span lang="ja">EasyCasting 機能用に拡張された PRML 形式の MIME タイプを表すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const CONTENT_TYPE:String = "text/prml-easycasting";
		
		
		
		
		
		/**
		 * <span lang="ja">新しい EasyCastingParser インスタンスを作成します。</span>
		 * <span lang="en">Creates a new EasyCastingParser object.</span>
		 * 
		 * @param data
		 * <span lang="ja">パースしたい XML オブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function EasyCastingParser( data:XML ) {
			// スーパークラスを初期化する
			super( data );
			
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
