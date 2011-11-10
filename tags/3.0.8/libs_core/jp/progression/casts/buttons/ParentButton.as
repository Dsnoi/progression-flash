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
package jp.progression.casts.buttons {
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.buttons.ButtonBase;
	import jp.progression.events.CastEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/*======================================================================*//**
	 * <p>ParentButton クラスは、ポインティングデバイスの状態に応じたタイムラインアニメーションを再生させるボタンコンポーネントクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ParentButton extends ButtonBase {
		
		/*======================================================================*//**
		 * <p>関連付けたい Progression インスタンスの id プロパティを示すストリングを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get progressionId():String { return _progressionId; }
		public function set progressionId( value:String ):void {
			_progressionId = value;
			
			// 値を設定する
			super.sceneId = value ? new SceneId( "/" + value ) : null;
		}
		private var _progressionId:String;
		
		/*======================================================================*//**
		 * <p>キーボードの上矢印キーを押した際にボタンを有効化するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get useTopKey():Boolean { return _useTopKey; }
		public function set useTopKey( value:Boolean ):void { _useTopKey = value; }
		private var _useTopKey:Boolean = true;
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get sceneId():SceneId { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		public override function set sceneId( value:SceneId ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "sceneId" ) ); }
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get href():String { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		public override function set href( value:String ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "href" ) ); }
		
		/*======================================================================*//**
		 * Progression インスタンスを取得します。
		 */
		private var _progression:Progression;
		
		/*======================================================================*//**
		 * Stage インスタンスを取得します。 
		 */
		private var _stage:Stage;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ParentButton インスタンスを作成します。</p>
		 * <p>Creates a new ParentButton object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function ParentButton( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastEvent.UPDATE, _update, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// stage の参照を保存する
			_stage = stage;
			
			// イベントリスナーを登録する
			_stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp, false, int.MAX_VALUE, true );
		}
		
		/*======================================================================*//**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( KeyboardEvent.KEY_UP, _keyUp );
			
			// stage の参照を破棄する
			_stage = null;
		}
		
		/*======================================================================*//**
		 * CastButton インスタンスと Progression インスタンスとの関連付けが更新されたときに送出されます。
		 */
		private function _update( e:CastEvent ):void {
			// 存在していれば、イベントリスナーを解除する
			if ( _progression ) {
				_progression.completelyRemoveEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			}
			
			// progression を設定する
			_progression = progression;
			
			// 存在していれば、イベントリスナーを登録する
			if ( _progression ) {
				_progression.addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, int.MAX_VALUE, true );
				_processScene( new ProcessEvent( ProcessEvent.PROCESS_SCENE, false, false, _progression.current, _progression.eventType ) );
			}
		}
		
		/*======================================================================*//**
		 * シーン移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			var current:SceneObject = e.scene;
			
			// 存在しなければ
			if ( !current ) {
				buttonEnabled = false;
				return;
			}
			
			var parent:SceneObject = current.parent || current;
			
			// 移動先を指定する
			super.sceneId = parent.sceneId.clone();
			
			// 次のシーンが現在のシーンと同じであれば無効化する
			buttonEnabled = !( parent == current );
		}
		
		/*======================================================================*//**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			switch ( true ) {
				case !_useTopKey		:
				case e.shiftKey			:
				case e.ctrlKey			:
				case e.keyCode != 38	: { return; }
				default					: {
					// 移動する
					navigateTo();
				}
			}
		}
	}
}









