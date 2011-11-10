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
package jp.progression.core.casts {
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.casts.CastSprite;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">Progression インスタンスに関連付けられた汎用的に使用可能な表示オブジェクトを提供します。
	 * Container クラスを直接インスタンス化することはできません。
	 * new Container() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public final class Container extends CastSprite {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">Container インスタンスの画面上の表示 X 座標を常に SWF ファイルエリアの中央とするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get centeringX():Boolean { return _centeringX; }
		public function set centeringX( value:Boolean ):void {
			if ( _centeringX = value ) {
				// イベントリスナーを登録する
				stage.addEventListener( Event.RESIZE, _resize, false, int.MAX_VALUE, true );
			}
			else if ( !_centeringY ) {
				// イベントリスナーを解除する
				stage.removeEventListener( Event.RESIZE, _resize );
			}
			
			// 位置を調節する
			super.x = value ? stage.stageWidth / 2 : 0;
		}
		private var _centeringX:Boolean = false;
		
		/**
		 * <span lang="ja">Container インスタンスの画面上の表示 Y 座標を常に SWF ファイルエリアの中央とするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get centeringY():Boolean { return _centeringY; }
		public function set centeringY( value:Boolean ):void {
			if ( _centeringY = value ) {
				// イベントリスナーを登録する
				stage.addEventListener( Event.RESIZE, _resize, false, int.MAX_VALUE, true );
			}
			else if ( !_centeringX ) {
				// イベントリスナーを解除する
				stage.removeEventListener( Event.RESIZE, _resize );
			}
			
			// 位置を調節する
			super.y = value ? stage.stageHeight/ 2 : 0;
		}
		private var _centeringY:Boolean = false;
		
		/**
		 * <span lang="ja">親 DisplayObjectContainer のローカル座標を基準にした DisplayObject インスタンスの x 座標を示します。
		 * この値は centering プロパティが true に設定されている場合には変更できません。</span>
		 * <span lang="en"></span>
		 */
		public override function get x():Number { return super.x; }
		public override function set x( value:Number ):void {
			// センタリング状態であれば終了する
			if ( _centeringX ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9008", "x" ) ); }
			
			super.x = value;
		}
		
		/**
		 * <span lang="ja">親 DisplayObjectContainer のローカル座標を基準にした DisplayObject インスタンスの y 座標を示します。
		 * この値は centering プロパティが true に設定されている場合には変更できません。</span>
		 * <span lang="en"></span>
		 */
		public override function get y():Number { return super.y; }
		public override function set y( value:Number ):void {
			// センタリング状態であれば終了する
			if ( _centeringY ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9008", "y" ) ); }
			
			super.y = value;
		}
		
		/**
		 * <span lang="ja">ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</span>
		 * <span lang="en"></span>
		 */
		public override function get root():DisplayObject { return this; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function Container() {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Container" ) ); };
			
			// 初期化する
			_internallyCalled = false;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __createInstance():Container {
			_internallyCalled = true;
			return new Container();
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			centeringX = _centeringX;
			centeringY = _centeringY;
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopImmediatePropagation();
			
			// エラーを送出する
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9009" ) );
		}
		
		/**
		 * Stage オブジェクトの scaleMode プロパティが StageScaleMode.NO_SCALE に設定され、SWF ファイルのサイズが変更されたときに送出されます。
		 */
		private function _resize( e:Event ):void {
			// 位置を調節する
			super.x = _centeringX ? Math.round( stage.stageWidth / 2 ) : 0;
			super.y = _centeringY ? Math.round( stage.stageHeight/ 2 ) : 0;
		}
	}
}
