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
package jp.progression.core.managers {
	import com.asual.swfaddress.SWFAddress;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.external.BrowserInterface;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.managers.HistoryManagerType;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	/**
	 * @private
	 */
	public final class HistoryManager {
		
		/**
		 * <span lang="ja">履歴管理の種類を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get type():String { return _type; }
		private static var _type:String = BrowserInterface.enabled ? HistoryManagerType.BROWSER : HistoryManagerType.FLASHPLAYER;
		
		/**
		 * 保存している履歴配列を取得します。
		 */
		private static var _histories:Array = [];
		
		/**
		 * 現在の履歴位置を取得します。
		 */
		private static var _position:int = 0;
		
		/**
		 * 履歴更新をロックするかどうかを取得します。
		 */
		private static var _lock:Boolean = false;
		
		
		
		
		
		/**
		 * @private
		 */
		public function HistoryManager() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "HistoryManager" ) );;
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __addHistory( sceneId:SceneId ):void {
			switch ( _type ) {
				case HistoryManagerType.BROWSER			: { break; }
				case HistoryManagerType.FLASHPLAYER		: {
					// ロックされていれば終了する
					if ( _lock ) { return; }
					
					// 現在位置から後の履歴を削除して、新しく追加する
					_histories.splice( _position + 1, _histories.length, sceneId );
					
					// 現在位置を移動する
					_position = _histories.length - 1;
					break;
				}
			}
		}
		
		/**
		 * <span lang="ja">次の履歴に移動します。</span>
		 * <span lang="en"></span>
		 */
		public static function forward():void {
			switch ( _type ) {
				case HistoryManagerType.BROWSER			: { SWFAddress.forward(); break; }
				case HistoryManagerType.FLASHPLAYER		: {
					// 値を更新する
					_position = Math.min( _position + 1, _histories.length - 1 );
					
					var sceneId:SceneId = SceneId( _histories[_position] );
					var progression:Progression = ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
					
					// 存在すれば移動する
					if ( progression ) {
						_lock = true;
						progression.goto( sceneId );
						_lock = false;
					}
					break;
				}
			}
		}
		
		/**
		 * <span lang="ja">前の履歴に移動します。</span>
		 * <span lang="en"></span>
		 */
		public static function back():void {
			switch ( _type ) {
				case HistoryManagerType.BROWSER			: { SWFAddress.back(); break; }
				case HistoryManagerType.FLASHPLAYER		: {
					// 値を更新する
					_position = Math.max( 0, _position - 1 );
					
					var sceneId:SceneId = SceneId( _histories[_position] );
					var progression:Progression = ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
					
					// 存在すれば移動する
					if ( progression ) {
						_lock = true;
						progression.goto( sceneId );
						_lock = false;
					}
					break;
				}
			}
		}
		
		/**
		 * <span lang="ja">特定の位置にある履歴に移動します。</span>
		 * <span lang="en"></span>
		 */
		public static function go( delta:Number ):void {
			switch ( _type ) {
				case HistoryManagerType.BROWSER			: { SWFAddress.go( delta ); break; }
				case HistoryManagerType.FLASHPLAYER		: {
					break;
				}
			}
		}
	}
}
