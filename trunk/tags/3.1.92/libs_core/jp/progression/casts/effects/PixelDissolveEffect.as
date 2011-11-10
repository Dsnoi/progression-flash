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
	import fl.transitions.PixelDissolve;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">PixelDissolveEffect クラスは、チェッカーボードのパターンでランダムに表示される矩形または消える矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class PixelDissolveEffect extends EffectBase {
		
		/**
		 * <span lang="ja">水平軸に沿ったマスク矩形セクションの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get xSections():int { return super.parameters.xSections; }
		public function set xSections( value:int ):void { super.parameters.xSections = Math.max( 0, value ); }
		
		/**
		 * <span lang="ja">垂直軸に沿ったマスク矩形セクションの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get ySections():int { return super.parameters.ySections; }
		public function set ySections( value:int ):void { super.parameters.ySections = Math.max( 0, value ); }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい PixelDissolveEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new PixelDissolveEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function PixelDissolveEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( PixelDissolve, initObject );
			
			// 初期化する
			super.parameters.xSections = 10;
			super.parameters.ySections = 10;
		}
	}
}
