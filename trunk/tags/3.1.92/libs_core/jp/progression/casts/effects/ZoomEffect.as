/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.casts.effects {
	import fl.transitions.Zoom;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">ZoomEffect クラスは、縦横比を維持しながらの拡大・縮小エフェクトを使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class ZoomEffect extends EffectBase {
		
		/**
		 * <span lang="ja">新しい ZoomEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ZoomEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function ZoomEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Zoom, initObject );
		}
	}
}
