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
package jp.progression.commands {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Wait クラスは、指定された時間だけ処理を停止させるコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // Wait コマンドを作成します。
	 * var com:Wait = new Wait( 1000 );
	 * 
	 * // Wait コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class Wait extends Command {
		
		/*======================================================================*//**
		 * <p>処理を停止させたい時間をミリ秒で取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get time():int { return _time; }
		public function set time( value:int ):void {
			_time = Math.max( 0, value );
			
			// タイムアウトを再設定する
			timeOut = Math.max( timeOut, _time + 5000 );
		}
		private var _time:int = 0;
		
		/*======================================================================*//**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Wait インスタンスを作成します。</p>
		 * <p>Creates a new Wait object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param time
		 * 	<p>処理を停止させたい時間のミリ秒です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Wait( time:int = 0, initObject:Object = null ) {
			// 引数を設定する
			this.time = time;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// 初期化する
			timeOut = initObject ? initObject.timeOut : 0;
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>Wait インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Wait subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Wait インスタンスです。</p>
		 * 	<p>A new Wait object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Wait( _time, this );
		}
		
		
		
		
		
		/*======================================================================*//**
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









