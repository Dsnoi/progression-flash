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
package jp.progression.core.components.animation {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.animation.AnimationBase;
	import jp.progression.core.components.CoreComp;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public class AnimationComp extends CoreComp {
		
		/**
		 * <span lang="ja">コンポーネントとして適用する AnimationBase インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get component():AnimationBase { return _component; }
		private var _component:AnimationBase;
		
		
		
		
		
		/**
		 * @private
		 */
		public function AnimationComp( component:AnimationBase ) {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreComp ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "AnimationComp" ) ); }
			
			// 引数を設定する
			_component = component;
			
			// 再生を停止する
			_component.gotoAndStop( 1 );
			
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
