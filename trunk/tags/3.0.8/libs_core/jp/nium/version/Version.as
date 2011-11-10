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
package jp.nium.version {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	
	/*======================================================================*//**
	 * <p>Version クラスは、バージョン情報を格納し、バージョンの比較などを行うためのモデルクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * ver version100:Version = new Version( 1, 0, 0 );
	 * ver version200:Version = new Version( "2.0.0" );
	 * trace( version100.compare( version200 ) ); // -3 を返す
	 * </listing>
	 */
	public class Version {
		
		/*======================================================================*//**
		 * バージョン情報のフォーマットを判別する正規表現を取得します。
		 */
		private static const _FORMAT_REGEXP:RegExp = new RegExp( "^([0-9]+)(\.[0-9]+)?(\.[0-9]+)?( .*$)?" );
		
		
		
		
		
		/*======================================================================*//**
		 * <p>メジャーバージョンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get majorVersion():int { return _majorVersion; }
		private var _majorVersion:int = 0;
		
		/*======================================================================*//**
		 * <p>マイナーバージョンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get minorVersion():int { return _minorVersion; }
		private var _minorVersion:int = 0;
		
		/*======================================================================*//**
		 * <p>ビルドバージョンを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get buildVersion():int { return _buildVersion; }
		private var _buildVersion:int = 0;
		
		/*======================================================================*//**
		 * <p>リリース情報を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get release():String { return _release; }
		private var _release:String;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Version インスタンスを作成します。</p>
		 * <p>Creates a new Version object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param majorVersionOrVersionValue
		 * 	<p>メジャーバージョン、またはバージョンを表すストリング値です。</p>
		 * 	<p></p>
		 * @param minorVersion
		 * 	<p>マイナーバージョンです。</p>
		 * 	<p></p>
		 * @param buildVersion
		 * 	<p>ビルドバージョンです。</p>
		 * 	<p></p>
		 * @param release
		 * 	<p>リリース情報です。</p>
		 * 	<p></p>
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
		
		
		
		
		
		/*======================================================================*//**
		 * <p>対象の Version インスタンスを比較した結果を返します。
		 * この比較結果にリリース情報の値は影響しません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param version
		 * 	<p>比較したい Version インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身のバージョンが高ければ 1 以上の数値を、バージョンが同じであれば 0 を、バージョンが低ければ -1 以下の数値です。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * <p>2 つのバージョンをリリース情報も含めて完全に一致するかどうかを比較した結果を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param version
		 * 	<p>比較したい Version インスタンスです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>完全に一致する場合には true を、一致しない場合には false です。</p>
		 * 	<p></p>
		 */
		public function equals( version:Version ):Boolean {
			return ( toString() == version.toString() );
		}
		
		/*======================================================================*//**
		 * <p>Version インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Version subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Version インスタンスです。</p>
		 * 	<p>A new Version object that is identical to the original.</p>
		 */
		public function clone():Version {
			return new Version( _majorVersion, _minorVersion, _buildVersion, _release );
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
			return _majorVersion + "." + _minorVersion + "." + _buildVersion + ( _release ? " " + _release : "" );
		}
	}
}









