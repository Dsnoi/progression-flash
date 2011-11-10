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
	import fl.transitions.Iris;
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	
	/**
	 * <span lang="ja">IrisEffect クラスは、次第に表示される矩形または消えていく矩形を使用して、イベントフローとの連携機能を実装しながらムービークリップオブジェクトを表示します。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class IrisEffect extends EffectBase {
		
		/**
		 * <span lang="ja">エフェクトの開始位置を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get startPoint():int { return super.parameters.startPoint; }
		public function set startPoint( value:int ):void { super.parameters.startPoint = value; }
		
		/**
		 * <span lang="ja">マスクシェイプを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get shape():String { return super.parameters.shape; }
		public function set shape( value:String ):void { super.parameters.shape = value; }
		
		/**
		 * @private
		 */
		public override function get parameters():Object { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		public override function set parameters( value:Object ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parameters" ) ); }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい IrisEffect インスタンスを作成します。</span>
		 * <span lang="en">Creates a new IrisEffect object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
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
