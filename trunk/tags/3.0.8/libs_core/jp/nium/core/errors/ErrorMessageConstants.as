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
package jp.nium.core.errors {
	import jp.nium.lang.Locale;
	
	/*======================================================================*//**
	 * <p>ErrorMessageConstants クラスは、エラーメッセージを管理するモデルクラスです。
	 * ErrorMessageConstants クラスを直接インスタンス化することはできません。
	 * new ErrorMessageConstants() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ErrorMessageConstants {
		
		/*======================================================================*//**
		 * 初期化されたかどうかを取得します。
		 */
		private static var _initialized:Boolean = function():Boolean {
			
			// 該当する項目が存在しない場合のエラーメッセージ
			Locale.setString( "ERROR_0000", "ja", "不明なエラーです。" );
			Locale.setString( "ERROR_0000", "en", "The error is unknown." );
			
			// 1000 ～ 7999 は Flash 用のエラーメッセージ予約番号
			Locale.setString( "ERROR_1001", "ja", "メソッド %0 は実装されていません。" );
			Locale.setString( "ERROR_1001", "en", "The method %0 is not implemented." );
			
			Locale.setString( "ERROR_1074", "ja", "%0 の読み取り専用プロパティ %1 へは書き込みできません。" );
			Locale.setString( "ERROR_1074", "en", "Illegal write to read-only property %1 on %0." );
			
			Locale.setString( "ERROR_1507", "ja", "引数 %0 を null にすることはできません。" );
			Locale.setString( "ERROR_1507", "en", "Argument %0 cannot be null." );
			
			Locale.setString( "ERROR_2006", "ja", "指定したインデックスが境界外です。" );
			Locale.setString( "ERROR_2006", "en", "The supplied index is out of bounds." );
			
			Locale.setString( "ERROR_2008", "ja", "パラメータ %0 は承認された値の 1 つでなければなりません。" );
			Locale.setString( "ERROR_2008", "en", "Parameter %0 must be one of the accepted values." );
			
			Locale.setString( "ERROR_2012", "ja", "%0 クラスを直接インスタンス化することはできません。" );
			Locale.setString( "ERROR_2012", "en", "%0 class cannot be instantiated." );
			
			Locale.setString( "ERROR_2025", "ja", "指定した DisplayObject は呼び出し元の子でなければなりません。" );
			Locale.setString( "ERROR_2025", "en", "The supplied DisplayObject must be a child of the caller." );
			
			// 8000 ～ 8999 は jp.nium Classes 用のエラーメッセージ予約番号
			Locale.setString( "ERROR_8000", "ja", "パラメータ %0 は実装されていません。" );
			Locale.setString( "ERROR_8000", "en", "The property %0 is not implemented." );
			
			Locale.setString( "ERROR_8001", "ja", "%0 クラスはドキュメントクラス以外には使用できません。" );
			Locale.setString( "ERROR_8001", "en", "%0 class can only use to the Document class." );
			
			Locale.setString( "ERROR_8002", "ja", "ExDisplayObject クラスと関連付けるには DisplayObject クラスを継承している必要があります。" );
			Locale.setString( "ERROR_8002", "en", "To relate to the ExDisplayObject class, it needs to inherit the DisplayObject class." );
			
			Locale.setString( "ERROR_8003", "ja", "指定されたインデックス位置はすでに使用されています。" );
			Locale.setString( "ERROR_8003", "en", "Specified index position is already used." );
			
			Locale.setString( "ERROR_8004", "ja", "ExImageLoader クラスは JPG, GIF, PNG 以外の形式のファイルの読み込みには対応していません。" );
			Locale.setString( "ERROR_8004", "en", "ExImageLoader class is not correspond to read other than the JPG, GIF, PNG file format." );
			
			Locale.setString( "ERROR_8005", "ja", "不正なフォーマットです。" );
			Locale.setString( "ERROR_8005", "en", "Invalid format." );
			
			Locale.setString( "ERROR_8006", "ja", "改行コード以外を指定することはできません。" );
			Locale.setString( "ERROR_8006", "en", "Can not specify other than Line Feed code." );
			
			Locale.setString( "ERROR_8007", "ja", "別の ChildIndexer オブジェクトに管理されている DisplayObjectContainer オブジェクトを指定することはできません。" );
			Locale.setString( "ERROR_8007", "en", "Can not specify the DisplayObjectContainer managed by other ChildIndexer object." );
			
			// 9000 ～ 9499 は Progression 用のエラーメッセージ予約番号
			Locale.setString( "ERROR_9000", "ja", "コンテンツを再生するにはバージョン %0 以降の Flash Player が必要です。" );
			Locale.setString( "ERROR_9000", "en", "To playback the contents, the Flash Player version should be later then %0." );
			
			Locale.setString( "ERROR_9001", "ja", "すでに登録済みの Progression 識別子を設定することはできません。" );
			Locale.setString( "ERROR_9001", "en", "Can not specify the Progression Identifier already registered." );
			
			Locale.setString( "ERROR_9002", "ja", "ルートシーンとして使用するクラスは、SceneObject クラスを継承している必要があります。" );
			Locale.setString( "ERROR_9002", "en", "The class to use as Root scene should inherit the SceneObject class." );
			
			Locale.setString( "ERROR_9003", "ja", "ルートシーンのパラメータ name は変更できません。" );
			Locale.setString( "ERROR_9003", "en", "The name parameter of Root scene can not change." );
			
			Locale.setString( "ERROR_9004", "ja", "同一階層上に同じ名前のシーン名を重複して設定することはできません。" );
			Locale.setString( "ERROR_9004", "en", "Can not set the same name for scene name on same hierarchy." );
			
			Locale.setString( "ERROR_9005", "ja", "%0 インスタンスの子シーンには、%0 インスタンス以外設定することはできません。" );
			Locale.setString( "ERROR_9005", "en", "To the child of %0 instance, set only %0 instance." );
			
			Locale.setString( "ERROR_9006", "ja", "対象は DisplayObject または CastObject を継承している必要があります。" );
			Locale.setString( "ERROR_9006", "en", "The object should inherit DisplayObject or CastObject." );
			
			Locale.setString( "ERROR_9007", "ja", "シーンパスの書式が正しくありません。" );
			Locale.setString( "ERROR_9007", "en", "The format of the scene path is not correct." );
			
			Locale.setString( "ERROR_9008", "ja", "パラメータ centering が true の状態でパラメータ %0 の値を変更することはできません。" );
			Locale.setString( "ERROR_9008", "en", "Can not change the %0 parameter value when the centering parameter is true." );
			
			Locale.setString( "ERROR_9009", "ja", "インスタンスを stage のディスプレイリストから削除することはできません。" );
			Locale.setString( "ERROR_9009", "en", "Can not remove the instance from Display list of stage." );
			
			Locale.setString( "ERROR_9010", "ja", "初めて Progression インスタンス作成する際には stage を省略することはできません。" );
			Locale.setString( "ERROR_9010", "en", "Can not omit the stage when creating the Progression instance first time." );
			
			Locale.setString( "ERROR_9011", "ja", "読み込み操作開始後にパラメータ %0 を設定することは出来ません。" );
			Locale.setString( "ERROR_9011", "en", "Can not set the %0 parameter after starting the read operation." );
			
			Locale.setString( "ERROR_9012", "ja", "パラメータ accessKey には A ～ Z の値を指定する必要があります。" );
			Locale.setString( "ERROR_9012", "en", "Set the value within A-Z to the accessKey parameter." );
			
			Locale.setString( "ERROR_9013", "ja", "CastPreloader クラスをドキュメントクラスに使用した SWF ファイルを、他の SWF ファイルに読み込むことはできません。" );
			Locale.setString( "ERROR_9013", "en", "Other SWF file can not read the SWF file used the CastPreloader class as Document class." );
			
			Locale.setString( "ERROR_9014", "ja", "パラメータ root に設定する SceneObject はツリー構造部分の一番上である必要があります。" );
			Locale.setString( "ERROR_9014", "en", "The SceneObject set to root parameter should be at the top of the tree structure." );
			
			Locale.setString( "ERROR_9018", "ja", "指定された sceneId に関連付けられている Progression インスタンスが存在しません。" );
			Locale.setString( "ERROR_9018", "en", "Progress instance releted to the specified sceneId does not exists." );
			
			Locale.setString( "ERROR_9019", "ja", "<scene> 要素の属性 cls には、%0 クラス以外は設定することができません。" );
			Locale.setString( "ERROR_9019", "en", "Only set the %0 class to the cls attribute of <scene> element." );
			
			Locale.setString( "ERROR_9020", "ja", "%0 要素はパラメータ %1 の値を省略することはできません。" );
			Locale.setString( "ERROR_9020", "en", "%0 element can not omit the value of %1 parameter." );
			
			Locale.setString( "ERROR_9021", "ja", "%0 コマンドの処理がタイムアウトしました。" );
			Locale.setString( "ERROR_9021", "en", "The process of the %0 command timeouts." );
			
			Locale.setString( "ERROR_9022", "ja", "パラメータ contextMenu を使用することは出来ません。代わりにパラメータ uiContextMenu を使用してください。" );
			Locale.setString( "ERROR_9022", "en", "contextMenu parameter can not use. Please use uiContextMenu parameter instead." );
			
			Locale.setString( "ERROR_9023", "ja", "対象は %0 インターフェイスを実装している必要があります。" );
			Locale.setString( "ERROR_9023", "en", "The object should implent the %0 interface." );
			
			Locale.setString( "ERROR_9024", "ja", "2 つ以上の Loader コンポーネントを同時使用することはできません。" );
			Locale.setString( "ERROR_9024", "en", "Can not use the Loader component more than 2 at same time." );
			
			Locale.setString( "ERROR_9025", "ja", "XML ファイルが PRML 形式に準拠していません。" );
			Locale.setString( "ERROR_9025", "en", "XML file does not conform PRML form." );
			
			Locale.setString( "ERROR_9026", "ja", "XML ファイルに PRML 形式に対応した MIME タイプが設定されていません。" );
			Locale.setString( "ERROR_9026", "en", "The MIME type corresponding to the PRML form is not set to the XML file." );
			
			Locale.setString( "ERROR_9027", "ja", "パラメータ parallelMode の値は、コマンド実行中に変更できません。" );
			Locale.setString( "ERROR_9027", "en", "Can not change the parallelMode parameter value while executing." );
			
			Locale.setString( "ERROR_9028", "ja", "対応していない型のオブジェクトが指定されました。" );
			Locale.setString( "ERROR_9028", "en", "Specified the object does not correspond." );
			
			Locale.setString( "ERROR_9030", "ja", "AIR プロジェクトでパラメータ uiContextMenu を使用することはできません。" );
			Locale.setString( "ERROR_9030", "en", "uiContextMenu parameter can not use at AIR project." );
			
			Locale.setString( "ERROR_9031", "ja", "メソッド %0 は将来的にサポートされない機能です。代わりにメソッド %1 を使用してください。" );
			Locale.setString( "ERROR_9031", "en", "%0 method will not be supported in future. Please use %1 method instead." );
			
			Locale.setString( "ERROR_9032", "ja", "パラメータ %0 は将来的にサポートされない機能です。代わりにパラメータ %1 を使用してください。" );
			Locale.setString( "ERROR_9032", "en", "%0 parameter will not be supported in future. Please use %1 parameter instead." );
			
			Locale.setString( "ERROR_9033", "ja", "ルートシーンオブジェクトを別のシーンの子として登録することはできません。" );
			Locale.setString( "ERROR_9033", "en", "Can not register the Root scene object to the other scene's child." );
			
			Locale.setString( "ERROR_9034", "ja", "scene_ は予約された書式なので使用することができません。" );
			Locale.setString( "ERROR_9034", "en", "scene_ format is reserved so can not use." );
			
			return true;
		}.apply();
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function ErrorMessageConstants() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ErrorMessageConstants" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された識別子に対応したメッセージを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>メッセージの識別子です。</p>
		 * 	<p></p>
		 * @param replaces
		 * 	<p>特定のコードを置換する文字列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>エラーメッセージです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
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
			
			return "Error #" + id.replace( "ERROR_", "" ) + ": " + message;
		}
	}
}









