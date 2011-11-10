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
package jp.progression.casts.effects {
	import jp.nium.core.errors.ErrorMessageConstants;
	
	/**
	 * <span lang="ja">EffectDimensionType クラスは、dimension プロパティの値を提供します。
	 * EffectDimensionType クラスを直接インスタンス化することはできません。
	 * new EffectDimensionType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class EffectDimensionType {
		
		/**
		 * <span lang="ja">エフェクトを垂直方向に適用するよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const VERTICAL:int = 0;
		
		/**
		 * <span lang="ja">エフェクトを水平方向に適用するよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const HORIZONTAL:int = 1;
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectDimensionType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectDimensionType" ) );
		}
	}
}
