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
package jp.progression.core.components.buttons {
	import jp.progression.casts.buttons.AnchorButton;
	import jp.progression.core.components.buttons.ButtonComp;
	
	[IconFile( "AnchorButton.png" )]
	/**
	 * @private
	 */
	public class AnchorButtonComp extends ButtonComp {
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先の URL を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="href", type="String", defaultValue="" )]
		public function get href():String { return AnchorButton( component ).href; }
		public function set href( value:String ):void { AnchorButton( component ).href = value; }
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先を開くウィンドウ名を取得または設定します。
		 * この値が "_self" または null に設定されている場合には、現在のウィンドウを示します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="windowTarget", type="String", defaultValue="_blank" )]
		public function get windowTarget():String { return AnchorButton( component ).windowTarget; }
		public function set windowTarget( value:String ):void { AnchorButton( component ).windowTarget = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function AnchorButtonComp() {
			// スーパークラスを初期化する
			super( new AnchorButton() );
		}
	}
}
