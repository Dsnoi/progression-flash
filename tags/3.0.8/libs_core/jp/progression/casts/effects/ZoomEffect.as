/*======================================================================*//**
 * 
 * Progression
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://progression.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.progression.casts.effects {
	import fl.transitions.Zoom;
	import jp.progression.core.casts.effects.EffectBase;
	
	/*======================================================================*//**
	 * <p>ZoomEffect クラスは、縦横比を維持しながらの拡大・縮小エフェクトを使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ZoomEffect extends EffectBase {
		
		/*======================================================================*//**
		 * <p>新しい ZoomEffect インスタンスを作成します。</p>
		 * <p>Creates a new ZoomEffect object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function ZoomEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Zoom, initObject );
		}
	}
}









