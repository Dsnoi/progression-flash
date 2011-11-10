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
package jp.progression.core.debug {
	import jp.nium.lang.Locale;
	
	/**
	 * <span lang="ja">VerboseMessageConstants クラスは、デバッグ用メッセージを管理するモデルクラスです。
	 * VerboseMessageConstants クラスを直接インスタンス化することはできません。
	 * new VerboseMessageConstants() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class VerboseMessageConstants {
		
		/**
		 * static initializer
		 */
		Locale.setString( "VERBOSE_0000", "ja", "%0 は、すでに ICastObject インターフェイスを実装しているため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0000", "en", "" );
		
		Locale.setString( "VERBOSE_0001", "ja", "%0 は MovieClip クラスを継承していないため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0001", "en", "" );
		
		Locale.setString( "VERBOSE_0002", "ja", "%0 は dynamic クラスではないため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0002", "en", "" );
		
		Locale.setString( "VERBOSE_0003", "ja", "%0 の executor プロパティの値が不正なため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0003", "en", "" );
		
		Locale.setString( "VERBOSE_0004", "ja", "%0 には複数のボタンが設定されているため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0004", "en", "" );
		
		Locale.setString( "VERBOSE_0005", "ja", "%0 は、ボタンコンポーネントがネスト状態で設定されているため、%1 コンポーネントは無効化されます。" );
		Locale.setString( "VERBOSE_0005", "en", "" );
		
		Locale.setString( "VERBOSE_0006", "ja", "%0 コンポーネントを無効化することはできません。" );
		Locale.setString( "VERBOSE_0006", "en", "" );
		
		Locale.setString( "VERBOSE_0007", "ja", "移動先のシーンが存在しません, 目的地 = %0" );
		Locale.setString( "VERBOSE_0007", "en", "" );
		
		Locale.setString( "VERBOSE_0008", "ja", "シーン移動を開始, 目的地 =  %0" );
		Locale.setString( "VERBOSE_0008", "en", "" );
		
		Locale.setString( "VERBOSE_0009", "ja", "%0 シーンに移動。" );
		Locale.setString( "VERBOSE_0009", "en", "" );
		
		Locale.setString( "VERBOSE_0010", "ja", "%0  シーンの %1 イベントを実行。" );
		Locale.setString( "VERBOSE_0010", "en", "" );
		
		Locale.setString( "VERBOSE_0011", "ja", "シーン移動を完了。" );
		Locale.setString( "VERBOSE_0011", "en", "" );
		
		Locale.setString( "VERBOSE_0012", "ja", "シーン移動を中断。" );
		Locale.setString( "VERBOSE_0012", "en", "" );
		
		Locale.setString( "VERBOSE_0013", "ja", "シーン移動中にエラーが発生したため、その場で強制停止します。" );
		Locale.setString( "VERBOSE_0013", "en", "" );
		
		Locale.setString( "VERBOSE_0014", "ja", "設置されている HTML ファイルに swfobject.js 及び swfaddress.js が存在しないか、対応していないバージョンを使用している可能性があります。" );
		Locale.setString( "VERBOSE_0014", "en", "" );
		
		Locale.setString( "VERBOSE_0014", "ja", "読み込まれている swfaddress.js が対応していないバージョンである可能性があります。" );
		Locale.setString( "VERBOSE_0014", "en", "" );
		
		Locale.setString( "VERBOSE_0015", "ja", "読み込んだ PRML から作成した構造 url = %0\n%1\n" );
		Locale.setString( "VERBOSE_0015", "en", "" );
		
		Locale.setString( "VERBOSE_0016", "ja", "<%0 : %1> コマンドを実行。" );
		Locale.setString( "VERBOSE_0016", "en", "" );
		
		Locale.setString( "VERBOSE_0017", "ja", "<%0 : %1> コマンドを中断。" );
		Locale.setString( "VERBOSE_0017", "en", "" );
		
		Locale.setString( "VERBOSE_0018", "ja", "<%0 : %1> コマンドで %2 エラーが発生。" );
		Locale.setString( "VERBOSE_0018", "en", "" );
		
		
		
		
		
		/**
		 * @private
		 */
		public function VerboseMessageConstants() {
			throw new ArgumentError( VerboseMessageConstants.getMessage( "VERBOSE_0012", "VerboseMessageConstants" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された識別子に対応したメッセージを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param id
		 * <span lang="ja">エラーメッセージの識別子です。</span>
		 * <span lang="en"></span>
		 * @param replaces
		 * <span lang="ja">特定のコードを置換する文字列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">エラーメッセージです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getMessage( id:String, ... replaces:Array ):String {
			// メッセージを取得する
			var message:String = Locale.getString( id ) || Locale.getString( "0000" );
			
			// 特定のコードを置換する
			var l:int = replaces.length;
			for ( var i:int = 0; i < l; i++ ) {
				message = message.replace( new RegExp( "%" + i, "g" ), replaces[i] );
			}
			
			return message;
		}
	}
}
