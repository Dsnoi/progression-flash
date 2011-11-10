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
package jp.nium.version {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	
	/**
	 * <span lang="ja">Version クラスは、バージョン情報を格納し、バージョンの比較などを行うためのモデルクラスです。</span>
	 * <span lang="en">Version class is a model class to store the version information and compare the version.</span>
	 * 
	 * @example <listing version="3.0" >
	 * ver version100:Version = new Version( 1, 0, 0 );
	 * ver version200:Version = new Version( "2.0.0" );
	 * trace( version100.compare( version200 ) ); // -3 を返す
	 * </listing>
	 */
	public class Version {
		
		/**
		 * バージョン情報のフォーマットを判別する正規表現を取得します。
		 */
		private static const _FORMAT_REGEXP:RegExp = new RegExp( "^([0-9]+)(\.[0-9]+)?(\.[0-9]+)?( .*$)?" );
		
		
		
		
		
		/**
		 * <span lang="ja">メジャーバージョンを取得します。</span>
		 * <span lang="en">Get the major version.</span>
		 */
		public function get majorVersion():int { return _majorVersion; }
		private var _majorVersion:int = 0;
		
		/**
		 * <span lang="ja">マイナーバージョンを取得します。</span>
		 * <span lang="en">Get the minor version.</span>
		 */
		public function get minorVersion():int { return _minorVersion; }
		private var _minorVersion:int = 0;
		
		/**
		 * <span lang="ja">ビルドバージョンを取得します。</span>
		 * <span lang="en">Get the build version.</span>
		 */
		public function get buildVersion():int { return _buildVersion; }
		private var _buildVersion:int = 0;
		
		/**
		 * <span lang="ja">リリース情報を取得します。</span>
		 * <span lang="en">Get the release information.</span>
		 */
		public function get release():String { return _release; }
		private var _release:String;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Version インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Version object.</span>
		 * 
		 * @param majorVersionOrVersionValue
		 * <span lang="ja">メジャーバージョン、またはバージョンを表すストリング値です。</span>
		 * <span lang="en">The major version or the string value to express the version.</span>
		 * @param minorVersion
		 * <span lang="ja">マイナーバージョンです。</span>
		 * <span lang="en">The minor version.</span>
		 * @param buildVersion
		 * <span lang="ja">ビルドバージョンです。</span>
		 * <span lang="en">The build version.</span>
		 * @param release
		 * <span lang="ja">リリース情報です。</span>
		 * <span lang="en">The release information.</span>
		 */
		public function Version( majorVersionOrVersionValue:*, minorVersion:int = 0, buildVersion:int = 0, release:String = null ) {
			switch ( true ) {
				case majorVersionOrVersionValue is String	: {
					// フォーマットを確認する
					if ( !_FORMAT_REGEXP.test( majorVersionOrVersionValue ) ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
					
					// 引数を設定する
					var items:Array = String( majorVersionOrVersionValue ).split( " " );
					
					var versions:Array = new RegExp( "^([0-9]+)([^0-9]([0-9]*))?([^0-9]([0-9]*))?.*$" ).exec( items.shift() );
					if ( !versions ) { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
					_majorVersion = parseInt( versions[1] );
					_minorVersion = parseInt( versions[3] );
					_buildVersion = parseInt( versions[5] );
					
					_release = String( items.join( " " ) );
					break;
				}
				case majorVersionOrVersionValue is int		:
				case majorVersionOrVersionValue is uint		:
				case majorVersionOrVersionValue is Number	: {
					// 引数を設定する
					_majorVersion = Math.floor( majorVersionOrVersionValue );
					_minorVersion = minorVersion;
					_buildVersion = buildVersion;
					_release = release || "";
					break;
				}
				default										: { throw new FormatError( ErrorMessageConstants.getMessage( "ERROR_8005" ) ); }
			}
		}
		
		
		
		
		
		/**
		 * <span lang="ja">対象の Version インスタンスを比較した結果を返します。
		 * この比較結果にリリース情報の値は影響しません。</span>
		 * <span lang="en">Returns the result of comparison of the Version instance.
		 * The result of comparison do not affect to the value of release information.</span>
		 * 
		 * @param version
		 * <span lang="ja">比較したい Version インスタンスです。</span>
		 * <span lang="en">The Version instance to compare.</span>
		 * @return
		 * <span lang="ja">自身のバージョンが高ければ 1 以上の数値を、バージョンが同じであれば 0 を、バージョンが低ければ -1 以下の数値です。</span>
		 * <span lang="en"></span>
		 */
		public function compare( version:Version ):int {
			// メジャーバージョンが高ければ 3 を返す
			if ( _majorVersion > version.majorVersion ) { return 3; }
			
			// メジャーバージョンが低ければ -3 を返す
			if ( _majorVersion < version.majorVersion ) { return -3; }
			
			// マイナーバージョンが高ければ 2 を返す
			if ( _minorVersion > version.minorVersion ) { return 2; }
			
			// マイナーバージョンが低ければ -2 を返す
			if ( _minorVersion < version.minorVersion ) { return -2; }
			
			// ビルドバージョンが高ければ 1 を返す
			if ( _buildVersion > version.buildVersion ) { return 1; }
			
			// ビルドバージョンが低ければ -1 を返す
			if ( _buildVersion < version.buildVersion ) { return -1; }
			
			return 0;
		}
		
		/**
		 * <span lang="ja">2 つのバージョンをリリース情報も含めて完全に一致するかどうかを比較した結果を返します。</span>
		 * <span lang="en">Returns the value above 1 if the own version is higher, returns 0 if the version is same and return the value below -1 if the own version is lower.</span>
		 * 
		 * @param version
		 * <span lang="ja">比較したい Version インスタンスです。</span>
		 * <span lang="en">The Version instance to compare.</span>
		 * @return
		 * <span lang="ja">完全に一致する場合には true を、一致しない場合には false です。</span>
		 * <span lang="en">Returns true if completly same, otherwise return false.</span>
		 */
		public function equals( version:Version ):Boolean {
			return ( toString() == version.toString() );
		}
		
		/**
		 * <span lang="ja">Version インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Version subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Version インスタンスです。</span>
		 * <span lang="en">A new Version object that is identical to the original.</span>
		 */
		public function clone():Version {
			return new Version( _majorVersion, _minorVersion, _buildVersion, _release );
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
			return _majorVersion + "." + _minorVersion + "." + _buildVersion + ( _release ? " " + _release : "" );
		}
	}
}
