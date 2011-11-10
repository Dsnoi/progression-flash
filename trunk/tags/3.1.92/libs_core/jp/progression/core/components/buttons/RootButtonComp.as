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
	import jp.progression.casts.buttons.RootButton;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.buttons.ButtonComp;
	import jp.progression.core.events.CollectionEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	[IconFile( "RootButton.png" )]
	/**
	 * @private
	 */
	public class RootButtonComp extends ButtonComp {
		
		/**
		 * <span lang="ja">関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="progressionId", type="String", defaultValue="", verbose="1" )]
		public function get progressionId():String { return RootButton( component ).progressionId; }
		public function set progressionId( value:String ):void { RootButton( component ).progressionId = value || _progressionId; }
		private var _progressionId:String;
		
		
		
		
		
		/**
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
		
		
		
		
		
		/**
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
