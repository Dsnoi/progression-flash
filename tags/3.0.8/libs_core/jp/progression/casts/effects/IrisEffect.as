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
	import fl.transitions.Iris;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/*======================================================================*//**
	 * <p>IrisEffect クラスは、次第に表示される矩形または消えていく矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class IrisEffect extends EffectBase {
		
		/*======================================================================*//**
		 * <p>エフェクトの開始位置を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get startPoint():int { return super.parameters.startPoint; }
		public function set startPoint( value:int ):void { super.parameters.startPoint = value; }
		
		/*======================================================================*//**
		 * <p>マスクシェイプを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get shape():String { return super.parameters.shape; }
		public function set shape( value:String ):void { super.parameters.shape = value; }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい IrisEffect インスタンスを作成します。</p>
		 * <p>Creates a new IrisEffect object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function IrisEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Iris, initObject );
			
			// 初期化する
			super.parameters.startPoint = EffectStartPointType.CENTER;
			super.parameters.shape = Iris.SQUARE;
		}
	}
}









