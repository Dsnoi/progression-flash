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
package jp.progression.core.utils {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <span lang="ja">SceneIdUtil クラスは、SceneId インスタンスを操作するためのユーティリティクラスです。
	 * SceneIdUtil クラスを直接インスタンス化することはできません。
	 * new SceneIdUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 */
	public final class SceneIdUtil {
		
		/**
		 * @private
		 */
		public function SceneIdUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "SceneIdUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定されたシーン識別子のルート要素を省略したショートパスを返します。
		 * この操作では元のシーン識別子は変更されません。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">対象のシーン識別子です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">ショートパスを表すストリング表現です。</span>
		 * <span lang="en"></span>
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
