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
package jp.progression.core.components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.ClassUtil;
	import jp.progression.casts.CastSprite;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.core.events.ComponentEvent.COMPONENT_ADDED
	 */
	[Event( name="componentAdded", type="jp.progression.events.ComponentEvent" )]
	
	/**
	 * <span lang="ja">コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.core.events.ComponentEvent.COMPONENT_REMOVED
	 */
	[Event( name="componentRemoved", type="jp.progression.events.ComponentEvent" )]
	
	/**
	 * @private
	 */
	public class CoreComp extends CastSprite {
		
		/**
		 * <span lang="ja">コンポーネントを適用する対象 MovieClip インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		protected function get target():MovieClip { return _target; }
		private var _target:MovieClip;
		
		/**
		 * <span lang="ja">コンポーネントが有効化されているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		protected function get enabled():Boolean { return _enabled; }
		private var _enabled:Boolean = false;
		
		
		
		
		
		/**
		 * @private
		 */
		public function CoreComp() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CastSprite ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CoreComp" ) ); }
			
			// 表示を削除する
			setProperties( {
				x:0,
				y:0,
				width:0,
				height:0,
				visible:false
			} );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			
			// コンポーネントを無効化する
			_enabled = false;
			
			// ICastObject インターフェイスを実装していれば終了する
			if ( parent is ICastObject ) {
				Verbose.warning( parent, VerboseMessageConstants.getMessage( "VERBOSE_0000", parent.name, className ) );
				return;
			}
			
			// MovieClip クラスでなければ終了する
			if ( !( parent is MovieClip ) ) {
				Verbose.warning( parent, VerboseMessageConstants.getMessage( "VERBOSE_0001", parent.name, className ) );
				return;
			}
			
			// dynamic クラスでなければ終了する
			if ( !ClassUtil.isDynamic( parent ) ) {
				Verbose.warning( parent, VerboseMessageConstants.getMessage( "VERBOSE_0002", parent.name, className ) );
				return;
			}
			
			// コンポーネントを有効化する
			_enabled = true;
			
			// ターゲットを親に設定する
			_target = MovieClip( parent );
			
			// 再生を停止する
			_target.stop();
			
			// _target に executor が存在していなければ作成する
			_target.executor ||= CommandExecutor.progression_internal::__createInstance( _target );
			
			// dynamic クラスでなければ終了する
			if ( !( _target.executor is CommandExecutor ) ) {
				Verbose.warning( parent, VerboseMessageConstants.getMessage( "VERBOSE_0002", parent, className ) );
				return;
			}
			
			// _target の executor に登録する
			_target.executor.progression_internal::__addExecutable( this );
			
			// コンポーネントが有効化されていれば
			dispatchEvent( new ComponentEvent( ComponentEvent.COMPONENT_ADDED ) );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage );
			
			// コンポーネントが有効化されていれば
			dispatchEvent( new ComponentEvent( ComponentEvent.COMPONENT_REMOVED ) );
			
			// _target の executor から削除する
			_target.executor.progression_internal::__removeExecutable( this );
			
			// コンポーネントを無効化する
			_enabled = false;
			
			// ターゲットを削除する
			_target = null;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
		}
	}
}
