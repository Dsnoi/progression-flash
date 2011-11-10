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
package jp.progression.scenes {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.net.Query;
	import jp.nium.utils.MathUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	
	/*======================================================================*//**
	 * <p>SceneId クラスは、Progression が管理するシーンオブジェクト構造上の特定のシーンを表すモデルクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SceneId {
		
		/*======================================================================*//**
		 * シーン識別子のフォーマットを判別する正規表現を取得します。
		 */
		private static const _VALIDATE_REGEXP:RegExp = new RegExp( "^((/[-a-z0-9,_&%+]+(/\.|/\.\.)*)*(/[-a-z0-9,_&%+]+)+)(\\?([-a-z0-9,_&%.+]+=[-a-z0-9,_&%.+]+)(&([-a-z0-9,_&%.+]+=[-a-z0-9,_&%.+]+))*)?$", "i" );
		
		/*======================================================================*//**
		 * シーン識別子を移動させる際に判別する正規表現を取得します。
		 */
		private static const _TRANSFER_REGEXP:RegExp = new RegExp( "/(\.\./)*$", "g" );
		
		
		
		
		
		/*======================================================================*//**
		 * <p>シーンパスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get path():String { return _path; }
		private var _path:String;
		
		/*======================================================================*//**
		 * <p>シーンパスの深度を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get length():int { return _length; }
		private var _length:int = 0;
		
		/*======================================================================*//**
		 * <p>シーンパスに関連付けられているクエリを Object 表現で取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get query():Query { return _query; }
		private var _query:Query;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい SceneId インスタンスを作成します。</p>
		 * <p>Creates a new SceneId object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param scenePath
		 * 	<p>シーン識別子に変換するシーンパス、または URL を表すストリングです。</p>
		 * 	<p></p>
		 * @param query
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
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
		
		
		
		
		
		/*======================================================================*//**
		 * <p>シーンパスの書式が正しいかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param path
		 * 	<p>書式を調べるシーンパスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>書式が正しければ true に、それ以外の場合は false になります。</p>
		 * 	<p></p>
		 */
		public static function validate( path:String ):Boolean {
			return _VALIDATE_REGEXP.test( path );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された絶対シーンパスもしくは相対シーンパスを使用して移動後のシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param path
		 * 	<p>移動先のシーンパスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>移動後のシーン識別子です。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>シーン識別子の保存するシーンパスの指定された範囲のエレメントを取り出して、新しいシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param startIndex
		 * 	<p>スライスの始点のインデックスを示す数値です。</p>
		 * 	<p></p>
		 * @param endIndex
		 * 	<p>スライスの終点のインデックスを示す数値です。このパラメータを省略すると、スライスには配列の最初から最後までのすべてのエレメントが取り込まれます。endIndex が負の数値の場合、終点は配列の末尾から開始します。つまり、-1 が最後のエレメントです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>元のシーンパスから取り出した一連のエレメントから成るシーン識別子です。</p>
		 * 	<p></p>
		 */
		public function slice( startIndex:int = 0, endIndex:int = 16777215 ):SceneId {
			if ( endIndex - startIndex == 0 ) { throw new RangeError( ErrorMessageConstants.getMessage( "ERROR_2006" ) ); }
			
			var dir:Array = path.split( "/" );
			dir.shift();
			
			dir = dir.slice( startIndex, endIndex );
			
			return new SceneId( "/" + dir.join( "/" ), _query );
		}
		
		/*======================================================================*//**
		 * <p>指定されたシーン識別子が、自身の表すシーンパスの子シーンオブジェクトを指しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param sceneId
		 * 	<p>テストするシーン識別子です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>子シーンオブジェクトを指していれば true に、それ以外の場合は false になります。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>指定されたシーン識別子が、自身の表すシーンパスと同一かどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param sceneId
		 * 	<p>テストするシーン識別子です。</p>
		 * 	<p></p>
		 * @param matchQuery
		 * 	<p>テストにクエリの値を含めるかどうかです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>同一のシーンパスを指していれば true に、それ以外の場合は false になります。</p>
		 * 	<p></p>
		 */
		public function equals( sceneId:SceneId, matchQuery:Boolean = false ):Boolean {
			// クエリが一致していなければ false を返す
			if ( matchQuery && !query.equals( sceneId.query ) ) { return false; }
			
			return ( path == sceneId.path );
		}
		
		/*======================================================================*//**
		 * <p>指定位置にあるシーンの名前を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param index
		 * 	<p>取得した名前のあるシーンの位置です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>指定位置にあるシーンの名前です。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>SceneId インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SceneId subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい SceneId インスタンスです。</p>
		 * 	<p>A new SceneId object that is identical to the original.</p>
		 */
		public function clone():SceneId {
			return new SceneId( _path, _query );
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
			var query:String = ObjectUtil.toQueryString( _query );
			query &&= "?" + query;
			return _path + query;
		}
	}
}









