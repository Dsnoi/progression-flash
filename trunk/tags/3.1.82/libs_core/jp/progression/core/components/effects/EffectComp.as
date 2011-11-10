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
package jp.progression.core.components.effects {
	import fl.transitions.easing.Back;
	import fl.transitions.easing.Bounce;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.None;
	import fl.transitions.easing.Regular;
	import fl.transitions.easing.Strong;
	import flash.errors.IllegalOperationError;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.effects.EffectBase;
	import jp.progression.core.components.CoreComp;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public class EffectComp extends CoreComp {
		
		/**
		 * <span lang="ja">コンポーネントとして適用する EffectBase インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get component():EffectBase { return _component; }
		private var _component:EffectBase;
		
		/**
		 * <span lang="ja">Tween インスタンスのイージングの方向を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="direction", type="List", enumeration="in,inOut,out", defaultValue="inOut" )]
		public function get direction():String { return _component.direction; }
		public function set direction( value:String ):void { _component.direction = value; }
		
		/**
		 * <span lang="ja">アニメーションの継続時間を決定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="duration", type="Number", defaultValue="1000" )]
		public function get duration():Number { return _component.duration; }
		public function set duration( value:Number ):void { _component.duration = value; }
		
		/**
		 * <span lang="ja">アニメーションのトゥイーン効果を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="easing", type="List", enumeration="Back.easeIn,Back.easeInOut,Back.easeOut,Bounce.easeIn,Bounce.easeInOut,Bounce.easeOut,Elastic.easeIn,Elastic.easeInOut,Elastic.easeOut,None.easeIn,None.easeInOut,None.easeNone,None.easeOut,Regular.easeIn,Regular.easeInOut,Regular.easeOut,Strong.easeIn,Strong.easeInOut,Strong.easeOut", defaultValue="None.easeNone" )]
		public function get easing():String { return _easing; }
		public function set easing( value:String ):void {
			switch ( value ) {
				case "Back.easeIn"			:
				case "Back.easeInOut"		:
				case "Back.easeOut"			:
				case "Bounce.easeIn"		:
				case "Bounce.easeInOut"		:
				case "Bounce.easeOut"		:
				case "Elastic.easeIn"		:
				case "Elastic.easeInOut"	:
				case "Elastic.easeOut"		:
				case "None.easeIn"			:
				case "None.easeInOut"		:
				case "None.easeNone"		:
				case "None.easeOut"			:
				case "Regular.easeIn"		:
				case "Regular.easeInOut"	:
				case "Regular.easeOut"		:
				case "Strong.easeIn"		:
				case "Strong.easeInOut"		:
				case "Strong.easeOut"		: {
					_easing = value;
					
					var list:Array = value.split( "." );
					_component.easing = getDefinitionByName( "fl.transitions.easing." + list[0] )[list[1]];
					break;
				}
				default						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "easing" ) ); }
			}
		}
		private var _easing:String = "None.easeNone";
		
		
		
		
		
		/**
		 * @private
		 */
		public function EffectComp( component:EffectBase ) {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreComp ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "EffectComp" ) ); }
			
			// 引数を設定する
			_component = component;
			
			// 再生を停止する
			_component.gotoAndStop( 1 );
			
			// クラスを SWF に含める
			Back;
			Bounce;
			Elastic;
			None;
			Regular;
			Strong;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( ComponentEvent.COMPONENT_REMOVED, _componentRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _componentAdded( e:ComponentEvent ):void {
			// target を設定する
			_component.progression_internal::__target = target;
			
			// 表示リストに追加する
			if ( !contains( _component ) ) {
				addChild( _component );
			}
		}
		
		/**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _componentRemoved( e:ComponentEvent ):void {
			// 表示リストから削除する
			if ( contains( _component ) ) {
				removeChild( _component );
			}
			
			// target を破棄する
			_component.progression_internal::__target = target;
		}
	}
}
