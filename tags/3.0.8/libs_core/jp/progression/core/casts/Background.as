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
package jp.progression.core.casts {
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastSprite;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>Progression インスタンスに関連付けられた汎用的に使用可能な表示オブジェクトを提供します。</p>
	 * Background クラスを直接インスタンス化することはできません。
	 * new Background() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Background extends CastSprite {
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function Background() {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Background" ) ); };
			
			// 初期化する
			_internallyCalled = false;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance():Background {
			_internallyCalled = true;
			return new Background();
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopImmediatePropagation();
			
			// エラーを送出する
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9009" ) );
		}
	}
}









