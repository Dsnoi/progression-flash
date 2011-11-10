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
package jp.progression.core.casts.buttons {
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastButton;
	import jp.progression.commands.display.DoTweenFrame;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CastMouseEvent;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public class ButtonBase extends CastButton {
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_UP_STATE_FRAME:String = "up";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_OVER_STATE_FRAME:String = "over";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_DOWN_STATE_FRAME:String = "down";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_CURRENT_STATE_FRAME:String = "current";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_DISABLE_STATE_FRAME:String = "disable";
		
		
		
		
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_MOUSE_UP イベント、または CastMouseEvent.CAST_ROLL_OUT イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get upStateFrame():* { return _upStateFrame; }
		public function set upStateFrame( value:* ):void { _upStateFrame = value || DEFAULT_UP_STATE_FRAME; }
		private var _upStateFrame:* = DEFAULT_UP_STATE_FRAME;
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_ROLL_OVER イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get overStateFrame():* { return _overStateFrame; }
		public function set overStateFrame( value:* ):void { _overStateFrame = value || DEFAULT_OVER_STATE_FRAME; }
		private var _overStateFrame:* = DEFAULT_OVER_STATE_FRAME;
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_MOUSE_DOWN イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get downStateFrame():* { return _downStateFrame; }
		public function set downStateFrame( value:* ):void { _downStateFrame = value || DEFAULT_DOWN_STATE_FRAME; }
		private var _downStateFrame:* = DEFAULT_DOWN_STATE_FRAME;
		
		/**
		 * <span lang="ja">ボタンに設定されている移動先が、関連付けられている Progression インスタンスのカレントシーンと同様であった場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get currentStateFrame():* { return _currentStateFrame; }
		public function set currentStateFrame( value:* ):void { _currentStateFrame = value || DEFAULT_CURRENT_STATE_FRAME; }
		private var _currentStateFrame:* = DEFAULT_CURRENT_STATE_FRAME;
		
		/**
		 * <span lang="ja">ボタンが無効化されている場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get disableStateFrame():* { return _disableStateFrame; }
		public function set disableStateFrame( value:* ):void { _disableStateFrame = value || DEFAULT_DISABLE_STATE_FRAME; }
		private var _disableStateFrame:* = DEFAULT_DISABLE_STATE_FRAME;
		
		/**
		 * @private
		 */
		protected function get target():MovieClip { return _target; }
		
		/**
		 * @private
		 */
		progression_internal function get __target():MovieClip { return _target; }
		progression_internal function set __target( value:MovieClip ):void { _target = value || this; }
		private var _target:MovieClip;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ButtonBase インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ButtonBase object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function ButtonBase( initObject:Object = null ) {
			// 初期化する
			_target = this;
			
			// 再生を停止する
			_target.stop();
			
			// スーパークラスを初期化する
			super( initObject );
			
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CastButton ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ButtonBase" ) ); }
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CastEvent.BUTTON_ENABLED_CHANGE, _buttonEnabledChange, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut, false, int.MAX_VALUE, true );
			
			// ボタンが有効化されていれば
			if ( buttonEnabled ) {
				addExclusivelyEventListener( CastEvent.UPDATE, _updateAndStatusChange, false, int.MAX_VALUE, true );
				addExclusivelyEventListener( CastEvent.STATUS_CHANGE, _updateAndStatusChange, false, int.MAX_VALUE, true );
			}
		}
		
		
		
		
		
		/**
		 * ボタンの表示状態を更新します。
		 */
		private function _updateAndStatusChange( e:CastEvent ):void {
			// 表示を更新する
			_target.gotoAndStop( isCurrent ? _currentStateFrame : ( isRollOver ? _overStateFrame : _upStateFrame ) );
		}
		
		/**
		 * オブジェクトの buttonEnabled プロパティの値が変更されたときに送出されます。
		 */
		private function _buttonEnabledChange( e:CastEvent ):void {
			if ( buttonEnabled ) {
				_target.gotoAndStop( isCurrent ? _currentStateFrame : ( isRollOver ? _overStateFrame : _upStateFrame ) );
				addExclusivelyEventListener( CastEvent.UPDATE, _updateAndStatusChange, false, int.MAX_VALUE, true );
				addExclusivelyEventListener( CastEvent.STATUS_CHANGE, _updateAndStatusChange, false, int.MAX_VALUE, true );
			}
			else {
				_target.gotoAndStop( _disableStateFrame );
				completelyRemoveEventListener( CastEvent.UPDATE, _updateAndStatusChange );
				completelyRemoveEventListener( CastEvent.STATUS_CHANGE, _updateAndStatusChange );
			}
		}
		
		/**
		 * Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _castMouseDown( e:CastMouseEvent ):void {
			// 移動先を取得する
			var frame:* = isCurrent ? _currentStateFrame : _downStateFrame;
			
			// コマンドを追加する
			addCommand(
				new DoTweenFrame( _target, _target.currentFrame, frame )
			);
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castMouseUp( e:CastMouseEvent ):void {
			// 移動先を取得する
			var frame:* = isCurrent ? _currentStateFrame : ( isRollOver ? _overStateFrame : _upStateFrame );
			
			// コマンドを追加する
			addCommand(
				new DoTweenFrame( _target, _target.currentFrame, frame )
			);
		}
		
		/**
		 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _castRollOver( e:CastMouseEvent ):void {
			// 移動先を取得する
			var frame:* = isCurrent ? _currentStateFrame : _overStateFrame;
			
			// コマンドを追加する
			addCommand(
				new DoTweenFrame( _target, _target.currentFrame, frame )
			);
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castRollOut( e:CastMouseEvent ):void {
			// 移動先を取得する
			var frame:* = isCurrent ? _currentStateFrame : ( isMouseDown ? _downStateFrame : _upStateFrame );
			
			// コマンドを追加する
			addCommand(
				new DoTweenFrame( _target, _target.currentFrame, frame )
			);
		}
	}
}
