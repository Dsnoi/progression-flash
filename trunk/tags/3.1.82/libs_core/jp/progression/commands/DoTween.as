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
package jp.progression.commands {
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import jp.nium.events.EventAggregater;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">DoTweener クラスは、fl.transitions パッケージのイージング機能を実行するコマンドクラスです。</span>
	 * <span lang="en"></span>
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
		
		/**
		 * <span lang="ja">イージング処理を行いたい対象のオブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/**
		 * <span lang="ja">イージング処理を行いたいプロパティを含んだオブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get props():Object { return _props; }
		public function set props( value:Object ):void { _props = value; }
		private var _props:Object;
		
		/**
		 * <span lang="ja">イージング処理を行う関数を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function;
		
		/**
		 * <span lang="ja">イージング処理の継続時間です。負の数、または省略されている場合、infinity に設定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get duration():Number { return _duration; }
		public function set duration( value:Number ):void { _duration = value; }
		private var _duration:Number;
		
		/**
		 * Tween インスタンスを配列で取得します。
		 */
		private var _tweens:Array = [];
		
		/**
		 * EventAggregater インスタンスを取得します。 
		 */
		private var _aggregater:EventAggregater;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DoTween インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DoTween object.</span>
		 * 
		 * @param target
		 * <span lang="ja">Tween のターゲットになるオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param props
		 * <span lang="ja">影響を受ける (target パラメータ値) のプロパティの名前と値を格納した Object インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param easing
		 * <span lang="ja">使用するイージング関数の名前です。</span>
		 * <span lang="en"></span>
		 * @param duration
		 * <span lang="ja">モーションの継続時間です。負の数、または省略されている場合、infinity に設定されます。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function DoTween( target:Object, props:Object, easing:Function, duration:Number, initObject:Object = null ) {
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
		
		
		
		
		
		/**
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
		
		/**
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
		
		/**
		 * <span lang="ja">DoTween インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DoTween subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DoTween インスタンスです。</span>
		 * <span lang="en">A new DoTween object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new DoTween( _target, _props, _easing, _duration, this );
		}
		
		
		
		
		
		/**
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
