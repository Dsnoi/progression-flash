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
	 * <span lang="ja">EffectDirectionType クラスは、directionType プロパティの値を提供します。
	 * EffectDirectionType クラスを直接インスタンス化することはできません。
	 * new EffectDirectionType() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class EffectDirectionType {
		
		/**
		 * <span lang="ja">エフェクトが開始方向のイージングをするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const IN:String = "in";
		
		/**
		 * <span lang="ja">エフェクトが終了方向のイージングをするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const OUT:String = "out";
		
		/**
		 * <span lang="ja">エフェクトが開始・終了方向のイージングをするよう指定します。</span>
		 * <span lang="en"></span>
		 */
		public static const IN_OUT:String = "inOut";
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectDirectionType() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectDirectionType" ) );
		}
	}
}
