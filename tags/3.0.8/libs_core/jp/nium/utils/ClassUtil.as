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
package jp.nium.utils {
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/*======================================================================*//**
	 * <p>ClassUtil クラスは、クラス操作のためのユーティリティクラスです。
	 * ClassUtil クラスを直接インスタンス化することはできません。
	 * new ClassUtil() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class ClassUtil {
		
		/*======================================================================*//**
		 * @private
		 */
		public function ClassUtil() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ClassUtil" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>対象のクラス名を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>クラス名を取得する対象です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>クラス名です。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getClassName( MovieClip ) ); // MovieClip
		 * trace( ClassUtil.getClassName( new MovieClip() ) ); // MovieClip
		 * </listing>
		 */
		public static function getClassName( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).pop();
		}
		
		/*======================================================================*//**
		 * <p>対象のクラスパスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>クラスパスを取得する対象です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>クラスパスです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getClassPath( MovieClip ) ); // flash.display.MovieClip
		 * trace( ClassUtil.getClassPath( new MovieClip() ) ); // flash.display.MovieClip
		 * </listing>
		 */
		public static function getClassPath( target:* ):String {
			return getQualifiedClassName( target ).replace( new RegExp( "::", "g" ), "." );
		}
		
		/*======================================================================*//**
		 * <p>対象のパッケージを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>パッケージを取得する対象です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>パッケージです。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.getPackage( MovieClip ) ); // flash.display
		 * trace( ClassUtil.getPackage( new MovieClip() ) ); // flash.display
		 * </listing>
		 */
		public static function getPackage( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).shift();
		}
		
		/*======================================================================*//**
		 * <p>対象のクラスに dynamic 属性が設定されているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>dynamic 属性の有無を調べる対象です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>dynamic 属性があれば true を、違っていれば false を返します。</p>
		 * 	<p></p>
		 * 
		 * @example <listing version="3.0" >
		 * trace( ClassUtil.isDynamic( new Sprite() ) ); // false
		 * trace( ClassUtil.isDynamic( new MovieClip() ) ); // true
		 * </listing>
		 */
		public static function isDynamic( target:* ):Boolean {
			return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isDynamic" ) ) );
		}
		
		/*======================================================================*//**
		 * <p>対象のクラスに final 属性が設定されているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>final 属性の有無を調べる対象です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>final 属性があれば true を、違っていれば false を返します。</p>
		 * 	<p></p>
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









