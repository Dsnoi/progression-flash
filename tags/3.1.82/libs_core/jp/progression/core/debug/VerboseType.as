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
package jp.progression.core.debug {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">VerboseType クラスは、Verbose.type プロパティの値を提供します。
	 * VerboseType クラスを直接インスタンス化することはできません。
	 * new VerboseType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class VerboseType {
		
		/**
		 * <span lang="ja">ログの出力を行わないよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const NONE:String = "none";
		
		/**
		 * <span lang="ja">ログの出力を基本的な項目のみ行うよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const SIMPLE:String = "simple";
		
		/**
		 * <span lang="ja">ログの出力を全ての項目に対して行うよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const FULL:String = "full";
		
		
		
		
		
		/**
		 * @private
		 */
		public function VerboseType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "VerboseType" ) );
		}
	}
}
