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
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import jp.nium.events.EventAggregater;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>DoTweener クラスは、fl.transitions パッケージのイージング機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // MovieClip インスタンスを作成する
	 * var mc:MovieClip = new MovieClip();
	 * 
	 * // DoTween コマンドを作成します。
	 * var com:DoTween = new DoTween( mc, {
	 * 	// ( 100, 100 ) の座標に移動します。
	 * 	x			:100,
	 * 	y			:100
	 * }, Strong.easeInOut, 1000 );
	 * 
	 * // DoTween コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class DoTween extends Command {
		
		/*======================================================================*//**
		 * <p>イージング処理を行いたい対象のオブジェクトを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/*======================================================================*//**
		 * <p>イージング処理を行いたいプロパティを含んだオブジェクトを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get props():Object { return _props; }
		public function set props( value:Object ):void { _props = value; }
		private var _props:Object;
		
		/*======================================================================*//**
		 * <p>イージング処理を行う関数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function;
		
		/*======================================================================*//**
		 * <p>イージング処理の継続時間です。負の数、または省略されている場合、infinity に設定されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get duration():int { return _duration; }
		public function set duration( value:int ):void {
			_duration = value;
			
			// タイムアウトを再設定する
			timeOut = Math.max( timeOut, _duration + 5000 );
		}
		private var _duration:int;
		
		/*======================================================================*//**
		 * Tween インスタンスを配列で取得します。
		 */
		private var _tweens:Array = [];
		
		/*======================================================================*//**
		 * EventAggregater インスタンスを取得します。 
		 */
		private var _aggregater:EventAggregater;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい DoTween インスタンスを作成します。</p>
		 * <p>Creates a new DoTween object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>Tween のターゲットになるオブジェクトです。</p>
		 * 	<p></p>
		 * @param props
		 * 	<p>影響を受ける (target パラメータ値) のプロパティの名前と値を格納した Object インスタンスです。</p>
		 * 	<p></p>
		 * @param easing
		 * 	<p>使用するイージング関数の名前です。</p>
		 * 	<p></p>
		 * @param duration
		 * 	<p>モーションの継続時間です。負の数、または省略されている場合、infinity に設定されます。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function DoTween( target:Object = null, props:Object = null, easing:Function = null, duration:int = 0, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_props = props;
			_easing = easing;
			_duration = duration;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// EventAggregater を作成する
			_aggregater = new EventAggregater();
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 初期化する
			_tweens = [];
			_aggregater.removeAllEventDispatcher();
			_aggregater.reset();
			_aggregater.addExclusivelyEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			
			// Tween を作成する
			for ( var p:String in _props ) {
				// プロパティが存在していなければ次へ
				if ( !( p in _target ) ) { continue; }
				
				// Tween を作成する
				var tween:Tween = new Tween( _target, p, _easing, _target[p], _props[p], _duration / 1000, true );
				_aggregater.addEventDispatcher( tween, TweenEvent.MOTION_FINISH );
				_tweens.push( tween );
			}
			
			// 登録されていなければ終了する
			if ( _tweens.length == 0 ) {
				// 処理を終了する
				executeComplete();
				return;
			}
			
			// Tween を実行する
			var l:int = _tweens.length;
			for ( var i:int = 0; i < l; i++ ) {
				Tween( _tweens[i] ).start();
			}
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// イベントリスナーを解除する
			_aggregater.removeAllEventDispatcher();
			
			// Tween を解除する
			var l:int = _tweens.length;
			for ( var i:int = 0; i < l; i++ ) {
				var tween:Tween = Tween( _tweens[i] );
				tween.stop();
				_aggregater.removeEventDispatcher( tween, TweenEvent.MOTION_FINISH );
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>DoTween インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTween subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい DoTween インスタンスです。</p>
		 * 	<p>A new DoTween object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTween( _target, _props, _easing, _duration, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 登録された全てのイベントが発生した際に送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_aggregater.completelyRemoveEventListener( Event.COMPLETE, _complete );
			
			// 処理を終了する
			executeComplete();
		}
	}
}









