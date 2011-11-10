/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.utils {
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">ClassUtil クラスは、クラス操作のためのユーティリティクラスです。
	 * ClassUtil クラスを直接インスタンス化することはできません。
	 * new ClassUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en">The ClassUtil class is an utility class for class operation.
	 * ClassUtil class can not instanciate directly.
	 * When call the new ClassUtil() constructor, the ArgumentError exception will be thrown.</span>
	 */
	public final class ClassUtil {
		
		/**
		 * @private
		 */
		public function ClassUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ClassUtil" ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">対象のクラス名を返します。</span>
		 * <span lang="en">Returns the class name of the object.</span>
		 * 
		 * @param target
		 * <span lang="ja">クラス名を取得する対象です。</span>
		 * <span lang="en">The object to get the class name.</span>
		 * @return
		 * <span lang="ja">クラス名です。</span>
		 * <span lang="en">The class name.</span>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getClassName( MovieClip ) ); // MovieClip
		 * trace( ClassUtil.getClassName( new MovieClip() ) ); // MovieClip
		 * </listing>
		 */
		public static function getClassName( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).pop();
		}
		
		/**
		 * <span lang="ja">対象のクラスパスを返します。</span>
		 * <span lang="en">Returns the class path of the object.</span>
		 * 
		 * @param target
		 * <span lang="ja">クラスパスを取得する対象です。</span>
		 * <span lang="en">The class path of the object.</span>
		 * @return
		 * <span lang="ja">クラスパスです。</span>
		 * <span lang="en">The class path.</span>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getClassPath( MovieClip ) ); // flash.display.MovieClip
		 * trace( ClassUtil.getClassPath( new MovieClip() ) ); // flash.display.MovieClip
		 * </listing>
		 */
		public static function getClassPath( target:* ):String {
			return getQualifiedClassName( target ).replace( new RegExp( "::", "g" ), "." );
		}
		
		/**
		 * <span lang="ja">対象のパッケージを返します。</span>
		 * <span lang="en">Returns the package of the object.</span>
		 * 
		 * @param target
		 * <span lang="ja">パッケージを取得する対象です。</span>
		 * <span lang="en">The object to get the package.</span>
		 * @return
		 * <span lang="ja">パッケージです。</span>
		 * <span lang="en">The package.</span>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getPackage( MovieClip ) ); // flash.display
		 * trace( ClassUtil.getPackage( new MovieClip() ) ); // flash.display
		 * </listing>
		 */
		public static function getPackage( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).shift();
		}
		
		/**
		 * <span lang="ja">対象のクラスに dynamic 属性が設定されているかどうかを返します。</span>
		 * <span lang="en">Returns if the dynamic attribute is set to the class object.</span>
		 * 
		 * @param target
		 * <span lang="ja">dynamic 属性の有無を調べる対象です。</span>
		 * <span lang="en">The object to check if the dynamic attribute is set or not.</span>
		 * @return
		 * <span lang="ja">dynamic 属性があれば true を、違っていれば false を返します。</span>
		 * <span lang="en">Returns true if dynamic attribute is set, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.isDynamic( new Sprite() ) ); // false
		 * trace( ClassUtil.isDynamic( new MovieClip() ) ); // true
		 * </listing>
		 */
		public static function isDynamic( target:* ):Boolean {
			return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isDynamic" ) ) );
		}
		
		/**
		 * <span lang="ja">対象のクラスに final 属性が設定されているかどうかを返します。</span>
		 * <span lang="en">Returns if the final attribute is set to the class object.</span>
		 * 
		 * @param target
		 * <span lang="ja">final 属性の有無を調べる対象です。</span>
		 * <span lang="en">The object to check if the final attribute is set or not.</span>
		 * @return
		 * <span lang="ja">final 属性があれば true を、違っていれば false を返します。</span>
		 * <span lang="en">Returns true if final attribute is set, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.isFinal( new MovieClip() ) ); // false
		 * trace( ClassUtil.isFinal( new String() ) ); // true
		 * </listing>
		 */
		public static function isFinal( target:* ):Boolean {
			return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isFinal" ) ) );
		}
	}
}
