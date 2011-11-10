/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.display {
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExImageLoaderAlign;
	import jp.nium.display.ExLoader;
	
	/**
	 * <span lang="ja">ExImageLoader クラスは、ExLoader クラスに対してイメージの読み込みや制御の機能拡張を追加した表示オブジェクトクラスです。</span>
	 * <span lang="en">ExImageLoader class is a display object class which extends the image reading and control function to the ExLoader class.</span>
	 */
	public class ExImageLoader extends ExLoader {
		
		/**
		 * <span lang="ja">表示オブジェクトの幅を示します (ピクセル単位)。</span>
		 * <span lang="en">Indicates the width of the display object, in pixels.</span>
		 */
		public override function get width():Number { return _width; }
		public override function set width( value:Number ):void {
			_width = value;
			
			// Bitmap を更新する
			_update();
		}
		private var _width:Number;
		
		/**
		 * <span lang="ja">表示オブジェクトの高さを示します (ピクセル単位)。</span>
		 * <span lang="en">Indicates the height of the display object, in pixels.</span>
		 */
		public override function get height():Number { return _height; }
		public override function set height( value:Number ):void {
			_height = value;
			
			// Bitmap を更新する
			_update();
		}
		private var _height:Number;
		
		/**
		 * <span lang="ja">ロードされたコンテンツの規格幅を取得します。</span>
		 * <span lang="en">Get the standard width of the loaded contents.</span>
		 */
		public function get contentWidth():Number { return _contentWidth; }
		private var _contentWidth:Number = 0;
		
		/**
		 * <span lang="ja">ロードされたファイルの規格高さを取得します。</span>
		 * <span lang="en">Get the standard height of the loaded contents.</span>
		 */
		public function get contentHeight():Number { return _contentHeight; }
		private var _contentHeight:Number = 0;
		
		/**
		 * <span lang="ja">画像の基準点を取得または設定します。</span>
		 * <span lang="en">Get or set the reference point of the image.</span>
		 */
		public function get align():String { return _align; }
		public function set align( value:String ):void {
			switch( value ) {
				case ExImageLoaderAlign.BOTTOM			:
				case ExImageLoaderAlign.BOTTOM_LEFT		:
				case ExImageLoaderAlign.BOTTOM_RIGHT	:
				case ExImageLoaderAlign.CENTER			:
				case ExImageLoaderAlign.LEFT			:
				case ExImageLoaderAlign.RIGHT			:
				case ExImageLoaderAlign.TOP				:
				case ExImageLoaderAlign.TOP_LEFT		:
				case ExImageLoaderAlign.TOP_RIGHT		: {
					_align = value;
					
					// Bitmap を更新する
					_update();
					break;
				}
				default									: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "align" ) ); }
			}
		}
		private var _align:String;
		
		/**
		 * <span lang="ja">リサイズ時に比率を維持するかどうかを取得または設定します。</span>
		 * <span lang="en">Get or set whether to maintain the ratio when resizing it.</span>
		 */
		public function get ratio():Boolean { return _ratio; }
		public function set ratio( value:Boolean ):void {
			_ratio = value;
			
			// Bitmap を更新する
			_update();
		}
		private var _ratio:Boolean = false;
		
		/**
		 * <span lang="ja">Bitmap オブジェクトが最も近いピクセルに吸着されるかどうかを指定します。</span>
		 * <span lang="en">Controls whether or not the Bitmap object is snapped to the nearest pixel.</span>
		 */
		public function get pixelSnapping():String { return _pixelSnapping; }
		public function set pixelSnapping( value:String ):void {
			_pixelSnapping = value;
			
			// Bitmap が存在すれば
			if ( _bmp ) {
				_bmp.pixelSnapping = value;
			}
		}
		private var _pixelSnapping:String = PixelSnapping.ALWAYS;
		
		/**
		 * <span lang="ja">ビットマップを拡大 / 縮小するときにスムージングするかどうかを指定します。</span>
		 * <span lang="en">Controls whether or not the bitmap is smoothed when scaled.</span>
		 */
		public function get smoothing():Boolean { return _smoothing; }
		public function set smoothing( value:Boolean ):void {
			_smoothing = value;
			
			// Bitmap が存在すれば
			if ( _bmp ) {
				_bmp.smoothing = value;
			}
		}
		private var _smoothing:Boolean = true;
		
		/**
		* Bitmap インスタンスを取得します。 
		*/
		private var _bmp:Bitmap;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ExImageLoader インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ExImageLoader object.</span>
		 */
		public function ExImageLoader() {
			// イベントリスナーを登録する
			contentLoaderInfo.addEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			contentLoaderInfo.addEventListener( Event.UNLOAD, _unload, false, int.MAX_VALUE, true );
			contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">イメージファイルを読み込みます。</span>
		 * <span lang="en">Read the image file.</span>
		 * 
		 * @param request
		 * <span lang="ja">読み込む JPEG、GIF、または PNG ファイルの絶対 URL または相対 URL です。</span>
		 * <span lang="en">Absolute or relative URL of the JPEG , GIF or PNG file to read.</span>
		 * @param context
		 * <span lang="ja">LoaderContext オブジェクトです。</span>
		 * <span lang="en">The LoaderContext object.</span>
		 */
		public override function load( request:URLRequest, context:LoaderContext = null ):void {
			// 拡張子で判別する
			var extension:String = String( request.url.split( "." ).reverse()[0] ).toLowerCase();
			switch ( extension ) {
				case "jpg"		:
				case "jpeg"		:
				case "jpe"		:
				case "gif"		:
				case "png"		: { break; }
				default			: { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_8004" ) ); }
			}
			
			// 読み込む
			super.load( request, context );
		}
		
		/**
		 * @private
		 */
		public override function loadBytes( bytes:ByteArray, context:LoaderContext = null ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "loadBytes" ) );
		}
		
		/**
		 * 画像を更新する
		 */
		private function _update():void {
			// Bitmap が存在しなければ終了する
			if ( !_bmp ) { return; }
			
			// サイズが指定されていなければオリジナルサイズを設定する
			_width = isNaN( _width ) ? _contentWidth : _width;
			_height = isNaN( _height ) ? _contentHeight : _height;
			
			// 縦横比を調整する
			if ( _ratio ) {
				var scale:Number = Math.max( _width / _contentWidth, _height / _contentHeight );
				_bmp.width = Math.ceil( _contentWidth * scale );
				_bmp.height = Math.ceil( _contentHeight * scale );
			}
			else {
				_bmp.width = _width;
				_bmp.height = _height;
			}
			
			// X 軸の基準点を調整する
			_bmp.x = ( _width - _bmp.width ) / 2;
			switch( _align ) {
				case ExImageLoaderAlign.BOTTOM			:
				case ExImageLoaderAlign.CENTER			:
				case ExImageLoaderAlign.TOP				: { _bmp.x -= _width / 2; break; }
				
				case ExImageLoaderAlign.BOTTOM_LEFT		:
				case ExImageLoaderAlign.LEFT			:
				case ExImageLoaderAlign.TOP_LEFT		: { break; }
				
				case ExImageLoaderAlign.BOTTOM_RIGHT	:
				case ExImageLoaderAlign.RIGHT			:
				case ExImageLoaderAlign.TOP_RIGHT		: { _bmp.x = -_width; break; }
			}
			
			// Y 軸の基準点を調整する
			_bmp.y = ( _height - _bmp.height ) / 2;
			switch( _align ) {
				case ExImageLoaderAlign.BOTTOM			:
				case ExImageLoaderAlign.BOTTOM_LEFT		:
				case ExImageLoaderAlign.BOTTOM_RIGHT	: { _bmp.y -= _height; break; }
				
				case ExImageLoaderAlign.CENTER			:
				case ExImageLoaderAlign.LEFT			:
				case ExImageLoaderAlign.RIGHT			: { _bmp.y -= _height / 2; break; }
				
				case ExImageLoaderAlign.TOP				:
				case ExImageLoaderAlign.TOP_LEFT		:
				case ExImageLoaderAlign.TOP_RIGHT		: { break; }
			}
		}
		
		
		
		
		
		/**
		 * ロード操作が開始したときに送出されます。
		 */
		private function _open( e:Event ):void {
			// Bitmap を破棄する
			_bmp = null;
			
			// オリジナルサイズを破棄する
			_contentWidth = 0;
			_contentHeight = 0;
			
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// Bitmap を取得する
			_bmp = Bitmap( super.content );
			_bmp.width = _width;
			_bmp.height = _height;
			_bmp.pixelSnapping = _pixelSnapping;
			_bmp.smoothing = _smoothing;
			
			// オリジナルサイズを保存する
			_contentWidth = contentLoaderInfo.width;
			_contentHeight = contentLoaderInfo.height;
			
			// Bitmap を更新する
			_update();
			
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * ロードされたオブジェクトが Loader オブジェクトの unload() メソッドを使用して削除されるたびに、LoaderInfo オブジェクトによって送出されます。
		 */
		private function _unload( e:Event ):void {
			// Bitmap を破棄する
			_bmp = null;
			
			// オリジナルサイズを破棄する
			_contentWidth = 0;
			_contentHeight = 0;
			
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
	}
}
