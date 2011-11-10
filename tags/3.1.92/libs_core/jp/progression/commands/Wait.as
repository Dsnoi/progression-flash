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
package jp.progression.commands {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Wait クラスは、指定された時間だけ処理を停止させるコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // Wait コマンドを作成します。
	 * var com:Wait = new Wait( 1000 );
	 * 
	 * // Wait コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class Wait extends Command {
		
		/**
		 * <span lang="ja">処理を停止させたい時間をミリ秒で取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get time():int { return _time; }
		public function set time( value:int ):void { _time = Math.max( 0, value ); }
		private var _time:int = 0;
		
		/**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Wait インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Wait object.</span>
		 * 
		 * @param time
		 * <span lang="ja">処理を停止させたい時間のミリ秒です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Wait( time:int, initObject:Object = null ) {
			// 引数を設定する
			this.time = time;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 遅延時間が 0 であれば終了する
			if ( _time == 0 ) {
				// 処理を終了する
				executeComplete();
				return;
			}
			
			// Timer を作成する
			_timer = new Timer( _time, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete, false, int.MAX_VALUE, true );
			
			// Timer を開始する
			_timer.start();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 存在すれば
			if ( _timer ) {
				// イベントリスナーを解除する
				_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
				
				// Timer を破棄する
				_timer = null;
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">Wait インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Wait subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Wait インスタンスです。</span>
		 * <span lang="en">A new Wait object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Wait( _time, this );
		}
		
		
		
		
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 * */
		private function _timerComplete( e:TimerEvent ):void {
			// イベントリスナーを解除する
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete );
			
			// Timer を破棄する
			_timer = null;
			
			// 処理を終了する
			executeComplete();
		}
	}
}
