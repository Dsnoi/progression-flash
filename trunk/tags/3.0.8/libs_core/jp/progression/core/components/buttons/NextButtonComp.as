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
	import jp.progression.casts.buttons.NextButton;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.components.buttons.ButtonComp;
	import jp.progression.core.events.CollectionEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	
	use namespace progression_internal;
	
	[IconFile( "NextButton.png" )]
	/*======================================================================*//**
	 * @private
	 */
	public class NextButtonComp extends ButtonComp {
		
		/*======================================================================*//**
		 * <p>関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="progressionId", type="String", defaultValue="", verbose="1" )]
		public function get progressionId():String { return NextButton( component ).progressionId; }
		public function set progressionId( value:String ):void { NextButton( component ).progressionId = value || _progressionId; }
		private var _progressionId:String;
		
		/*======================================================================*//**
		 * <p>同階層で次のシーンが存在しない場合に、一番先頭のシーンに移動するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="useTurnBack", type="Boolean", defaultValue="false", verbose="1" )]
		public function get useTurnBack():Boolean { return NextButton( component ).useTurnBack; }
		public function set useTurnBack( value:Boolean ):void { NextButton( component ).useTurnBack = value; }
		
		/*======================================================================*//**
		 * <p>キーボードの右矢印キーを押した際にボタンを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="useRightKey", type="Boolean", defaultValue="true" )]
		public function get useRightKey():Boolean { return NextButton( component ).useRightKey; }
		public function set useRightKey( value:Boolean ):void { NextButton( component ).useRightKey = value; }
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function NextButtonComp() {
			// スーパークラスを初期化する
			super( new NextButton() );
			
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









