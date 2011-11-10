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
package jp.progression.casts {
	import flash.display.LoaderInfo;
	import flash.events.EventPhase;
	import flash.display.Stage;
	import flash.events.Event;
	import jp.nium.display.ExDocument;
	import jp.nium.events.DocumentEvent;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.ui.ToolTip;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED
	 */
	[Event( name="castAdded", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED
	 */
	[Event( name="castRemoved", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">CastDocument クラスは、ExDocument クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CastDocument extends ExDocument implements ICastObject {
		
		/**
		 * <span lang="ja">ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</span>
		 * <span lang="en">For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</span>
		 */
		public static function get root():CastDocument { return CastDocument( ExDocument.root ); }
		
		/**
		 * <span lang="ja">表示オブジェクトのステージです。</span>
		 * <span lang="en">The Stage of the display object.</span>
		 */
		public static function get stage():Stage { return ExDocument.stage; }
		
		/**
		 * <span lang="ja">この表示オブジェクトが属するファイルのロード情報を含む LoaderInfo インスタンスを返します。</span>
		 * <span lang="en">Returns a LoaderInfo object containing information about loading the file to which this display object belongs.</span>
		 */
		public static function get loaderInfo():LoaderInfo { return ExDocument.loaderInfo; }
		
		/**
		 * <span lang="ja">ステージの現在の幅をピクセル単位で指定します。</span>
		 * <span lang="en">Specifies the current width, in pixels, of the Stage.</span>
		 */
		public static function get stageWidth():int { return ExDocument.stageWidth; }
		public static function set stageWidth( value:int ):void { ExDocument.stageWidth = value; }
		
		/**
		 * <span lang="ja">ステージの現在の高さをピクセル単位で指定します。</span>
		 * <span lang="en">The current height, in pixels, of the Stage.</span>
		 */
		public static function get stageHeight():int { return ExDocument.stageHeight; }
		public static function set stageHeight( value:int ):void { ExDocument.stageHeight = value; }
		
		/**
		 * <span lang="ja">ステージの最小幅をピクセル単位で指定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get stageMinWidth():int { return ExDocument.stageMinWidth; }
		public static function set stageMinWidth( value:int ):void { ExDocument.stageMinWidth = value; }
		
		/**
		 * <span lang="ja">ステージの最小高さをピクセル単位で指定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get stageMinHeight():int { return ExDocument.stageMinHeight; }
		public static function set stageMinHeight( value:int ):void { ExDocument.stageMinHeight = value; }
		
		/**
		 * <span lang="ja">ロードされたコンテンツの規格幅です。</span>
		 * <span lang="en"></span>
		 */
		public static function get contentWidth():int { return ExDocument.contentWidth; }
		
		/**
		 * <span lang="ja">ロードされたファイルの規格高さです。</span>
		 * <span lang="en"></span>
		 */
		public static function get contentHeight():int { return ExDocument.contentHeight; }
		
		/**
		 * <span lang="ja">ステージ左の X 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get left():int { return ExDocument.left; }
		
		/**
		 * <span lang="ja">ステージ右の X 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get right():int { return ExDocument.right; }
		
		/**
		 * <span lang="ja">ステージ上の Y 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get top():int { return ExDocument.top; }
		
		/**
		 * <span lang="ja">ステージ下の Y 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get bottom():int { return ExDocument.bottom; }
		
		/**
		 * <span lang="ja">ステージ中央の X 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get centerX():int { return ExDocument.centerX; }
		
		/**
		 * <span lang="ja">ステージ中央の Y 座標を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get centerY():int { return ExDocument.centerY; }
		
		/**
		 * <span lang="ja">Flash Player またはブラウザでのステージの配置を指定する StageAlign クラスの値です。</span>
		 * <span lang="en">A value from the StageAlign class that specifies the alignment of the stage in Flash Player or the browser.</span>
		 */
		public static function get align():String { return ExDocument.align; }
		public static function set align( value:String ):void { ExDocument.align = value; }
		
		/**
		 * <span lang="ja">使用する表示状態を指定する StageDisplayState クラスの値です。</span>
		 * <span lang="en">A value from the StageDisplayState class that specifies which display state to use.</span>
		 */
		public static function get displayState():String { return ExDocument.displayState; }
		public static function set displayState( value:String ):void { ExDocument.displayState = value; }
		
		/**
		 * <span lang="ja">ステージのフレームレートを取得または設定します。</span>
		 * <span lang="en">Gets and sets the frame rate of the stage.</span>
		 */
		public static function get frameRate():Number { return ExDocument.frameRate; }
		public static function set frameRate( value:Number ):void { ExDocument.frameRate = value; }
		
		/**
		 * <span lang="ja">Flash Player が使用するレンダリング品質を指定する StageQuality クラスの値です。</span>
		 * <span lang="en">A value from the StageQuality class that specifies which rendering quality is used.</span>
		 */	
		public static function get quality():String { return ExDocument.quality; }
		public static function set quality( value:String ):void { ExDocument.quality = value; }
		
		/**
		 * <span lang="ja">使用する拡大 / 縮小モードを指定する StageScaleMode クラスの値です。</span>
		 * <span lang="en">A value from the StageScaleMode class that specifies which scale mode to use.</span>
		 */
		public static function get scaleMode():String { return ExDocument.scaleMode; }
		public static function set scaleMode( value:String ):void { ExDocument.scaleMode = value; }
		
		/**
		 * <span lang="ja">SWF ファイルがオンライン上で実行されているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get isOnline():Boolean { return ExDocument.isOnline; }
		
		
		
		
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _castObject.parallelMode; }
		public function set parallelMode( value:Boolean ):void { _castObject.parallelMode = value; }
		
		/**
		 * <span lang="ja">このオブジェクトに関連付けられている ToolTip インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get toolTip():ToolTip { return _toolTip; }
		private var _toolTip:ToolTip;
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _castObject.executor; }
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _castObject.eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _castObject.eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( DocumentEvent.INIT, _init, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( DocumentEvent.INIT, _init );
			}
		}
		
		/**
		 * <span lang="ja">このオブジェクトに関連付けられている CastObjectContextMenu インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get uiContextMenu():CastObjectContextMenu { return _uiContextMenu; }
		private var _uiContextMenu:CastObjectContextMenu;
		
		/**
		 * <span lang="ja">SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に呼び出されるイベントハンドラメソッドを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get onInit():Function { return __onInit || _onInit; }
		public function set onInit( value:Function ):void { __onInit = value; }
		private var __onInit:Function;
		
		/**
		 * <span lang="ja">サブクラスで onInit イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onInit プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onInit():void {}
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastAdded():Function { return __onCastAdded || _onCastAdded; }
		public function set onCastAdded( value:Function ):void { __onCastAdded = value; }
		private var __onCastAdded:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastAdded イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastAdded プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastAdded():void {}
		
		/**
		 * <span lang="ja">キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastRemoved():Function { return __onCastRemoved || _onCastRemoved; }
		public function set onCastRemoved( value:Function ):void { __onCastRemoved = value; }
		private var __onCastRemoved:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastRemoved イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRemoved プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastRemoved():void {}
		
		/**
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastMovieClip インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastMovieClip object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function CastDocument( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			Object( this )._initContextMenu();
			
			// 初期化する
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED, _added, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された URL ストリングを SWF ファイルの設置されているフォルダを基準とした URL に変換して返します。
		 * 絶対パスが指定された場合には、そのまま返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">変換したい URL のストリング表現です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">変換された URL のストリング表現です。</span>
		 * <span lang="en"></span>
		 */
		public static function toSWFBasePath( url:String ):String {
			return ExDocument.toSWFBasePath( url );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function addCommand( ... commands:Array ):void {
			_castObject.addCommand.apply( this, commands );
		}
		
		/**
		 * <span lang="ja">特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param commands
		 * <span lang="ja">登録したいコマンドを含む配列です。</span>
		 * <span lang="en"></span>
		 */
		public function insertCommand( ... commands:Array ):void {
			_castObject.insertCommand.apply( this, commands );
		}
		
		/**
		 * <span lang="ja">登録されている Command インスタンスを削除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param completely
		 * <span lang="ja">true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</span>
		 * <span lang="en"></span>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			_castObject.clearCommand( completely );
		}
		
		
		
		
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		private function _init( e:DocumentEvent ):void {
			// イベントハンドラメソッドを実行する
			onInit();
		}
		
		/**
		 * 表示オブジェクトが表示リストに追加されたときに送出されます。
		 */
		private function _added( e:Event ):void {
			// イベントがターゲット段階ではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// ICommandExecutable を取得する
			var executable:ICommandExecutable = parent as ICommandExecutable;
			
			// 存在すれば登録する
			if ( executable ) {
				executable.executor.progression_internal::__addExecutable( this );
			}
		}
		
		/**
		 * 表示オブジェクトが表示リストから削除されようとしているときに送出されます。
		 */
		private function _removed( e:Event ):void {
			// イベントがターゲット段階ではなければ終了する
			if ( e.eventPhase != EventPhase.AT_TARGET ) { return; }
			
			// ICommandExecutable を取得する
			var executable:ICommandExecutable = parent as ICommandExecutable;
			
			// 存在すれば登録を削除する
			if ( executable ) {
				executable.executor.progression_internal::__removeExecutable( this );
			}
		}
		
		
		
		
		
		/**
		 * 
		 */
		include "../core/includes/CastObject_contextMenu.inc"
	}
}
