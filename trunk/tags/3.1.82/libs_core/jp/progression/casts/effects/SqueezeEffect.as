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
	import fl.transitions.Squeeze;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">SqueezeEffect クラスは、水平または垂直の拡大・縮小エフェクトを使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class SqueezeEffect extends EffectBase {
		
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
		 * <span lang="ja">新しい SqueezeEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new SqueezeEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function SqueezeEffect( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( Squeeze, initObject );
			
			// 初期化する
			super.parameters.dimension = EffectDimensionType.HORIZONTAL;
		}
	}
}
