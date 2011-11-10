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
package jp.progression.core.components.loader {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import jp.nium.display.ExLoader;
	import jp.nium.display.ExSprite;
	import jp.nium.utils.MovieClipUtil;
	import jp.nium.utils.StageUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	
	[IconFile( "Preloader.png" )]
	/**
	 * @private
	 */
	public class PreloaderComp extends ExSprite {
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_LOAD_STATE_FRAME:String = "load";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_COMPLETE_STATE_FRAME:String = "complete";
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static const DEFAULT_ERROR_STATE_FRAME:String = "error";
		
		
		
		
		
		/**
		 * <span lang="ja">読み込む SWF ファイルの URL を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="url", type="String", defaultValue="*.swf" )]
		public function get url():String { return _url; }
		public function set url( value:String ):void { _url = value; }
		private var _url:String = "index.swf";
		
		/**
		 * <span lang="ja">url プロパティの値に相対パスを使用した際に、SWF ファイルの設置されているフォルダを基準とするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="useSWFBasePath", type="Boolean", defaultValue="false", verbose="1" )]
		public function get useSWFBasePath():Boolean { return _useSWFBasePath; }
		public function set useSWFBasePath( value:Boolean ):void { _useSWFBasePath = value; }
		private var _useSWFBasePath:Boolean = false;
		
		/**
		 * <span lang="ja">オブジェクトをロードする前に、Flash Player がクロスドメインポリシーファイルの存在を確認するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="checkPolicyFile", type="Boolean", defaultValue="false", verbose="1" )]
		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }
		public function set checkPolicyFile( value:Boolean ):void { _checkPolicyFile = value; }
		private var _checkPolicyFile:Boolean = false;
		
		/**
		 * <span lang="ja">読み込み処理が開始された場合の表示アニメーションを示すフレームラベル、またはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="loadStateFrame", type="Default", defaultValue="load", verbose="1" )]
		public function get loadStateFrame():* { return _loadStateFrame; }
		public function set loadStateFrame( value:* ):void { _loadStateFrame = value || DEFAULT_LOAD_STATE_FRAME; }
		private var _loadStateFrame:* = DEFAULT_LOAD_STATE_FRAME;
		
		/**
		 * <span lang="ja">読み込み処理が完了された場合の表示アニメーションを示すフレームラベル、またはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="completeStateFrame", type="Default", defaultValue="complete", verbose="1" )]
		public function get completeStateFrame():* { return _completeStateFrame; }
		public function set completeStateFrame( value:* ):void { _completeStateFrame = value || DEFAULT_COMPLETE_STATE_FRAME; }
		private var _completeStateFrame:* = DEFAULT_COMPLETE_STATE_FRAME;
		
		/**
		 * <span lang="ja">IOErrorEvent.IO_ERROR イベントが送出された場合の表示アニメーションを示すフレームラベル、またはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="errorStateFrame", type="Default", defaultValue="error", verbose="1" )]
		public function get errorStateFrame():* { return _errorStateFrame; }
		public function set errorStateFrame( value:* ):void { _errorStateFrame = value || DEFAULT_ERROR_STATE_FRAME; }
		private var _errorStateFrame:* = DEFAULT_ERROR_STATE_FRAME;
		
		/**
		 * <span lang="ja">Flash Player またはブラウザでのステージの配置を指定する StageAlign クラスの値です。</span>
		 * <span lang="en">A value from the StageAlign class that specifies the alignment of the stage in Flash Player or the browser.</span>
		 */
		[Inspectable( name="align", type="List", enumeration="BOTTOM,BOTTOM_LEFT,BOTTOM_RIGHT,LEFT,CENTER,RIGHT,TOP,TOP_LEFT,TOP_RIGHT", defaultValue="CENTER" )]
		public function get align():String { return _align; }
		public function set align( value:String ):void {
			switch ( value ) {
				case "CENTER"			: { _align = ""; break; }
				case "BOTTOM"			:
				case "BOTTOM_LEFT"		:
				case "BOTTOM_RIGHT"		:
				case "LEFT"				:
				case "RIGHT"			:
				case "TOP"				:
				case "TOP_LEFT"			:
				case "TOP_RIGHT"		: { _align = StageAlign[value]; break; }
				default					: { _align = value || ""; }
			}
		}
		private var _align:String;
		
		/**
		 * <span lang="ja">Flash Player が使用するレンダリング品質を指定する StageQuality クラスの値です。</span>
		 * <span lang="en">A value from the StageQuality class that specifies which rendering quality is used.</span>
		 */
		[Inspectable( name="quality", type="List", enumeration="best,high,low,medium", defaultValue="high" )]
		public function get quality():String { return _quality; }
		public function set quality( value:String ):void { _quality = value; }
		private var _quality:String = StageQuality.HIGH;
		
		/**
		 * <span lang="ja">使用する拡大 / 縮小モードを指定する StageScaleMode クラスの値です。</span>
		 * <span lang="en">A value from the StageScaleMode class that specifies which scale mode to use.</span>
		 */
		[Inspectable( name="scaleMode", type="List", enumeration="exactFit,noBorder,noScale,showAll", defaultValue="noScale" )]
		public function get scaleMode():String { return _scaleMode; }
		public function set scaleMode( value:String ):void { _scaleMode = value; }
		private var _scaleMode:String = StageScaleMode.NO_SCALE;
		
		/**
		 * コンポーネントを適用する対象 MovieClip インスタンスを取得します。
		 */
		private var _target:MovieClip;
		
		/**
		 * ExLoader インスタンスを取得します。
		 */
		private var _loader:ExLoader = new ExLoader();
		
		/**
		 * 読み込み開始位置のフレーム番号を取得します。
		 */
		private var _loadFrame:int = 0;
		
		/**
		 * 読み込み完了位置のフレーム番号を取得します。
		 */
		private var _completeFrame:int = 0;
		
		/**
		 * 読み込み開始位置と読み込み完了の差分を取得します。
		 */
		private var _distanceFrame:int = 0;
		
		
		
		
		
		/**
		 * @private
		 */
		public function PreloaderComp() {
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, 0, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removeFromStage, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * 読み込み処理を実行します。
		 */
		private function _load():void {
			// stage を初期化する
			stage.align = _align || "";
			stage.quality = _quality || "";
			stage.scaleMode = _scaleMode;
			
			// flashvars からファイルパスを取得する
			_url = _target.loaderInfo.parameters.url || _url;
			_useSWFBasePath = StringUtil.toProperType( _target.loaderInfo.parameters.useSWFBasePath ) || _useSWFBasePath;
			
			// 読み込むファイルの基点を設定する
			var url:String = _useSWFBasePath ? StageUtil.toSWFBasePath( stage, _url ) : _url;
			
			// イベントリスナーを登録する
			_loader.contentLoaderInfo.addEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			
			// 読み込み処理を開始する
			_loader.load( new URLRequest( url ), new LoaderContext( _checkPolicyFile, ApplicationDomain.currentDomain ) );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			
			// 親が MovieClip であれば
			_target = parent as MovieClip;
			
			// target が存在すれば
			if ( _target ) {
				// 停止する
				_target.gotoAndStop( 1 );
				
				// コンポーネントのパラメータ設定を待って実行する
				MovieClipUtil.doLater( null, _load );
			}
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removeFromStage( e:Event ):void {
			Verbose.warning( this, VerboseMessageConstants.getMessage( "VERBOSE_0006", this ) );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopImmediatePropagation();
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが開始された瞬間に送出されます。
		 */
		private function _open( e:Event ):void {
			// フレーム状態を取得する
			_loadFrame = MovieClipUtil.labelToFrames( _target, _loadStateFrame )[0] || 1;
			_completeFrame = MovieClipUtil.labelToFrames( _target, _completeStateFrame )[0] || _target.totalFrames;
			_distanceFrame = MovieClipUtil.getMarginFrames( _target, _completeFrame, _loadFrame );
		}
		
		/**
		 * オブジェクトの load() メソッドによる読み込みが完了された瞬間に送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( Event.OPEN, _open );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// ディスプレイリストに追加する
			_target.addChild( _loader );
		}
		
		/**
		 * ダウンロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// 読み込み表示に移動する
			_target.gotoAndStop( _loadFrame + Math.round( _distanceFrame * e.bytesLoaded / e.bytesTotal ) );
		}
		
		/**
		 * 入出力エラーが発生してロード処理が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントリスナーを解除する
			_loader.contentLoaderInfo.removeEventListener( Event.OPEN, _open );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _complete );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			// エラー表示に移動する
			_target.gotoAndStop( MovieClipUtil.labelToFrames( _target, _errorStateFrame )[0] || 1 );
		}
	}
}
