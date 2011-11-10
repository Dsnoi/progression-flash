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
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.version.Version;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/*======================================================================*//**
	 * <p>PRMLLoader クラスは、PRML 形式に準拠した XML データを解析する機能を提供します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class PRMLParser {
		
		/*======================================================================*//**
		 * <p>基本的な PRML 形式の MIME タイプを表すストリングを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const CONTENT_TYPE:String = "text/prml";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>PRML データのバージョン情報を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get version():Version { return _version; }
		private var _version:Version;
		
		/*======================================================================*//**
		 * <p>PRML データの MIME タイプを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get contentType():String { return _contentType; }
		private var _contentType:String;
		
		/*======================================================================*//**
		 * <p>シーン構造を表す XMLList インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get scenes():XMLList { return _scenes.copy(); }
		private var _scenes:XMLList;
		
		/*======================================================================*//**
		 * <p>ロード操作によって受信したデータを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get data():XML { return _data.copy(); }
		private var _data:XML;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい PRMLParser インスタンスを作成します。</p>
		 * <p>Creates a new PRMLParser object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param data
		 * 	<p>パースしたい XML オブジェクトです。</p>
		 * 	<p></p>
		 */
		public function PRMLParser( data:XML ) {
			// 引数を設定する
			_data = parse( data );
			
			// クラスをコンパイルに含める
			SceneObject;
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
		public function parse( data:XML ):XML {
			// <prml> タグを確認する
			if ( data.name() != "prml" ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9025" ) ); }
			
			// バージョンを設定する
			_version = new Version( String( data.attribute( "version" ) ) );
			data.@version = _version.toString();
			
			// MIME タイプを設定する
			_contentType = String( data.attribute( "type" ) );
			if ( !_contentType ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9026" ) ); }
			
			// <scene> を設定する
			for each ( var scene:XML in data..scene ) {
				// name が存在しなければエラーを送出する
				var name:String = String( scene.attribute( "name" ) );
				if ( !name ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9020", "<scene>", "name" ) ); }
				if ( !SceneId.validate( "/" + name ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
				
				var cls:String = String( scene.attribute( "cls" ) );
				
				// cls が存在していなければデフォルト値を設定する
				if ( !cls ) {
					scene.@cls = "jp.progression.scenes.SceneObject";
				}
				
				// パッケージパスが省略されていれば、フルパスに変換する
				else if ( cls == "SceneObject" ) {
					scene.@cls = "jp.progression.scenes.SceneObject";
				}
			}
			
			_scenes = data.child( "scene" );
			
			return data;
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトの PRML ストリング表現を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param scenes
		 * 	<p>変換したい XMLList インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>オブジェクトの PRML 表現です。</p>
		 * 	<p></p>
		 */
		public function toPRMLString( scenes:XMLList = null ):XML {
			scenes ||= this.scenes;
			
			var xml:XML = <prml version={ _version.toString() } type={ _contentType } />;
			xml.prependChild( scenes );
			return xml;
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
		public function toString():String {
			return _data;
		}
	}
}









