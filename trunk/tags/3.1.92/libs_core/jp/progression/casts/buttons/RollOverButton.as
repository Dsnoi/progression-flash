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
package jp.progression.casts.buttons {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.buttons.ButtonBase;
	import jp.progression.scenes.SceneId;
	
	/**
	 * <span lang="ja">RollOverButton クラスは、ポインティングデバイスの状態に応じたタイムラインアニメーションを再生させるボタンコンポーネントクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class RollOverButton extends ButtonBase {
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先を示すシーンパスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get navigatePath():String { return _navigatePath; }
		public function set navigatePath( value:String ):void {
			_navigatePath = value;
			
			// 値を設定する
			super.sceneId = new SceneId( value );
		}
		private var _navigatePath:String;
		
		/**
		 * @private
		 */
		public override function get sceneId():SceneId { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		public override function set sceneId( value:SceneId ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		
		/**
		 * @private
		 */
		public override function get href():String { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		public override function set href( value:String ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		
		
		
		
		
		/**
		 * <span lang="ja">新しい RollOverButton インスタンスを作成します。</span>
		 * <span lang="en">Creates a new RollOverButton object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function RollOverButton( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
		}
	}
}
