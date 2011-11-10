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
	import jp.progression.casts.buttons.AnchorButton;
	import jp.progression.core.components.buttons.ButtonComp;
	
	[IconFile( "AnchorButton.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class AnchorButtonComp extends ButtonComp {
		
		/*======================================================================*//**
		 * <p>ボタンがクリックされた時の移動先の URL を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="href", type="String", defaultValue="" )]
		public function get href():String { return AnchorButton( component ).href; }
		public function set href( value:String ):void { AnchorButton( component ).href = value; }
		
		/*======================================================================*//**
		 * <p>ボタンがクリックされた時の移動先を開くウィンドウ名を取得または設定します。
		 * この値が "_self" または null に設定されている場合には、現在のウィンドウを示します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="windowTarget", type="String", defaultValue="_blank" )]
		public function get windowTarget():String { return AnchorButton( component ).windowTarget; }
		public function set windowTarget( value:String ):void { AnchorButton( component ).windowTarget = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function AnchorButtonComp() {
			// スーパークラスを初期化する
			super( new AnchorButton() );
		}
	}
}









