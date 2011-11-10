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
	import fl.transitions.Transition;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import jp.nium.api.transition.TransitionEvent;
	import jp.nium.api.transition.TransitionHelper;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">DoTransition クラスは、fl.transitions パッケージのトランジション機能を実行するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // MovieClip インスタンスを作成する
	 * var mc:MovieClip = new MovieClip();
	 * 
	 * // DoTransition コマンドを作成します。
	 * var com:DoTransition = new DoTransition( mc, Fade, Transition.IN, 1000, Strong.easeInOut, {
	 * 	// ( 100, 100 ) の座標に移動します。
	 * 	x			:100,
	 * 	y			:100
	 * } );
	 * 
	 * // DoTransition コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class DoTransition extends Command {
		
		/**
		 * <span lang="ja">トランジション効果を適用する対象の MovieClip オブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():MovieClip { return _target; }
		public function set target( value:MovieClip ):void { _target = value; }
		private var _target:MovieClip;
		
		/**
		 * <span lang="ja">Tween インスタンスに適用する Transition を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get type():Class { return _type; }
		public function set type( value:Class ):void { _type = value; }
		private var _type:Class;
		
		/**
		 * <span lang="ja">Tween インスタンスのイージングの方向を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get direction():int { return _direction; }
		public function set direction( value:int ):void {
			switch ( value ) {
				case Transition.IN		:
				case Transition.OUT		: { _direction = value; break; }
				default					: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "direction" ) ); }
			}
		}
		private var _direction:int;
		
		/**
		 * <span lang="ja">Tween インスタンスの継続時間を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get duration():Number { return _duration; }
		public function set duration( value:Number ):void { _duration = Math.max( 0, value ); }
		private var _duration:Number = Transition.IN;
		
		/**
		 * <span lang="ja">アニメーションのトゥイーン効果を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function;
		
		/**
		 * <span lang="ja">カスタムトゥイーンパラメータを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object;
		
		/**
		 * TransitionHelper インスタンスを取得します。
		 */
		private var _helper:TransitionHelper;
		
		/**
		 * Transition インスタンスを取得します。
		 */
		private var _transition:Transition;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DoTransition インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DoTransition object.</span>
		 * 
		 * @param target
		 * <span lang="ja">トランジション効果を適用する対象の MovieClip オブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param type
		 * <span lang="ja">Tween インスタンスに適用する Transition です。</span>
		 * <span lang="en"></span>
		 * @param direction
		 * <span lang="ja">Tween インスタンスのイージングの方向です。</span>
		 * <span lang="en"></span>
		 * @param duration
		 * <span lang="ja">Tween インスタンスの継続時間です。</span>
		 * <span lang="en"></span>
		 * @param easing
		 * <span lang="ja">アニメーションのトゥイーン効果です。</span>
		 * <span lang="en"></span>
		 * @param parameters
		 * <span lang="ja">カスタムトゥイーンパラメータです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function DoTransition( target:MovieClip, type:Class, direction:int, duration:int, easing:Function, parameters:Object = null, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_type = type;
			this.direction = direction;
			this.duration = duration;
			_easing = easing;
			_parameters = parameters;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// TransitionHelper を作成する
			_helper = new TransitionHelper( _target );
			_helper.addEventListener( TransitionEvent.ALL_TRANSITIONS_IN_DONE, _allTransitionDone, false, int.MAX_VALUE, true );
			_helper.addEventListener( TransitionEvent.ALL_TRANSITIONS_OUT_DONE, _allTransitionDone, false, int.MAX_VALUE, true );
			
			// パラメータを設定する
			var o:Object = { type:_type, direction:_direction, duration:_duration, easing:_easing };
			for ( var p:String in _parameters ) {
				o[p] ||= _parameters[p];
			}
			
			// TransitionHelper を実行する
			_transition = _helper.startTransition( o );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// Transition が存在すれば
			if ( _transition ) {
				_helper.removeTransition( _transition );
				
				// イベントリスナーを解除する
				_helper.removeEventListener( TransitionEvent.ALL_TRANSITIONS_IN_DONE, _allTransitionDone );
				_helper.removeEventListener( TransitionEvent.ALL_TRANSITIONS_OUT_DONE, _allTransitionDone );
				
				// TransitionHelper を破棄する
				_helper = null;
				_transition = null;
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">DoTransition インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DoTransition subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DoTransition インスタンスです。</span>
		 * <span lang="en">A new DoTransition object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new DoTransition( _target, _type, _direction, _duration, _easing, _parameters, this );
		}
		
		
		
		
		
		/**
		 */
		private function _allTransitionDone( e:Event ):void {
			// イベントリスナーを解除する
			_helper.removeEventListener( TransitionEvent.ALL_TRANSITIONS_IN_DONE, _allTransitionDone );
			_helper.removeEventListener( TransitionEvent.ALL_TRANSITIONS_OUT_DONE, _allTransitionDone );
			
			// TransitionHelper を破棄する
			_helper = null;
			_transition = null;
			
			// 処理を終了する
			executeComplete();
		}
	}
}
