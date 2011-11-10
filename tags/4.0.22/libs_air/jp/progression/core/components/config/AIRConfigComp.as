/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 4.0.22
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core.components.config {
	import jp.nium.core.debug.Logger;
	import jp.progression.config.AIRConfig;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.PackageInfo;
	import jp.progression.Progression;
	
	[IconFile( "Progression Config.png" )]
	/**
	 * @private
	 */
	public class AIRConfigComp extends ConfigComp {
		
		[Inspectable( name="activatedLicenseType", type="List", enumeration="PLL Basic,PLL Application,GPL", defaultValue="PLL Basic" )]
		/**
		 * <span lang="ja">適用させたいライセンスの種類を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		override public function get activatedLicenseType():String { return super.activatedLicenseType; }
		override public function set activatedLicenseType( value:String ):void { super.activatedLicenseType = value; }
		
		
		
		
		
		/**
		 * 初期化する
		 */
		( function():void {
			// Progression を初期化する
			if ( Progression.initialize( new AIRConfig() ) ) { return; }
			
			// Progression がすでに初期化されていれば
			if ( Progression.config is AIRConfig ) { return; }
			
			// 警告を表示する
			Logger.error( Logger.getLog( L10NProgressionMsg.getInstance().ERROR_008 ).toString( "AIRConfig" ) );
		} )();
		
		
		
		
		
		/**
		 * <span lang="ja">新しい AIRConfigComp インスタンスを作成します。</span>
		 * <span lang="en">Creates a new AIRConfigComp object.</span>
		 */
		public function AIRConfigComp() {
		}
	}
}
