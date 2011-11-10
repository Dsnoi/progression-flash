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
package jp.progression.casts.buttons {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.buttons.ButtonBase;
	import jp.progression.scenes.SceneId;
	
	/*======================================================================*//**
	 * <p>RollOverButton クラスは、ポインティングデバイスの状態に応じたタイムラインアニメーションを再生させるボタンコンポーネントクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class RollOverButton extends ButtonBase {
		
		/*======================================================================*//**
		 * <p>ボタンがクリックされた時の移動先を示すシーンパスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get navigatePath():String { return _navigatePath; }
		public function set navigatePath( value:String ):void {
			_navigatePath = value;
			
			// 値を設定する
			super.sceneId = new SceneId( value );
		}
		private var _navigatePath:String;
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get sceneId():SceneId { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		public override function set sceneId( value:SceneId ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get href():String { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		public override function set href( value:String ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい RollOverButton インスタンスを作成します。</p>
		 * <p>Creates a new RollOverButton object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function RollOverButton( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
		}
	}
}









