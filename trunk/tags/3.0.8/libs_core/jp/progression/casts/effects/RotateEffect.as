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
	import fl.transitions.Rotate;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/*======================================================================*//**
	 * <p>RotateEffect クラスは、回転エフェクトを使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class RotateEffect extends EffectBase {
		
		/*======================================================================*//**
		 * <p>対象を反時計回りに回転させるかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get ccw():Boolean { return super.parameters.ccw; }
		public function set ccw( value:Boolean ):void { super.parameters.ccw = value; }
		
		/*======================================================================*//**
		 * <p>オブジェクトを回転する角度を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get degrees():int { return super.parameters.degrees; }
		public function set degrees( value:int ):void { super.parameters.degrees = Math.max( 0, value ); }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい RotateEffect インスタンスを作成します。</p>
		 * <p>Creates a new RotateEffect object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function RotateEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Rotate, initObject );
			
			// 初期化する
			super.parameters.ccw = false;
			super.parameters.degrees = 360;
		}
	}
}









