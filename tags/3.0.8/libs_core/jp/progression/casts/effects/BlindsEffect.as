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
	import fl.transitions.Blinds;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/*======================================================================*//**
	 * <p>BlindsEffect クラスは、次第に表示される矩形または消えていく矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class BlindsEffect extends EffectBase {
		
		/*======================================================================*//**
		 * <p>Blinds 効果内のマスクストリップの数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get numStrips():int { return super.parameters.numStrips; }
		public function set numStrips( value:int ):void { super.parameters.numStrips = Math.max( 1, value ); }
		
		/*======================================================================*//**
		 * <p>マスクストリップが垂直か水平かを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get dimension():int { return super.parameters.dimension; }
		public function set dimension( value:int ):void { super.parameters.dimension = value; }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい BlindsEffect インスタンスを作成します。</p>
		 * <p>Creates a new BlindsEffect object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function BlindsEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Blinds, initObject );
			
			// 初期化する
			super.parameters.numStrips = 10;
			super.parameters.dimension = EffectDimensionType.VERTICAL;
		}
	}
}









