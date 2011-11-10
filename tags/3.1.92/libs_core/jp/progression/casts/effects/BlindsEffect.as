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
	import fl.transitions.Blinds;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">BlindsEffect クラスは、次第に表示される矩形または消えていく矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class BlindsEffect extends EffectBase {
		
		/**
		 * <span lang="ja">Blinds 効果内のマスクストリップの数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get numStrips():int { return super.parameters.numStrips; }
		public function set numStrips( value:int ):void { super.parameters.numStrips = Math.max( 1, value ); }
		
		/**
		 * <span lang="ja">マスクストリップが垂直か水平かを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get dimension():int { return super.parameters.dimension; }
		public function set dimension( value:int ):void { super.parameters.dimension = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい BlindsEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new BlindsEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
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
