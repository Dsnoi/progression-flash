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
	import jp.progression.casts.buttons.RootButton;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.buttons.ButtonComp;
	import jp.progression.core.events.CollectionEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	[IconFile( "RootButton.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class RootButtonComp extends ButtonComp {
		
		/*======================================================================*//**
		 * <p>関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="progressionId", type="String", defaultValue="", verbose="1" )]
		public function get progressionId():String { return RootButton( component ).progressionId; }
		public function set progressionId( value:String ):void { RootButton( component ).progressionId = value || _progressionId; }
		private var _progressionId:String;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function RootButtonComp() {
			// スーパークラスを初期化する
			super( new RootButton() );
			
			// Progression インスタンスを取得する
			var progs:Array = ProgressionCollection.progression_internal::__getInstancesByRegExp( "id", new RegExp( ".*" ) );
			
			// 存在していれば
			if ( progs.length ) {
				// progressionId を設定する
				progressionId ||= _progressionId = Progression( progs[0] ).id;
			}
			else {
				// イベントリスナーを登録する
				ProgressionCollection.addExclusivelyEventListener( CollectionEvent.COLLECTION_UPDATE, _collectionUpdate, false, int.MAX_VALUE, true );
			}
		}
		
		
		
		
		
		/*======================================================================*//**
		 * Progression インスタンスがコレクションに登録された場合に送出されます。
		 */
		private function _collectionUpdate( e:CollectionEvent ):void {
			// イベントリスナーを解除する
			ProgressionCollection.completelyRemoveEventListener( CollectionEvent.COLLECTION_UPDATE, _collectionUpdate );
			
			// progressionId を設定する
			progressionId ||= _progressionId = Progression( e.relatedTarget ).id;
		}
	}
}









