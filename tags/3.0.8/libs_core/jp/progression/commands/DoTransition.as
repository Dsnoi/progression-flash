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
	import fl.transitions.Transition;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import jp.nium.api.transition.TransitionEvent;
	import jp.nium.api.transition.TransitionHelper;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>DoTransition クラスは、fl.transitions パッケージのトランジション機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>トランジション効果を適用する対象の MovieClip オブジェクトを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get target():MovieClip { return _target; }
		public function set target( value:MovieClip ):void { _target = value; }
		private var _target:MovieClip;
		
		/*======================================================================*//**
		 * <p>Tween インスタンスに適用する Transition を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get type():Class { return _type; }
		public function set type( value:Class ):void { _type = value; }
		private var _type:Class;
		
		/*======================================================================*//**
		 * <p>Tween インスタンスのイージングの方向を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get direction():int { return _direction; }
		public function set direction( value:int ):void {
			switch ( value ) {
				case Transition.IN		:
				case Transition.OUT		: { _direction = value; break; }
				default					: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "direction" ) ) }
			}
		}
		private var _direction:int;
		
		/*======================================================================*//**
		 * <p>Tween インスタンスの継続時間を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get duration():int { return _duration; }
		public function set duration( value:int ):void {
			_duration = Math.max( 0, value );
			
			// タイムアウトを再設定する
			timeOut = Math.max( timeOut, _duration + 5000 );
		}
		private var _duration:int = Transition.IN;
		
		/*======================================================================*//**
		 * <p>アニメーションのトゥイーン効果を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function;
		
		/*======================================================================*//**
		 * <p>カスタムトゥイーンパラメータを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object;
		
		/*======================================================================*//**
		 * TransitionHelper インスタンスを取得します。
		 */
		private var _helper:TransitionHelper;
		
		/*======================================================================*//**
		 * Transition インスタンスを取得します。
		 */
		private var _transition:Transition;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい DoTransition インスタンスを作成します。</p>
		 * <p>Creates a new DoTransition object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>トランジション効果を適用する対象の MovieClip オブジェクトです。</p>
		 * 	<p></p>
		 * @param type
		 * 	<p>Tween インスタンスに適用する Transition です。</p>
		 * 	<p></p>
		 * @param direction
		 * 	<p>Tween インスタンスのイージングの方向です。</p>
		 * 	<p></p>
		 * @param duration
		 * 	<p>Tween インスタンスの継続時間です。</p>
		 * 	<p></p>
		 * @param easing
		 * 	<p>アニメーションのトゥイーン効果です。</p>
		 * 	<p></p>
		 * @param parameters
		 * 	<p>カスタムトゥイーンパラメータです。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function DoTransition( target:MovieClip = null, type:Class = null, direction:int = 0, duration:int = 0, easing:Function = null, parameters:Object = null, initObject:Object = null ) {
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
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>DoTransition インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTransition subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい DoTransition インスタンスです。</p>
		 * 	<p>A new DoTransition object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTransition( _target, _type, _direction, _duration, _easing, _parameters, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 
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









