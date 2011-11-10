/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.display {
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.system.Security;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExMovieClip;
	import jp.nium.events.DocumentEvent;
	import jp.nium.utils.StageUtil;
	
	/*======================================================================*//**
	 * <p>SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.events.DocumentEvent.INIT
	 */
	[Event( name="init", type="jp.nium.events.DocumentEvent" )]
	
	/*======================================================================*//**
	 * <p>ステージのリサイズを開始した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.events.DocumentEvent.RESIZE_START
	 */
	[Event( name="resizeStart", type="jp.nium.events.DocumentEvent" )]
	
	/*======================================================================*//**
	 * <p>ステージがリサイズ処理をしている場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.events.DocumentEvent.RESIZE_PROGRESS
	 */
	[Event( name="resizeProgress", type="jp.nium.events.DocumentEvent" )]
	
	/*======================================================================*//**
	 * <p>ステージのリサイズを終了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.events.DocumentEvent.RESIZE_COMPLETE
	 */
	[Event( name="resizeComplete", type="jp.nium.events.DocumentEvent" )]
	
	/*======================================================================*//**
	 * <p>ExDocument クラスは、ExMovieClip クラスに対してドキュメントクラスとしての機能拡張を追加した表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExDocument extends ExMovieClip {
		
		/*======================================================================*//**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get root():ExDocument { return _root; }
		private static var _root:ExDocument;
		
		/*======================================================================*//**
		 * <p>表示オブジェクトのステージです。</p>
		 * <p>The Stage of the display object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stage():Stage { return _stage; }
		private static var _stage:Stage;
		
		/*======================================================================*//**
		 * <p>この表示オブジェクトが属するファイルのロード情報を含む LoaderInfo インスタンスを返します。</p>
		 * <p>Returns a LoaderInfo object containing information about loading the file to which this display object belongs.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get loaderInfo():LoaderInfo { return _loaderInfo; }
		private static var _loaderInfo:LoaderInfo;
		
		/*======================================================================*//**
		 * <p>ステージの現在の幅をピクセル単位で指定します。</p>
		 * <p>Specifies the current width, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageWidth():int { return Math.max( _stageMinWidth, _stage ? _stage.stageWidth : _stageWidth ); }
		public static function set stageWidth( value:int ):void {
			_stageWidth = Math.max( _stageMinWidth, value );
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.stageWidth = _stageWidth;
				
				// イベントを送出する
				stage.dispatchEvent( new Event( Event.RESIZE ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_START, false, false, _root, _stage ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_PROGRESS, false, false, _root, _stage ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_COMPLETE, false, false, _root, _stage ) );
			}
		}
		private static var _stageWidth:int = 0;
		
		/*======================================================================*//**
		 * <p>ステージの現在の高さをピクセル単位で指定します。</p>
		 * <p>The current height, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageHeight():int { return Math.max( _stageMinHeight, _stage ? stage.stageHeight : _stageHeight ); }
		public static function set stageHeight( value:int ):void {
			_stageHeight = Math.max( _stageMinHeight, value );
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.stageHeight = _stageHeight;
				
				// イベントを送出する
				stage.dispatchEvent( new Event( Event.RESIZE ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_START, false, false, _root, _stage ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_PROGRESS, false, false, _root, _stage ) );
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_COMPLETE, false, false, _root, _stage ) );
			}
		}
		private static var _stageHeight:int = 0;
		
		/*======================================================================*//**
		 * <p>ステージの最小幅をピクセル単位で指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageMinWidth():int { return _stageMinWidth; }
		public static function set stageMinWidth( value:int ):void {
			_stageMinWidth = value;
			
			// 幅を再設定する
			stageWidth = _stageWidth;
		}
		private static var _stageMinWidth:int = 0;
		
		/*======================================================================*//**
		 * <p>ステージの最小高さをピクセル単位で指定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get stageMinHeight():int { return _stageMinHeight; }
		public static function set stageMinHeight( value:int ):void {
			_stageMinHeight = value;
			
			// 高さを再設定する
			stageHeight = _stageHeight;
		}
		private static var _stageMinHeight:int = 0;
		
		/*======================================================================*//**
		 * <p>ロードされたコンテンツの規格幅です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get contentWidth():int { return _contentWidth; }
		private static var _contentWidth:int = 0;
		
		/*======================================================================*//**
		 * <p>ロードされたファイルの規格高さです。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get contentHeight():int { return _contentHeight; }
		private static var _contentHeight:int = 0;
		
		/*======================================================================*//**
		 * <p>ステージ左の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get left():int { return -StageUtil.getMarginLeft( stage ); }
		
		/*======================================================================*//**
		 * <p>ステージ右の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get right():int { return left + stageWidth; }
		
		/*======================================================================*//**
		 * <p>ステージ上の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get top():int { return -StageUtil.getMarginTop( stage ); }
		
		/*======================================================================*//**
		 * <p>ステージ下の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get bottom():int { return top + stageHeight; }
		
		/*======================================================================*//**
		 * <p>ステージ中央の X 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get centerX():int { return right / 2; }
		
		/*======================================================================*//**
		 * <p>ステージ中央の Y 座標を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get centerY():int { return bottom / 2; }
		
		/*======================================================================*//**
		 * <p>Flash Player またはブラウザでのステージの配置を指定する StageAlign クラスの値です。</p>
		 * <p>A value from the StageAlign class that specifies the alignment of the stage in Flash Player or the browser.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get align():String { return _align; }
		public static function set align( value:String ):void {
			if ( !value ) { return; }
			
			_align = value;
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.align = _align;
			}
		}
		private static var _align:String;
		
		/*======================================================================*//**
		 * <p>使用する表示状態を指定する StageDisplayState クラスの値です。</p>
		 * <p>A value from the StageDisplayState class that specifies which display state to use.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get displayState():String { return _stage ? _stage.displayState : _displayState; }
		public static function set displayState( value:String ):void {
			if ( !value ) { return; }
			
			_displayState = value;
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.displayState = _displayState;
			}
		}
		private static var _displayState:String;
		
		/*======================================================================*//**
		 * <p>ステージのフレームレートを取得または設定します。</p>
		 * <p>Gets and sets the frame rate of the stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get frameRate():Number { return _stage ? _stage.frameRate : _frameRate; }
		public static function set frameRate( value:Number ):void {
			_frameRate = value;
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.frameRate = _frameRate;
			}
		}
		private static var _frameRate:Number = 1;
		
		/*======================================================================*//**
		 * <p>Flash Player が使用するレンダリング品質を指定する StageQuality クラスの値です。</p>
		 * <p>A value from the StageQuality class that specifies which rendering quality is used.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get quality():String { return _stage ? _stage.quality : _quality; }
		public static function set quality( value:String ):void {
			if ( !value ) { return; }
			
			_quality = value;
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.quality = _quality;
			}
		}
		private static var _quality:String;
		
		/*======================================================================*//**
		 * <p>使用する拡大 / 縮小モードを指定する StageScaleMode クラスの値です。</p>
		 * <p>A value from the StageScaleMode class that specifies which scale mode to use.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get scaleMode():String { return _stage ? _stage.scaleMode : _scaleMode; }
		public static function set scaleMode( value:String ):void {
			if ( !value ) { return; }
			
			_scaleMode = value;
			
			// stage の参照が存在していれば
			if ( _stage ) {
				_stage.scaleMode = _scaleMode;
			}
		}
		private static var _scaleMode:String;
		
		/*======================================================================*//**
		 * <p>SWF ファイルがオンライン上で実行されているかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function get isOnline():Boolean { return _isOnline; }
		private static var _isOnline:Boolean = function():Boolean {
			switch ( Security.sandboxType ) {
				case Security.REMOTE				: { return true; }
				case Security.LOCAL_WITH_FILE		:
				case Security.LOCAL_WITH_NETWORK	:
				case Security.LOCAL_TRUSTED			:
				default								: { return false; }
			}
			
			return false;
		}.apply();
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ExDocument インスタンスの画面上の表示 X 座標を常に SWF ファイルエリアの中央とするかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get centeringX():Boolean { return _centeringX; }
		public function set centeringX( value:Boolean ):void {
			_centeringX = value;
			
			// 位置を調節する
			super.x = value ? Math.round( centerX ) : 0;
		}
		private var _centeringX:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ExDocument インスタンスの画面上の表示 Y 座標を常に SWF ファイルエリアの中央とするかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get centeringY():Boolean { return _centeringY; }
		public function set centeringY( value:Boolean ):void {
			_centeringY = value;
			
			// 位置を調節する
			super.y = value ? Math.round( centerY )  : 0;
		}
		private var _centeringY:Boolean = false;
		
		/*======================================================================*//**
		 * <p>親 DisplayObjectContainer のローカル座標を基準にした DisplayObject インスタンスの x 座標を示します。
		 * この値は centering プロパティが true に設定されている場合には変更できません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function get x():Number { return super.x; }
		public override function set x( value:Number ):void {
			// センタリング状態であれば終了する
			if ( _centeringX ) { return; }
			
			// 位置を調節する
			super.x = value;
		}
		
		/*======================================================================*//**
		 * <p>親 DisplayObjectContainer のローカル座標を基準にした DisplayObject インスタンスの y 座標を示します。
		 * この値は centering プロパティが true に設定されている場合には変更できません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function get y():Number { return super.y; }
		public override function set y( value:Number ):void {
			// センタリング状態であれば終了する
			if ( _centeringY ) { return; }
			
			// 位置を調節する
			super.y = value;
		}
		
		/*======================================================================*//**
		 * 前回のステージサイズを取得します。
		 */
		private var _oldStageWidth:int = 0;
		private var _oldStageHeight:int = 0;
		
		/*======================================================================*//**
		 * 
		 */
		private var _addedToStaged:Boolean = false;
		
		/*======================================================================*//**
		 * 
		 */
		private var _loaderInited:Boolean = false;
		
		/*======================================================================*//**
		 * 
		 */
		private var _loaderCompleted:Boolean = false;
		
		/*======================================================================*//**
		 * 初期化が完了しているかどうかを取得します。
		 */
		private var _initialized:Boolean = false;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ExDocument インスタンスを作成します。</p>
		 * <p>Creates a new ExDocument object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function ExDocument() {
			// root が存在しない、もしくは自身が root ではなければ
			if ( !root || this != root ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8001", className ) ); }
			
			// 初期化する
			_root = this;
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
			loaderInfo.addEventListener( Event.INIT, _init, false, int.MAX_VALUE, true );
			loaderInfo.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
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
			return _stage ? StageUtil.toSWFBasePath( _stage, url ) : "";
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
			_root.addEventListener( type, listener, useCapture, priority, useWeakReference );
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
			_root.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
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
			_root.removeEventListener( type, listener, useCapture );
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
			_root.completelyRemoveEventListener( type, listener, useCapture );
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
			return _root.dispatchEvent( event );
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
			return _root.hasEventListener( type );
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
			return _root.willTrigger( type );
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
			_root.removeAllListeners( completely );
		}
		
		/*======================================================================*//**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static function restoreRemovedListeners():void {
			_root.restoreRemovedListeners();
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 
		 */
		private function _initialize():void {
			if ( _initialized ) { return; }
			if ( !_loaderInited ) { return; }
			if ( !_loaderCompleted ) { return; }
			if ( !_addedToStaged ) { return; }
			
			// 初期化を完了する
			_initialized = true;
			
			// イベントリスナーを追加する
			_stage.addEventListener( Event.RESIZE, _resizeStart, false, int.MAX_VALUE, true );
			
			// イベントを送出する
			dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_START, false, false, this, _stage ) );
			dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_PROGRESS, false, false, this, _stage ) );
			dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_COMPLETE, false, false, this, _stage ) );
			dispatchEvent( new DocumentEvent( DocumentEvent.INIT, false, false, this, _stage ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// stage の参照を保存する
			_stage = stage;
			
			// 初期化する
			stageWidth = _stageWidth;
			stageHeight = _stageHeight;
			align = _align;
			displayState = _displayState;
			quality = _quality;
			scaleMode = _scaleMode;
			
			// stage への設置を完了する
			_addedToStaged = true;
			
			_initialize();
		}
		
		/*======================================================================*//**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// stage の参照を削除する
			_stage = null;
		}
		
		/*======================================================================*//**
		 * SWF ファイルの読み込みが完了した場合に送出されます。
		 */
		private function _init( e:Event ):void {
			// イベントリスナーを解除する
			loaderInfo.removeEventListener( Event.INIT, _init );
			
			// 初期化する
			_loaderInfo = loaderInfo;
			_frameRate = _loaderInfo.frameRate;
			_contentWidth = _loaderInfo.width;
			_contentHeight = _loaderInfo.height;
			
			_loaderInited = true;
			
			_initialize();
		}
		
		/*======================================================================*//**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントリスナーを解除する
			loaderInfo.removeEventListener( Event.COMPLETE, _complete );
			
			_loaderCompleted = true;
			
			_initialize();
		}
		
		/*======================================================================*//**
		 * ステージのリサイズを開始した場合に送出されます。
		 */
		private function _resizeStart( e:Event ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( Event.RESIZE, _resizeStart );
			
			// イベントを送出する
			dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_START, false, false, this, _stage ) );
			stage.dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_START, false, false, this, _stage ) );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ENTER_FRAME, _resizeProgress, false, int.MAX_VALUE, true );
		}
		
		/*======================================================================*//**
		 * ステージがリサイズ処理をしている場合に送出されます。
		 */
		private function _resizeProgress( e:Event ):void {
			// 位置を調節する
			centeringX = _centeringX;
			centeringY = _centeringY;
			
			// イベントを送出する
			dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_PROGRESS, false, false, this, _stage ) );
			stage.dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_PROGRESS, false, false, this, _stage ) );
			
			// 前回とサイズが変更されていなければ、イベントを送出する
			if ( _oldStageWidth == stageWidth && _oldStageHeight == stageHeight ) {
				// イベントを送出する
				dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_COMPLETE, false, false, this, _stage ) );
				stage.dispatchEvent( new DocumentEvent( DocumentEvent.RESIZE_COMPLETE, false, false, this, _stage ) );
				
				// イベントリスナーを解除する
				completelyRemoveEventListener( Event.ENTER_FRAME, _resizeProgress );
				
				// イベントリスナーを登録する
				_stage.addEventListener( Event.RESIZE, _resizeStart, false, int.MAX_VALUE, true );
			}
			
			// 現在のサイズを保存する
			_oldStageWidth = stageWidth;
			_oldStageHeight = stageHeight;
		}
	}
}









