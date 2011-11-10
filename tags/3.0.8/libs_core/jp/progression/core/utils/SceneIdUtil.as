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
package jp.progression.core.utils {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.scenes.SceneId;
	
	/*======================================================================*//**
	 * <p>SceneIdUtil クラスは、SceneId インスタンスを操作するためのユーティリティクラスです。
	 * SceneIdUtil クラスを直接インスタンス化することはできません。
	 * new SceneIdUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class SceneIdUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function SceneIdUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "SceneIdUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定されたシーン識別子のルート要素を省略したショートパスを返します。
		 * この操作では元のシーン識別子は変更されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param sceneId
		 * 	<p>対象のシーン識別子です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>ショートパスを表すストリング表現です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function toShortPath( sceneId:SceneId ):String {
			var shortPath:String = sceneId.path.split( "/" ).slice( 2 ).join( "/" );
			shortPath &&= "/" + shortPath;
			
			// クエリが存在すれば
			if ( sceneId.query.toString() ) {
				shortPath += "?" + sceneId.query;
			}
			
			return shortPath;
		}
	}
}









