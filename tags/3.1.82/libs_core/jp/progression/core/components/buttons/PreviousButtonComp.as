/**
 * Progression 3
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 3.1.82
 * @see http://progression.jp/
 * 
 * Progression IDE is released under the Progression License:
 * http://progression.jp/en/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.core.components.buttons {
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.casts.buttons.PreviousButton;
	import jp.progression.core.events.CollectionEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	[IconFile( "PreviousButton.png" )]
	/**
	 * @private
	 */
	public class PreviousButtonComp extends ButtonComp {
		
		/**
		 * <span lang="ja">関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="progressionId", type="String", defaultValue="", verbose="1" )]
		public function get progressionId():String { return PreviousButton( component ).progressionId; }
		public function set progressionId( value:String ):void { PreviousButton( component ).progressionId = value || _progressionId; }
		private var _progressionId:String;
		
		/**
		 * <span lang="ja">同階層で前のシーンが存在しない場合に、一番後方のシーンに移動するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="useTurnBack", type="Boolean", defaultValue="false", verbose="1" )]
		public function get useTurnBack():Boolean { return PreviousButton( component ).useTurnBack; }
		public function set useTurnBack( value:Boolean ):void { PreviousButton( component ).useTurnBack = value; }
		
		/**
		 * <span lang="ja">キーボードの左矢印キーを押した際にボタンを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="useLeftKey", type="Boolean", defaultValue="true" )]
		public function get useLeftKey():Boolean { return PreviousButton( component ).useLeftKey; }
		public function set useLeftKey( value:Boolean ):void { PreviousButton( component ).useLeftKey = value; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function PreviousButtonComp() {
			// スーパークラスを初期化する
			super( new PreviousButton() );
			
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
