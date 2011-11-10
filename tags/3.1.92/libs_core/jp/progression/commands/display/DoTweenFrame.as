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
package jp.progression.commands.display {
	import flash.display.MovieClip;
	import flash.events.Event;
	import jp.nium.utils.MovieClipUtil;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja"></span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // 表示コンテナとなる MovieClip インスタンスを作成します。
	 * var mc:MovieClip = new MovieClip();
	 * 
	 * // 複数のコマンドを連続で実行するコマンドリストを作成します。
	 * var com:SerialList = new SerialList( null,
	 * 	// mc をフレーム 1 からフレーム 10 までアニメーションさせます。
	 * 	new DoTweenerFrame( mc, 1, 10 ),
	 * 	// mc をラベル start からラベル end までアニメーションさせます。
	 * 	new DoTweenerFrame( mc, "start", "end" )
	 * );
	 * 
	 * // コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class DoTweenFrame extends Command {
		
		/**
		 * <span lang="ja">アニメーション処理を行いたい対象の MovieClip インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():MovieClip { return _target; }
		public function set target( value:MovieClip ):void { _target = value; }
		private var _target:MovieClip;
		
		/**
		 * <span lang="ja">アニメーションを開始するフレーム番号、またはフレームラベル名を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get startFrame():* { return _startFrame; }
		public function set startFrame( value:* ):void { _target = value; }
		private var _startFrame:*;
		
		/**
		 * アニメーションを開始するフレーム番号を取得します。
		 */
		private var _startFrameNum:int = 1;
		
		/**
		 * <span lang="ja">アニメーションを終了するフレーム番号もしくはフレームラベル名を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get endFrame():* { return _endFrame; }
		public function set endFrame( value:* ):void { _endFrame = value; }
		private var _endFrame:*;
		
		/**
		 * アニメーションを終了するフレーム番号を取得します。
		 */
		private var _endFrameNum:int = 1;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DoTweenFrame インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DoTweenFrame object.</span>
		 * 
		 * @param target
		 * <span lang="ja">アニメーション処理を行いたい対象の MovieClip インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param startFrame
		 * <span lang="ja">アニメーションを開始するフレーム番号、またはフレームラベル名です。</span>
		 * <span lang="en"></span>
		 * @param endFrame
		 * <span lang="ja">アニメーションを終了するフレーム番号もしくはフレームラベル名です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function DoTweenFrame( target:MovieClip, startFrame:*, endFrame:*, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_startFrame = startFrame;
			_endFrame = endFrame;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// フレームが存在しなければ
			if ( !MovieClipUtil.hasFrame( _target, _startFrame ) || !MovieClipUtil.hasFrame( _target, _endFrame ) ) {
				// 処理を終了する
				executeComplete();
				return;
			}
			
			// 移動先のフレーム番号を取得する
			_startFrameNum = ( _startFrame is Number ) ? _startFrame : MovieClipUtil.labelToFrames( _target, _startFrame )[0];
			_endFrameNum = ( _endFrame is Number ) ? _endFrame : MovieClipUtil.labelToFrames( _target, _endFrame )[0];
			
			// 現在位置が範囲内に存在しなければ
			if ( !MovieClipUtil.playheadWithinFrames( _target, _startFrameNum, _endFrameNum ) ) {
				// 開始フレームに移動する
				_target.gotoAndStop( _startFrameNum );
			}
			
			// イベントリスナーを登録する
			_target.addEventListener( Event.ENTER_FRAME, _enterFrame, false, 0, true );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// イベントリスナーを解除する
			_target.removeEventListener( Event.ENTER_FRAME, _enterFrame );
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">DoTweenFrame インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DoTweenFrame subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DoTweenFrame インスタンスです。</span>
		 * <span lang="en">A new DoTweenFrame object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new DoTweenFrame( target, startFrame, endFrame, this );
		}
		
		
		
		
		
		/**
		 */
		private function _enterFrame( e:Event ):void {
			// 現在地が終了位置だった場合
			if ( _target.currentFrame == _endFrameNum ) {
				// イベントリスナーを解除する
				_target.removeEventListener( Event.ENTER_FRAME, _enterFrame );
				
				// 処理を終了する
				executeComplete();
				return;
			}
			
			// 現在地が終了地より手前の場合
			if ( _target.currentFrame < _endFrameNum ) {
				_target.nextFrame();
			}
			else {
				_target.prevFrame();
			}
		}
	}
}
