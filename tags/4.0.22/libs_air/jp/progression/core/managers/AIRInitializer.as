/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 4.0.22
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core.managers {
	import jp.progression.core.display.Background;
	import jp.progression.core.ns.progression_internal;
	import jp.progression.Progression;
	
	/**
	 * @private
	 */
	public class AIRInitializer implements IInitializer {
		
		/**
		 * <span lang="ja">関連付けられている Progression インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():Progression { return _target; }
		private var _target:Progression;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい AIRInitializer インスタンスを作成します。</span>
		 * <span lang="en">Creates a new AIRInitializer object.</span>
		 * 
		 * @param target
		 * <span lang="ja">関連付けたい Progression インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function AIRInitializer( target:Progression ) {
			// クラスをコンパイルに含める
			progression_internal;
			
			// 引数を設定する
			_target = target;
			
			// すでに設置済みでなければ
			if ( !( _target.stage.getChildAt( 0 ) as Background ) ) {
				// Background を作成する
				_target.stage.addChildAt( Background.progression_internal::$createInstance( _target ), 0 );
			}
		}
		
		
		
		
		
		/**
		 * <span lang="ja">破棄します。</span>
		 * <span lang="en"></span>
		 */
		public function dispose():void {
			// 破棄する
			_target = null;
		}
	}
}
