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
	import flash.display.StageAlign;
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.MovieClipUtil;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.Command;
	import jp.progression.core.components.CoreComp;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.debug.VerboseType;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.Progression;
	
	/**
	 * @private
	 */
	public class LoaderComp extends CoreComp {
		
		/**
		 * LoaderComp インスタンスを取得します。
		 */
		private static var _instance:LoaderComp;
		
		
		
		
		
		[Inspectable( name="activatedLicenseType", type="List", enumeration="basicLibraryLicense,businessWebLicense,businessApplicationLicense", defaultValue="basicLibraryLicense" )]
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function get activatedLicenseType():String { return Progression.activatedLicenseType; }
		public function set activatedLicenseType( value:String ):void { Progression.initialize( value ); }
		
		/**
		 * <span lang="ja">読み込む XML ファイルの URL を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="url", type="String", defaultValue="*.xml" )]
		public function get url():String { return _url; }
		public function set url( value:String ):void { _url = value; }
		private var _url:String;
		
		/**
		 * <span lang="ja">url プロパティの値に相対パスを使用した際に、SWF ファイルの設置されているフォルダを基準とするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="useSWFBasePath", type="Boolean", defaultValue="false", verbose="1" )]
		public function get useSWFBasePath():Boolean { return _useSWFBasePath; }
		public function set useSWFBasePath( value:Boolean ):void { _useSWFBasePath = value; }
		private var _useSWFBasePath:Boolean;
		
		/**
		 * <span lang="ja">ブラウザ上でコンテンツを実行している場合に、URL と Progression インスタンスのシーンを同期させるかどうかを取得または設定します。
		 * 同一コンテンツ上で有効化できる Progression インスタンスは 1 つのみであり、複数に対して有効化を試みた場合、最後に有効化された Progression インスタンス以外の sync プロパティは自動的に false に設定されます。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="sync", type="Boolean", defaultValue="true" )]
		public function get sync():Boolean { return _sync; }
		public function set sync( value:Boolean ):void { _sync = value; }
		private var _sync:Boolean;
		
		/**
		 * <span lang="ja">コマンド処理を実行中に lock プロパティの値を自動的に有効化するかどうかを取得または設定します。
		 * この設定が有効である場合には、コマンド処理が開始されると lock プロパティが true に、処理完了後に false となります。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="autoLock", type="Boolean", defaultValue="true", verbose="1" )]
		public function get autoLock():Boolean { return _autoLock; }
		public function set autoLock( value:Boolean ):void { _autoLock = value; }
		private var _autoLock:Boolean;
		
		/**
		 * <span lang="ja">デバッグ出力機能を使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="verbose", type="List", enumeration="none,simple,full", defaultValue="none", verbose="1" )]
		public function get verbose():String { return _verbose; }
		public function set verbose( value:String ):void {
			switch ( value ) {
				case VerboseType.NONE		: {
					Verbose.enabled = false;
					break;
				}
				case VerboseType.FULL		: {
					Verbose.enabled = true;
					Verbose.removeAllFilters();
					break;
				}
				case VerboseType.SIMPLE		: {
					Verbose.enabled = true;
					Verbose.addFilter( ICastObject );
					Verbose.addFilter( Command );
					break;
				}
				default						: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "verbose" ) ); }
			}
			
			_verbose = value;
		}
		private var _verbose:String;
		
		/**
		 * <span lang="ja">Flash Player またはブラウザでのステージの配置を指定する StageAlign クラスの値を取得または設定します。</span>
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
		 * <span lang="ja">Flash Player が使用するレンダリング品質を指定する StageQuality クラスの値を取得または設定します。</span>
		 * <span lang="en">A value from the StageQuality class that specifies which rendering quality is used.</span>
		 */
		[Inspectable( name="quality", type="List", enumeration="best,high,low,medium", defaultValue="high" )]
		public function get quality():String { return _quality; }
		public function set quality( value:String ):void { _quality = value; }
		private var _quality:String = "high";
		
		/**
		 * <span lang="ja">使用する拡大 / 縮小モードを指定する StageScaleMode クラスの値を取得または設定します。</span>
		 * <span lang="en">A value from the StageScaleMode class that specifies which scale mode to use.</span>
		 */
		[Inspectable( name="scaleMode", type="List", enumeration="exactFit,noBorder,noScale,showAll", defaultValue="noScale" )]
		public function get scaleMode():String { return _scaleMode; }
		public function set scaleMode( value:String ):void { _scaleMode = value; }
		private var _scaleMode:String = "noScale";
		
		
		
		
		
		/**
		 * @private
		 */
		public function LoaderComp() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreComp ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "LoaderComp" ) ); }
			
			// すでに作成されていればエラーを送出する
			if ( _instance ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9024" ) ); }
			
			// 登録する
			if ( !( this is PreloaderComp ) ) {
				_instance = this;
			}
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( ComponentEvent.COMPONENT_REMOVED, _componentRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * 初期化処理を実行します。
		 */
		private function _init():void {
			// stage を初期化する
			stage.align = _align || "";
			stage.quality = _quality || "";
			stage.scaleMode = _scaleMode;
		}
		
		
		
		
		
		/**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _componentAdded( e:ComponentEvent ):void {
			// コンポーネントのパラメータ設定を待って実行する
			MovieClipUtil.doLater( null, _init );
		}
		
		/**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _componentRemoved( e:ComponentEvent ):void {
			Verbose.warning( this, VerboseMessageConstants.getMessage( "VERBOSE_0006", this ) );
		}
	}
}
