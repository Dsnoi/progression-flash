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
	import fl.transitions.PixelDissolve;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/*======================================================================*//**
	 * <p>PixelDissolveEffect クラスは、チェッカーボードのパターンでランダムに表示される矩形または消える矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class PixelDissolveEffect extends EffectBase {
		
		/*======================================================================*//**
		 * <p>水平軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get xSections():int { return super.parameters.xSections; }
		public function set xSections( value:int ):void { super.parameters.xSections = Math.max( 0, value ); }
		
		/*======================================================================*//**
		 * <p>垂直軸に沿ったマスク矩形セクションの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get ySections():int { return super.parameters.ySections; }
		public function set ySections( value:int ):void { super.parameters.ySections = Math.max( 0, value ); }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい PixelDissolveEffect インスタンスを作成します。</p>
		 * <p>Creates a new PixelDissolveEffect object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
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









