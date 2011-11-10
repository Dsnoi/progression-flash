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
package jp.progression.core.components.buttons {
	import jp.progression.casts.buttons.RollOverButton;
	import jp.progression.core.components.buttons.ButtonComp;
	
	[IconFile( "RollOverButton.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class RollOverButtonComp extends ButtonComp {
		
		/*======================================================================*//**
		 * <p>ボタンがクリックされた時の移動先を示すシーンパスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="navigatePath", type="String", defaultValue="" )]
		public function get navigatePath():String { return RollOverButton( component ).navigatePath; }
		public function set navigatePath( value:String ):void { RollOverButton( component ).navigatePath = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function RollOverButtonComp() {
			// スーパークラスを初期化する
			super( new RollOverButton() );
		}
	}
}









