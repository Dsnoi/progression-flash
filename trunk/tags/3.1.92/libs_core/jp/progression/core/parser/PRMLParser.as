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
package jp.progression.core.parser {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.version.Version;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <span lang="ja">PRMLLoader クラスは、PRML 形式に準拠した XML データを解析する機能を提供します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class PRMLParser {
		
		/**
		 * <span lang="ja">基本的な PRML 形式の MIME タイプを表すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const CONTENT_TYPE:String = "text/prml";
		
		
		
		
		
		/**
		 * <span lang="ja">PRML データのバージョン情報を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get version():Version { return _version; }
		private var _version:Version;
		
		/**
		 * <span lang="ja">PRML データの MIME タイプを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get contentType():String { return _contentType; }
		private var _contentType:String;
		
		/**
		 * <span lang="ja">シーン構造を表す XMLList インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get scenes():XMLList { return _scenes.copy(); }
		private var _scenes:XMLList;
		
		/**
		 * <span lang="ja">ロード操作によって受信したデータを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get data():XML { return _data.copy(); }
		private var _data:XML;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい PRMLParser インスタンスを作成します。</span>
		 * <span lang="en">Creates a new PRMLParser object.</span>
		 * 
		 * @param data
		 * <span lang="ja">パースしたい XML オブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function PRMLParser( data:XML ) {
			// 引数を設定する
			_data = parse( data );
			
			// クラスをコンパイルに含める
			SceneObject;
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
		
		/**
		 * <span lang="ja">指定されたオブジェクトの PRML ストリング表現を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param scenes
		 * <span lang="ja">変換したい XMLList インスタンスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">オブジェクトの PRML 表現です。</span>
		 * <span lang="en"></span>
		 */
		public function toPRMLString( scenes:XMLList = null ):XML {
			scenes ||= this.scenes;
			
			var xml:XML = <prml version={ _version.toString() } type={ _contentType } />;
			xml.prependChild( scenes );
			return xml;
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return _data;
		}
	}
}
