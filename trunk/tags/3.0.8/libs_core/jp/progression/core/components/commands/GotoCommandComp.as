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
package jp.progression.core.components.commands {
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.commands.CommandComp;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	[IconFile( "GotoCommand.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class GotoCommandComp extends CommandComp {
		
		/*======================================================================*//**
		 * <p>移動先を示すシーンパスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="scenePath", type="String", defaultValue="" )]
		public function set scenePath( value:String ):void {
			// 書式が正しくなければ終了する
			if ( !SceneId.validate( value ) ) { return; }
			
			// シーン識別子に変換する
			var sceneId:SceneId = new SceneId( value );
			
			// 関連付けられた Progression インスタンスを取得する
			var progression:Progression = ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
			
			// 存在すれば移動する
			if ( progression ) {
				progression.goto( sceneId );
			}
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function GotoCommandComp() {
		}
	}
}









