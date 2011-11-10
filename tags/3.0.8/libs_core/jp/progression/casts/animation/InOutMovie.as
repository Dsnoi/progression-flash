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
package jp.progression.casts.animation {
	import caurina.transitions.Equations;
	import caurina.transitions.properties.DisplayShortcuts;
	import jp.nium.utils.MovieClipUtil;
	import jp.progression.commands.DoTweener;
	import jp.progression.core.casts.animation.AnimationBase;
	import jp.progression.events.CastEvent;
	
	/*======================================================================*//**
	 * <p>InOutMovie クラスは、表示リストへの追加・削除の状態に応じたタイムラインアニメーションを再生させるアニメーションコンポーネントクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class InOutMovie extends AnimationBase {
		
		/*======================================================================*//**
		 * <p>CastEvent.CAST_ADDED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get inStateFrames():Array { return _inStateFrames; }
		public function set inStateFrames( value:Array ):void { _inStateFrames = value; }
		private var _inStateFrames:Array = [ "in", "stop" ];
		
		/*======================================================================*//**
		 * <p>CastEvent.CAST_REMOVED イベントが送出された場合の表示アニメーションを示すフレームラベル及びフレーム番号を格納した配列を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get outStateFrames():Array { return _outStateFrames; }
		public function set outStateFrames( value:Array ):void { _outStateFrames = value; }
		private var _outStateFrames:Array = [ "stop", "out" ];
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい InOutMovie インスタンスを作成します。</p>
		 * <p>Creates a new InOutMovie object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function InOutMovie( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// DisplayShortcuts を初期化する
			DisplayShortcuts.init();
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CastEvent.CAST_ADDED, _castAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
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
					new DoTweener( target, {
						_frame		:frames[i],
						time		:MovieClipUtil.getMarginFrames( target, frames[i - 1], frames[i] ),
						useFrames	:true,
						transition	:Equations.easeNone
					} )
				);
			}
		}
		
		/*======================================================================*//**
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
					new DoTweener( target, {
						_frame		:frames[i],
						time		:MovieClipUtil.getMarginFrames( target, frames[i - 1], frames[i] ),
						useFrames	:true,
						transition	:Equations.easeNone
					} )
				);
			}
		}
	}
}









