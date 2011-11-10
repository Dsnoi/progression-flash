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
	
	/*======================================================================*//**
	 * @private
	 */
	public class HistoryManager {
		
		/*======================================================================*//**
		 * <p>履歴管理の種類を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get type():String { return _type; }
		private static var _type:String = function():String {
			// 再生されている状態で判断する
			return BrowserInterface.enabled ? HistoryManagerType.BROWSER : HistoryManagerType.FLASHPLAYER;
		}.apply();
		
		/*======================================================================*//**
		 * 保存している履歴配列を取得します。
		 */
		private static var _histories:Array = [];
		
		/*======================================================================*//**
		 * 現在の履歴位置を取得します。
		 */
		private static var _position:int = 0;
		
		/*======================================================================*//**
		 * 履歴更新をロックするかどうかを取得します。
		 */
		private static var _lock:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function HistoryManager() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "HistoryManager" ) );;
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>次の履歴に移動します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>前の履歴に移動します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>特定の位置にある履歴に移動します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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









