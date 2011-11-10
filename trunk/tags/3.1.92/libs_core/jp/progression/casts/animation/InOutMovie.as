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
package jp.progression.casts.animation {
	import jp.progression.commands.display.DoTweenFrame;
	import jp.progression.core.casts.animation.AnimationBase;
	import jp.progression.events.CastEvent;
	
	/**
	 * <span lang="ja">InOutMovie クラスは、表示リストへの追加・削除の状態に応じたタイムラインアニメーションを再生させるアニメーションコンポーネントクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class InOutMovie extends AnimationBase {
		
		/**
		 * <span lang="ja">CastEvent.CAST_ADDED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get inStateFrames():Array { return _inStateFrames; }
		public function set inStateFrames( value:Array ):void { _inStateFrames = value; }
		private var _inStateFrames:Array = [ "in", "stop" ];
		
		/**
		 * <span lang="ja">CastEvent.CAST_REMOVED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get outStateFrames():Array { return _outStateFrames; }
		public function set outStateFrames( value:Array ):void { _outStateFrames = value; }
		private var _outStateFrames:Array = [ "stop", "out" ];
		
		
		
		
		
		/**
		 * <span lang="ja">新しい InOutMovie インスタンスを作成します。</span>
		 * <span lang="en">Creates a new InOutMovie object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function InOutMovie( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CastEvent.CAST_ADDED, _castAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			var frames:Array = _inStateFrames;
			
			// コマンドを追加する
			addCommand(
				function():void {
					// 移動する
					target.gotoAndStop( frames[0] );
				}
			);
			
			// アニメーションを追加する
			var l:int = frames.length;
			for ( var i:int = 1; i < l; i++ ) {
				// コマンドを追加する
				addCommand(
					new DoTweenFrame( target, frames[i - 1], frames[i] )
				);
			}
		}
		
		/**
		 * ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			var frames:Array = _outStateFrames;
			
			// コマンドを追加する
			addCommand(
				function():void {
					// 移動する
					target.gotoAndStop( frames[0] );
				}
			);
			
			// アニメーションを追加する
			var l:int = frames.length;
			for ( var i:int = 1; i < l; i++ ) {
				// コマンドを追加する
				addCommand(
					new DoTweenFrame( target, frames[i - 1], frames[i] )
				);
			}
		}
	}
}
