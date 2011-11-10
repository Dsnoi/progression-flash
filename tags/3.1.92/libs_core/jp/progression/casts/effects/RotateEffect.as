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
	import fl.transitions.Rotate;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">RotateEffect クラスは、回転エフェクトを使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class RotateEffect extends EffectBase {
		
		/**
		 * <span lang="ja">対象を反時計回りに回転させるかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get ccw():Boolean { return super.parameters.ccw; }
		public function set ccw( value:Boolean ):void { super.parameters.ccw = value; }
		
		/**
		 * <span lang="ja">オブジェクトを回転する角度を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get degrees():int { return super.parameters.degrees; }
		public function set degrees( value:int ):void { super.parameters.degrees = Math.max( 0, value ); }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい RotateEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new RotateEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
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
