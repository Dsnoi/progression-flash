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
package jp.progression.casts {
	import flash.display.LoaderInfo;
	import flash.events.EventPhase;
	//import flash.display.NativeMenu;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExDocument;
	import jp.nium.events.DocumentEvent;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.ui.ToolTip;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>ICastObject オブジェクトが AddChild コマンド、または AddChildAt コマンド経由でディスプレイリストに追加された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_ADDED
	 */
	[Event( name="castAdded", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>ICastObject オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由でディスプレイリストから削除された場合に送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CastEvent.CAST_REMOVED
	 */
	[Event( name="castRemoved", type="jp.progression.events.CastEvent" )]
	
	/*======================================================================*//**
	 * <p>CastDocument クラスは、ExDocument クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CastDocument extends ExDocument implements ICastObject {
		
		/*======================================================================*//**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get root():CastDocument { return CastDocument( ExDocument.root ); }
		
		/*======================================================================*//**
		 * <p>表示オブジェクトのステージです。</p>
		 * <p>The Stage of the display object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stage():Stage { return ExDocument.stage; }
		
		/*======================================================================*//**
		 * <p>この表示オブジェクトが属するファイルのロード情報を含む LoaderInfo インスタンスを返します。</p>
		 * <p>Returns a LoaderInfo object containing information about loading the file to which this display object belongs.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get loaderInfo():LoaderInfo { return ExDocument.loaderInfo; }
		
		/*======================================================================*//**
		 * <p>ステージの現在の幅をピクセル単位で指定します。</p>
		 * <p>Specifies the current width, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageWidth():int { return ExDocument.stageWidth; }
		public static function set stageWidth( value:int ):void { ExDocument.stageWidth = value; }
		
		/*======================================================================*//**
		 * <p>ステージの現在の高さをピクセル単位で指定します。</p>
		 * <p>The current height, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageHeight():int { return ExDocument.stageHeight; }
		public static function set stageHeight( value:int ):void { ExDocument.stageHeight = value; }
		
		/*======================================================================*//**
		 * <p>ステージの最小幅をピクセル単位で指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageMinWidth():int { return ExDocument.stageMinWidth; }
		public static function set stageMinWidth( value:int ):void { ExDocument.stageMinWidth = value; }
		
		/*======================================================================*//**
		 * <p>ステージの最小高さをピクセル単位で指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageMinHeight():int { return ExDocument.stageMinHeight; }
		public static function set stageMinHeight( value:int ):void { ExDocument.stageMinHeight = value; }
		
		/*======================================================================*//**
		 * <p>ロードされたコンテンツの規格幅です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get contentWidth():int { return ExDocument.contentWidth; }
		
		/*======================================================================*//**
		 * <p>ロードされたファイルの規格高さです。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get contentHeight():int { return ExDocument.contentHeight; }
		
		/*======================================================================*//**
		 * <p>ステージ左の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get left():int { return ExDocument.left; }
		
		/*======================================================================*//**
		 * <p>ステージ右の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get right():int { return ExDocument.right; }
		
		/*======================================================================*//**
		 * <p>ステージ上の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get top():int { return ExDocument.top; }
		
		/*======================================================================*//**
		 * <p>ステージ下の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get bottom():int { return ExDocument.bottom; }
		
		/*======================================================================*//**
		 * <p>ステージ中央の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get centerX():int { return ExDocument.centerX; }
		
		/*======================================================================*//**
		 * <p>ステージ中央の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get centerY():int { return ExDocument.centerY; }
		
		/*======================================================================*//**
		 * <p>Flash Player またはブラウザでのステージの配置を指定する StageAlign クラスの値です。</p>
		 * <p>A value from the StageAlign class that specifies the alignment of the stage in Flash Player or the browser.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get align():String { return ExDocument.align; }
		public static function set align( value:String ):void { ExDocument.align = value; }
		
		/*======================================================================*//**
		 * <p>使用する表示状態を指定する StageDisplayState クラスの値です。</p>
		 * <p>A value from the StageDisplayState class that specifies which display state to use.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get displayState():String { return ExDocument.displayState; }
		public static function set displayState( value:String ):void { ExDocument.displayState = value; }
		
		/*======================================================================*//**
		 * <p>ステージのフレームレートを取得または設定します。</p>
		 * <p>Gets and sets the frame rate of the stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get frameRate():Number { return ExDocument.frameRate; }
		public static function set frameRate( value:Number ):void { ExDocument.frameRate = value; }
		
		/*======================================================================*//**
		 * <p>Flash Player が使用するレンダリング品質を指定する StageQuality クラスの値です。</p>
		 * <p>A value from the StageQuality class that specifies which rendering quality is used.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */	
		public static function get quality():String { return ExDocument.quality; }
		public static function set quality( value:String ):void { ExDocument.quality = value; }
		
		/*======================================================================*//**
		 * <p>使用する拡大 / 縮小モードを指定する StageScaleMode クラスの値です。</p>
		 * <p>A value from the StageScaleMode class that specifies which scale mode to use.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get scaleMode():String { return ExDocument.scaleMode; }
		public static function set scaleMode( value:String ):void { ExDocument.scaleMode = value; }
		
		/*======================================================================*//**
		 * <p>SWF ファイルがオンライン上で実行されているかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get isOnline():Boolean { return ExDocument.isOnline; }
		
		
		
		
		
		/*======================================================================*//**
		 * <p>CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parallelMode():Boolean { return _castObject.parallelMode; }
		public function set parallelMode( value:Boolean ):void { _castObject.parallelMode = value; }
		
		/*======================================================================*//**
		 * <p>このオブジェクトに関連付けられている ToolTip インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get toolTip():ToolTip { return _toolTip; }
		private var _toolTip:ToolTip;
		
		/*======================================================================*//**
		 * <p>コマンドを実行する CommandExecutor インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get executor():CommandExecutor { return _castObject.executor; }
		
		/*======================================================================*//**
		 * <p>オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>このオブジェクトに関連付けられている CastObjectContextMenu インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get uiContextMenu():CastObjectContextMenu { return _uiContextMenu; }
		private var _uiContextMenu:CastObjectContextMenu;
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get contextMenu():ContextMenu { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9022" ) ); }
		public override function set contextMenu( value:ContextMenu ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9022" ) ); }
		//public override function get contextMenu():NativeMenu { return super.contextMenu; }
		//public override function set contextMenu( value:NativeMenu ):void { super.contextMenu = value; }
		
		/*======================================================================*//**
		 * <p>SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に呼び出されるイベントハンドラメソッドを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onInit():Function { return __onInit || _onInit; }
		public function set onInit( value:Function ):void { __onInit = value; }
		private var __onInit:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onInit イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onInit プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onInit():void {}
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_ADDED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastAdded():Function { return __onCastAdded || _onCastAdded; }
		public function set onCastAdded( value:Function ):void { __onCastAdded = value; }
		private var __onCastAdded:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastAdded イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastAdded プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastAdded():void {}
		
		/*======================================================================*//**
		 * <p>キャストオブジェクトが CastEvent.CAST_REMOVED イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get onCastRemoved():Function { return __onCastRemoved || _onCastRemoved; }
		public function set onCastRemoved( value:Function ):void { __onCastRemoved = value; }
		private var __onCastRemoved:Function;
		
		/*======================================================================*//**
		 * <p>サブクラスで onCastRemoved イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRemoved プロパティに、別のメソッドを設定された場合は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		protected function _onCastRemoved():void {}
		
		/*======================================================================*//**
		 * CastObject インスタンスを取得します。
		 */
		private var _castObject:CastObject;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CastMovieClip インスタンスを作成します。</p>
		 * <p>Creates a new CastMovieClip object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function CastDocument( initObject:Object = null ) {
			// CastObject を作成する
			_castObject = new CastObject( this );
			
			// スーパークラスを初期化する
			super();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastObjectContextMenu を作成する
			_uiContextMenu = CastObjectContextMenu.progression_internal::__createInstance( this, super.contextMenu = new ContextMenu() );
			
			// 初期化する
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED, _added, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED, _removed, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された URL ストリングを SWF ファイルの設置されているフォルダを基準とした URL に変換して返します。
		 * 絶対パスが指定された場合には、そのまま返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param url
		 * 	<p>変換したい URL のストリング表現です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>変換された URL のストリング表現です。</p>
		 * 	<p></p>
		 */
		public static function toSWFBasePath( url:String ):String {
			return ExDocument.toSWFBasePath( url );
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public static function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			ExDocument.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーは、IEventIntegrator インスタンスの管理外となるため、removeEventListener() メソッドで削除した場合にも、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public static function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			ExDocument.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			ExDocument.removeEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public static function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			ExDocument.completelyRemoveEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>イベントをイベントフローに送出します。</p>
		 * <p>Dispatches an event into the event flow.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</p>
		 * 	<p>The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</p>
		 * @return
		 * 	<p>値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</p>
		 * 	<p>A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</p>
		 */
		public static function dispatchEvent( event:Event ):Boolean {
			return ExDocument.dispatchEvent( event );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</p>
		 * <p>Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type is registered; false otherwise.</p>
		 */
		public static function hasEventListener( type:String ):Boolean {
			return ExDocument.hasEventListener( type );
		}
		
		/*======================================================================*//**
		 * <p>指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</p>
		 * <p>Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type will be triggered; false otherwise.</p>
		 */
		public static function willTrigger( type:String ):Boolean {
			return ExDocument.willTrigger( type );
		}
		
		/*======================================================================*//**
		 * <p>addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>情報を完全に削除するかどうかです。</p>
		 * 	<p></p>
		 */
		public static function removeAllListeners( completely:Boolean = false ):void {
			ExDocument.removeAllListeners( completely );
		}
		
		/*======================================================================*//**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function restoreRemovedListeners():void {
			ExDocument.restoreRemovedListeners();
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをリストの最後尾に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 */
		public function addCommand( ... commands:Array ):void {
			_castObject.addCommand.apply( this, commands );
		}
		
		/*======================================================================*//**
		 * <p>特定のイベントが送出された際に、自動実行させたい Command インスタンスをすでにリストに登録され、実行中の Command インスタンスの次の位置に追加します。
		 * 追加された Command インスタンスは、イベントが送出される直前に自動的に削除されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param commands
		 * 	<p>登録したいコマンドを含む配列です。</p>
		 * 	<p></p>
		 */
		public function insertCommand( ... commands:Array ):void {
			_castObject.insertCommand.apply( this, commands );
		}
		
		/*======================================================================*//**
		 * <p>登録されている Command インスタンスを削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>true が設定されている場合は登録されている全てのコマンド登録を解除し、false の場合には現在処理中のコマンド以降の登録を解除します。</p>
		 * 	<p></p>
		 */
		public function clearCommand( completely:Boolean = false ):void {
			_castObject.clearCommand( completely );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		private function _init( e:DocumentEvent ):void {
			// イベントハンドラメソッドを実行する
			onInit();
		}
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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
	}
}









