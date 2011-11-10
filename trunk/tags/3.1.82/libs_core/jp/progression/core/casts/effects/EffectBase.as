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
package jp.progression.core.casts.effects {
	import fl.transitions.easing.None;
	import fl.transitions.Transition;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.casts.effects.EffectDirectionType;
	import jp.progression.commands.DoTransition;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CastEvent;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public class EffectBase extends CastMovieClip {
		
		/**
		 * <span lang="ja">適用するトランジション効果のクラスを取得します。</span>
		 * <span lang="en"></span>
		 */
		protected function get type():Class { return _type; }
		private var _type:Class;
		
		/**
		 * <span lang="ja">Tween インスタンスのイージングの方向を決定します。</span>
		 * <span lang="en"></span>
		 */
		public function get direction():String { return _direction; }
		public function set direction( value:String ):void {
			// タイプによって振り分ける
			switch ( value ) {
				case EffectDirectionType.IN			:
				case EffectDirectionType.IN_OUT		:
				case EffectDirectionType.OUT		: { _direction = value; break; }
				default								: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "direction" ) ); }
			}
		}
		private var _direction:String = EffectDirectionType.IN_OUT;
		
		/**
		 * <span lang="ja">アニメーションの継続時間を決定します。</span>
		 * <span lang="en"></span>
		 */
		public function get duration():Number { return _duration; }
		public function set duration( value:Number ):void { _duration = Math.max( 0, value ); }
		private var _duration:Number = 1000;
		
		/**
		 * <span lang="ja">アニメーションのトゥイーン効果を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get easing():Function { return _easing; }
		public function set easing( value:Function ):void { _easing = value; }
		private var _easing:Function = None.easeNone;
		
		/**
		 * <span lang="ja">カスタムトゥイーンパラメータを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object = {};
		
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
		 * <span lang="ja">新しい EffectBase インスタンスを作成します。</span>
		 * <span lang="en">Creates a new EffectBase object.</span>
		 * 
		 * @param type
		 * <span lang="ja">適用するトランジション効果のクラスです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function EffectBase( type:Class, initObject:Object = null ) {
			// スーパークラスを初期化する
			super( initObject );
			
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CastMovieClip ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectBase" ) ); }
			
			// 引数を設定する
			_type = type;
			
			// 初期化する
			_target = this;
			
			// 再生を停止する
			stop();
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( CastEvent.CAST_ADDED, _castAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// タイプによって振り分ける
			switch ( _direction ) {
				case EffectDirectionType.IN			:
				case EffectDirectionType.IN_OUT		: {
					addCommand(
						new DoTransition( _target, _type, Transition.IN, _duration / 1000, _easing, _parameters )
					);
					break;
				}
				case EffectDirectionType.OUT		: { break; }
			}
		}
		
		/**
		 * ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			// タイプによって振り分ける
			switch ( _direction ) {
				case EffectDirectionType.IN			: { break; }
				case EffectDirectionType.IN_OUT		:
				case EffectDirectionType.OUT		: {
					addCommand(
						new DoTransition( _target, _type, Transition.OUT, _duration / 1000, _easing, _parameters )
					);
					break;
				}
			}
		}
	}
}
