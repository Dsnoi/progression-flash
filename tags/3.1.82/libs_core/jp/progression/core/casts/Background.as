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
	import flash.display.Graphics;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.StageUtil;
	import jp.progression.casts.CastSprite;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">Progression インスタンスに関連付けられた汎用的に使用可能な表示オブジェクトを提供します。
	 * Background クラスを直接インスタンス化することはできません。
	 * new Background() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Background extends CastSprite {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * @private
		 */
		public override function get x():Number { return super.x; }
		public override function set x( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "x" ) ); }
		
		/**
		 * @private
		 */
		public override function get y():Number { return super.y; }
		public override function set y( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "y" ) ); }
		
		/**
		 * @private
		 */
		public override function get width():Number { return super.width; }
		public override function set width( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "width" ) ); }
		
		/**
		 * @private
		 */
		public override function get height():Number { return super.height; }
		public override function set height( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "height" ) ); }
		
		/**
		 * @private
		 */
		public override function get rotation():Number { return super.rotation; }
		public override function set rotation( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "rotation" ) ); }
		
		/**
		 * @private
		 */
		public override function get scaleX():Number { return super.scaleX; }
		public override function set scaleX( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "scaleX" ) ); }
		
		/**
		 * @private
		 */
		public override function get scaleY():Number { return super.scaleY; }
		public override function set scaleY( value:Number ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "scaleY" ) ); }
		
		/**
		 * @private
		 */
		public override function get mask():DisplayObject { return null; }
		public override function set mask( value:DisplayObject ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "mask" ) ); }
		
		/**
		 * @private
		 */
		public override function get scrollRect():Rectangle { return null; }
		public override function set scrollRect( value:Rectangle ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "scrollRect" ) ); }
		
		/**
		 * @private
		 */
		public override function get transform():Transform { return null; }
		public override function set transform( value:Transform ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "transform" ) ); }
		
		/**
		 * @private
		 */
		public override function get graphics():Graphics { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "graphics" ) ); }
		private function get _graphics():Graphics { return super.graphics; }
		
		
		
		
		
		/**
		 * @private
		 */
		public function Background() {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "Background" ) ); };
			
			// 初期化する
			_internallyCalled = false;
			
			// 矩形を描画する
			_graphics.beginFill( 0x000000, 0 );
			_graphics.drawRect( 0, 0, 100, 100 );
			_graphics.endFill();
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __createInstance():Background {
			_internallyCalled = true;
			return new Background();
		}
		
		
		
		
		
		/**
		 * 
		 */
		private function _addedToStage( e:Event ):void {
			// イベントリスナーを登録する
			stage.addEventListener( Event.RESIZE, _resize, false, 0, true );
			_resize( null );
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
		 * 
		 */
		private function _resize( e:Event ):void {
			// 位置を調節する
			super.x = StageUtil.getMarginLeft( stage );
			super.y = StageUtil.getMarginTop( stage );
			
			// サイズを調節する
			super.width = stage.stageWidth;
			super.height = stage.stageHeight;
		}
	}
}
