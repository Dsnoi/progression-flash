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
package jp.progression.scenes {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.net.Query;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	
	/**
	 * <span lang="ja">SceneId クラスは、Progression が管理するシーンオブジェクト構造上の特定のシーンを表すモデルクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneId {
		
		/**
		 * シーン識別子のフォーマットを判別する正規表現を取得します。
		 */
		private static const _VALIDATE_REGEXP:RegExp = new RegExp( "^((/[-a-z0-9,_&%+]+(/\\.|/\\.\\.)*)*(/[-a-z0-9,_&%+]+)+)(\\?([-a-z0-9,_&%.+]+=[-a-z0-9,_&%.+]+)(&([-a-z0-9,_&%.+]+=[-a-z0-9,_&%.+]+))*)?$", "i" );
		
		/**
		 * シーン識別子を移動させる際に判別する正規表現を取得します。
		 */
		private static const _TRANSFER_REGEXP:RegExp = new RegExp( "/(\\.\\./)*$", "g" );
		
		
		
		
		
		/**
		 * <span lang="ja">シーンパスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get path():String { return _path; }
		private var _path:String;
		
		/**
		 * <span lang="ja">シーンパスの深度を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get length():int { return _length; }
		private var _length:int = 0;
		
		/**
		 * <span lang="ja">シーンパスに関連付けられているクエリを Object 表現で取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get query():Query { return _query; }
		private var _query:Query;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい SceneId インスタンスを作成します。</span>
		 * <span lang="en">Creates a new SceneId object.</span>
		 * 
		 * @param scenePath
		 * <span lang="ja">シーン識別子に変換するシーンパス、または URL を表すストリングです。</span>
		 * <span lang="en"></span>
		 * @param query
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function SceneId( scenePath:String, query:Object = null ) {
			// クエリを結合する
			var q:String = ObjectUtil.toQueryString( query );
			q &&= ( ( scenePath.indexOf( "?" ) != -1 ) ? "&" : "?" ) + q;
			
			// URL エンコードする
			scenePath = encodeURI( decodeURI( scenePath + q ) );
			
			// 書式が正しくない場合エラーを送出する
			if ( !validate( scenePath ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_9007" ) ); }
			
			// 引数を設定する
			var segments:Array = scenePath.split( "?" );
			
			// シーンパスを取得する
			_path = segments[0];
			
			// Query を作成する
			_query = new Query( false, StringUtil.queryToObject( decodeURI( segments[1] || "" ) ) );
			
			// 初期化する
			_length = _path.split( "/" ).length - 1;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">シーンパスの書式が正しいかどうかを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param path
		 * <span lang="ja">書式を調べるシーンパスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">書式が正しければ true に、それ以外の場合は false になります。</span>
		 * <span lang="en"></span>
		 */
		public static function validate( path:String ):Boolean {
			return _VALIDATE_REGEXP.test( path );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された絶対シーンパスもしくは相対シーンパスを使用して移動後のシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</span>
		 * <span lang="en"></span>
		 * 
		 * @param path
		 * <span lang="ja">移動先のシーンパスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">移動後のシーン識別子です。</span>
		 * <span lang="en"></span>
		 */
		public function transfer( path:String ):SceneId {
			// 相対パスの場合、既存のパスに結合する
			if ( path.charAt(0) != "/" ) {
				path = _path + "/" + path;
			}
			
			// パスに /./ が存在すれば結合する
			path = path.replace( "/./", "/" );
			
			// /A/B/../ なら /A/ に変換する
			path = path.replace( new RegExp( "/[-a-z0-9 ,=_&%?+]+/[-a-z0-9 ,=_&%?+]+/\\.\\./", "gi" ), function():String {
				return String( arguments[0] ).split( "/" ).slice( 0, 2 ).join( "/" ) + "/";
			} );
			
			// /../ が存在すれば削除する
			path = path.replace( _TRANSFER_REGEXP, "" );
			
			// 書式が正しくない場合エラーを送出する
			if ( !validate( path ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_9007" ) ); }
			
			return new SceneId( path, _query );
		}
		
		/**
		 * <span lang="ja">シーン識別子の保存するシーンパスの指定された範囲のエレメントを取り出して、新しいシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</span>
		 * <span lang="en"></span>
		 * 
		 * @param startIndex
		 * <span lang="ja">スライスの始点のインデックスを示す数値です。</span>
		 * <span lang="en"></span>
		 * @param endIndex
		 * <span lang="ja">スライスの終点のインデックスを示す数値です。このパラメータを省略すると、スライスには配列の最初から最後までのすべてのエレメントが取り込まれます。endIndex が負の数値の場合、終点は配列の末尾から開始します。つまり、-1 が最後のエレメントです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">元のシーンパスから取り出した一連のエレメントから成るシーン識別子です。</span>
		 * <span lang="en"></span>
		 */
		public function slice( startIndex:int = 0, endIndex:int = 16777215 ):SceneId {
			if ( endIndex - startIndex == 0 ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_2006" ) ); }
			
			var dir:Array = path.split( "/" );
			dir.shift();
			
			dir = dir.slice( startIndex, endIndex );
			
			return new SceneId( "/" + dir.join( "/" ), _query );
		}
		
		/**
		 * <span lang="ja">指定されたシーン識別子が、自身の表すシーンパスの子シーンオブジェクトを指しているかどうかを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">テストするシーン識別子です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">子シーンオブジェクトを指していれば true に、それ以外の場合は false になります。</span>
		 * <span lang="en"></span>
		 */
		public function contains( sceneId:SceneId ):Boolean {
			var path1:Array = path.split( "/" );
			var path2:Array = sceneId.path.split( "/" );
			
			var l:int = path1.length;
			for ( var i:int = 0; i < l; i++ ) {
				if ( path1[i] != path2[i] ) { return false; }
			}
			
			return true;
		}
		
		/**
		 * <span lang="ja">指定されたシーン識別子が、自身の表すシーンパスと同一かどうかを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">テストするシーン識別子です。</span>
		 * <span lang="en"></span>
		 * @param matchQuery
		 * <span lang="ja">テストにクエリの値を含めるかどうかです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">同一のシーンパスを指していれば true に、それ以外の場合は false になります。</span>
		 * <span lang="en"></span>
		 */
		public function equals( sceneId:SceneId, matchQuery:Boolean = false ):Boolean {
			// クエリが一致していなければ false を返す
			if ( matchQuery && !query.equals( sceneId.query ) ) { return false; }
			
			return ( path == sceneId.path );
		}
		
		/**
		 * <span lang="ja">指定位置にあるシーンの名前を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param index
		 * <span lang="ja">取得した名前のあるシーンの位置です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">指定位置にあるシーンの名前です。</span>
		 * <span lang="en"></span>
		 */
		public function getNameByIndex( index:int ):String {
			var dir:Array = path.split( "/" );
			dir.shift();
			
			// マイナスが指定されたら、最後尾からのインデックスを取得する
			if ( index < 0 ) {
				index += dir.length;
			}
			
			return dir[index];
		}
		
		/**
		 * <span lang="ja">SceneId インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an SceneId subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい SceneId インスタンスです。</span>
		 * <span lang="en">A new SceneId object that is identical to the original.</span>
		 */
		public function clone():SceneId {
			return new SceneId( _path, _query );
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
			var query:String = ObjectUtil.toQueryString( _query );
			query &&= "?" + query;
			return _path + query;
		}
	}
}
