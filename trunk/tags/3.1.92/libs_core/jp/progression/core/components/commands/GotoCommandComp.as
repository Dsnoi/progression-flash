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
package jp.progression.core.components.commands {
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.commands.CommandComp;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	[IconFile( "GotoCommand.png" )]
	/**
	 * @private
	 */
	public class GotoCommandComp extends CommandComp {
		
		/**
		 * <span lang="ja">移動先を示すシーンパスを取得または設定します。</span>
		 * <span lang="en"></span>
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
		
		
		
		
		
		/**
		 * @private
		 */
		public function GotoCommandComp() {
		}
	}
}
