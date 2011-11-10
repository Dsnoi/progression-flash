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
package jp.progression.casts {
	import com.asual.swfaddress.SWFAddress;
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import jp.progression.core.collections.SceneCollection;
	import jp.progression.events.SceneEvent;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.display.ExMovieClip;
	import jp.nium.external.BrowserInterface;
	import jp.progression.Progression;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.events.CollectionEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastButtonContextMenu;
	import jp.progression.core.ui.ToolTip;
	import jp.progression.core.utils.SceneIdUtil;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CastMouseEvent;
	import jp.progression.events.CommandEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en">Dispatched when a user presses the pointing device button over an CastButton instance.
	 * </span>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_DOWN
	 */
	[Event( name="castMouseDown", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <span lang="ja">ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en">Dispatched when a user releases the pointing device button over an CastButton instance.
	 * </span>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_MOUSE_UP
	 */
	[Event( name="castMouseUp", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <span lang="ja">ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en">Dispatched when the user moves a pointing device away from an CastButton instance.
	 * </span>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OVER
	 */
	[Event( name="castRollOver", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <span lang="ja">ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
	 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
	 * <span lang="en">Dispatched when the user moves a pointing device away from an CastButton instance.
	 * </span>
	 * 
	 * @eventType jp.progression.events.CastMouseEvent.CAST_ROLL_OUT
	 */
	[Event( name="castRollOut", type="jp.progression.events.CastMouseEvent" )]
	
	/**
	 * <span lang="ja">CastButton インスタンスと Progression インスタンスとの関連付けが更新されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.UPDATE
	 */
	[Event( name="update", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">CastButton インスタンスと関連付けられた Progression インスタンスのシーン状態に対応して、ボタンの状態が変更されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.STATUS_CHANGE
	 */
	[Event( name="statusChange", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">オブジェクトの buttonEnabled プロパティの値が変更されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CastEvent.BUTTON_ENABLED_CHANGE
	 */
	[Event( name="buttonEnabledChange", type="jp.progression.events.CastEvent" )]
	
	/**
	 * <span lang="ja">CastButton クラスは、ExMovieClip クラスの基本機能を拡張し、イベントフローとの連携機能を実装した jp.progression パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // CastButton を作成する
	 * var cast:CastButton = new CastButton();
	 * cast.graphics.beginFill( 0xFF000000 );
	 * cast.graphics.drawRect( 0, 0, 100, 100 );
	 * cast.graphics.endFill();
	 * 
	 * // Progression インスタンスを作成する
	 * var prog:Progression = new Progression( "index", stage );
	 * 
	 * // ルートシーンのイベントハンドラメソッドを設定します。
	 * prog.root.onLoad = function():void {
	 * 	// コマンドを実行する
	 * 	this.addCommand(
	 * 		// CastButton を画面に表示する
	 * 		new AddChild( prog.container, cast )
	 * 	);
	 * };
	 * prog.root.onInit = function():void {
	 * 	// コマンドを実行する
	 * 	this.addCommand(
	 * 		// CastButton を画面から削除する
	 * 		new RemoveChild( prog.container, cast )
	 * 	);
	 * };
	 * 
	 * // ルートシーンに移動します。
	 * prog.goto( new SceneId( "/index" ) );
	 * </listing>
	 */
	public class CastButton extends ExMovieClip implements ICastObject {
		
		/**
		 * アクセスキーを判別する正規表現を取得します。
		 */
		private static const _ACCESSKEY_REGEXP:RegExp = new RegExp( "^[a-z]?$", "i" );
		
		
		
		
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先を示すシーン識別子を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</span>
		 * <span lang="en"></span>
		 */
		public function get sceneId():SceneId { return _sceneId; }
		public function set sceneId( value:SceneId ):void {
			_sceneId = value;
			
			// 更新する
			_updateProgression();
		}
		private var _sceneId:SceneId;
		
		/**
		 * <span lang="ja">関連付けられている Progression インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get progression():Progression { return _progression; }
		private var _progression:Progression;
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先の URL を取得または設定します。
		 * sceneId プロパティと href プロパティが両方とも設定されている場合には、href プロパティの設定が優先されます。</span>
		 * <span lang="en"></span>
		 */
		public function get href():String { return _href; }
		public function set href( value:String ):void { _href = value; }
		private var _href:String;
		
		/**
		 * <span lang="ja">ボタンがクリックされた時の移動先を開くウィンドウ名を取得または設定します。
		 * この値が "_self" または null に設定されている場合には、現在のウィンドウを示します。</span>
		 * <span lang="en"></span>
		 */
		public function get windowTarget():String { return _windowTarget; }
		public function set windowTarget( value:String ):void { _windowTarget = value; }
		private var _windowTarget:String;
		
		/**
		 * <span lang="ja">現在のボタンの移動先 URL を示すストリングを取得します。
		 * この値はブラウザ上で実行した際に sceneId プロパティと href プロパティの値から決定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get navigateURL():String {
			// href が存在すれば
			if ( _href ) { return _href; }
			
			// sceneId が存在すれば
			if ( _progression && _progression.sync && BrowserInterface.enabled ) { return BrowserInterface.locationHref.split( "#" )[0] + "#" + SceneIdUtil.toShortPath( _sceneId ); }
			
			return "";
		}
		
		/**
		 * <span lang="ja">ボタンモードを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get buttonEnabled():Boolean { return _buttonEnabled; }
		public function set buttonEnabled( value:Boolean ):void {
			if ( _buttonEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( MouseEvent.MOUSE_DOWN, _mouseDown, false, int.MAX_VALUE, true );
				addExclusivelyEventListener( MouseEvent.MOUSE_UP, _mouseUp, false, int.MAX_VALUE, true );
				addExclusivelyEventListener( MouseEvent.ROLL_OVER, _rollOver, false, int.MAX_VALUE, true );
				addExclusivelyEventListener( MouseEvent.ROLL_OUT, _rollOut, false, int.MAX_VALUE, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
				completelyRemoveEventListener( MouseEvent.MOUSE_UP, _mouseUp );
				completelyRemoveEventListener( MouseEvent.ROLL_OVER, _rollOver );
				completelyRemoveEventListener( MouseEvent.ROLL_OUT, _rollOut );
			}
			
			// プロパティを設定する
			super.buttonMode = value;
			super.useHandCursor = value;
			
			// イベントを送出する
			dispatchEvent( new CastEvent( CastEvent.BUTTON_ENABLED_CHANGE ) );
		}
		private var _buttonEnabled:Boolean = true;
		
		/**
		 * @private
		 */
		public override function get buttonMode():Boolean { return true; }
		public override function set buttonMode( value:Boolean ):void {}
		
		/**
		 * @private
		 */
		public override function get useHandCursor():Boolean { return true; }
		public override function set useHandCursor( value:Boolean ):void {}
		
		/**
		 * <span lang="ja">ボタンの機能をキーボードから使用するためのアクセスキーを取得または設定します。
		 * 設定できるキーはアルファベットの A ～ Z までの値です。</span>
		 * <span lang="en"></span>
		 */
		public function get accessKey():String { return _accessKey; }
		public function set accessKey( value:String ):void {
			if ( !_ACCESSKEY_REGEXP.test( value ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9012" ) ); }
			
			_accessKey = value;
			
			// Accessibility を更新する
			accessibilityProperties.shortcut = value;
			if ( Accessibility.active ) {
				Accessibility.updateProperties();
			}
		}
		private var _accessKey:String;
		
		/**
		 * <span lang="ja">sceneId プロパティに設定されているシーン識別子の示すシーンと現在のシーンを比較して、自身がカレントシーンを示しているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isCurrent():Boolean { return _isCurrent; }
		private var _isCurrent:Boolean = false;
		
		/**
		 * <span lang="ja">sceneId プロパティに設定されているシーン識別子の示すシーンと現在のシーンを比較して、自身が親シーンを示しているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isParent():Boolean { return _isParent; }
		private var _isParent:Boolean = false;
		
		/**
		 * <span lang="ja">sceneId プロパティに設定されているシーン識別子の示すシーンと現在のシーンを比較して、自身が子シーンを示しているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isChild():Boolean { return _isChild; }
		private var _isChild:Boolean = false;
		
		/**
		 * <span lang="ja">CastButton インスタンスにポインティングデバイスが合わされているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isRollOver():Boolean { return _isRollOver; }
		private var _isRollOver:Boolean = false;
		
		/**
		 * <span lang="ja">CastButton インスタンスでポインティングデバイスのボタンを押されているかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get isMouseDown():Boolean { return _isMouseDown; }
		private var _isMouseDown:Boolean = false;
		
		/**
		 * CTRL キー、または SHIFT キーが押されているかどうかを取得します。
		 */
		private var _isCTRLorShiftKeyDown:Boolean = false;
		
		/**
		 * 新しいウィンドウを開くかどうかを取得します。
		 */
		private var _openNewWindow:Boolean = false;
		
		/**
		 * <span lang="ja">CommandExecutor の実行方法を並列処理にするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get parallelMode():Boolean { return _executor.progression_internal::__parallelMode; }
		public function set parallelMode( value:Boolean ):void { _executor.progression_internal::__parallelMode = value; }
		
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
		public function get executor():CommandExecutor { return _executor; }
		private var _executor:CommandExecutor;
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown, false, 0, true );
				addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp, false, 0, true );
				addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver, false, 0, true );
				addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown );
				completelyRemoveEventListener( CastMouseEvent.CAST_MOUSE_UP, _castMouseUp );
				completelyRemoveEventListener( CastMouseEvent.CAST_ROLL_OVER, _castRollOver );
				completelyRemoveEventListener( CastMouseEvent.CAST_ROLL_OUT, _castRollOut );
			}
		}
		private var _eventHandlerEnabled:Boolean = true;
		
		/**
		 * <span lang="ja">このオブジェクトに関連付けられている CastButtonContextMenu インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get uiContextMenu():CastButtonContextMenu { return _uiContextMenu; }
		private var _uiContextMenu:CastButtonContextMenu;
		
		/**
		 * @private
		 */
		public function get onCastAdded():Function { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastAdded" ) ); }
		public function set onCastAdded( value:Function ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastAdded" ) ); }
		
		/**
		 * @private
		 */
		protected final function _onCastAdded():void {}
		
		/**
		 * @private
		 */
		public function get onCastRemoved():Function { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastRemoved" ) ); }
		public function set onCastRemoved( value:Function ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "onCastRemoved" ) ); }
		
		/**
		 * @private
		 */
		protected final function _onCastRemoved():void {}
		
		/**
		 * <span lang="ja">CastButton インスタンスが CastMouseEvent.CAST_MOUSE_DOWN イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastMouseDown():Function { return __onCastMouseDown || _onCastMouseDown; }
		public function set onCastMouseDown( value:Function ):void { __onCastMouseDown = value; }
		private var __onCastMouseDown:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastMouseDown イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastMouseDown プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastMouseDown():void {}
		
		/**
		 * <span lang="ja">CastButton インスタンスが CastMouseEvent.CAST_MOUSE_UP イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastMouseUp():Function { return __onCastMouseUp || _onCastMouseUp; }
		public function set onCastMouseUp( value:Function ):void { __onCastMouseUp = value; }
		private var __onCastMouseUp:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastMouseUp イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastMouseUp プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastMouseUp():void {}
		
		/**
		 * <span lang="ja">CastButton インスタンスが CastMouseEvent.CAST_ROLL_OVER イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastRollOver():Function { return __onCastRollOver || _onCastRollOver; }
		public function set onCastRollOver( value:Function ):void { __onCastRollOver = value; }
		private var __onCastRollOver:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastRollOver イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRollOver プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastRollOver():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが CastMouseEvent.CAST_ROLL_OUT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onCastRollOut():Function { return __onCastRollOut || _onCastRollOut; }
		public function set onCastRollOut( value:Function ):void { __onCastRollOut = value; }
		private var __onCastRollOut:Function;
		
		/**
		 * <span lang="ja">サブクラスで onCastRollOut イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onCastRollOut プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onCastRollOut():void {}
		
		/**
		 * SceneObject インスタンスを取得します。 
		 */
		private var _scene:SceneObject;
		
		/**
		 * Stage インスタンスを取得します。 
		 */
		private var _stage:Stage;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastButton インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastButton object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function CastButton( initObject:Object = null ) {
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
			
			// スーパークラスを初期化する
			super();
			
			// AccessibilityProperties を作成する
			accessibilityProperties = new AccessibilityProperties();
			
			// ToolTip を作成する
			_toolTip = ToolTip.progression_internal::__createInstance( this );
			
			// CastButtonContextMenu を作成する
			Object( this )._initContextMenu();
			
			// 初期化する
			buttonEnabled = true;
			eventHandlerEnabled = true;
			setProperties( initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_DOWN, dispatchEvent, false, 0, true );
			_executor.addExclusivelyEventListener( CastMouseEvent.CAST_MOUSE_UP, dispatchEvent, false, 0, true );
			_executor.addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OVER, dispatchEvent, false, 0, true );
			_executor.addExclusivelyEventListener( CastMouseEvent.CAST_ROLL_OUT, dispatchEvent, false, 0, true );
			ProgressionCollection.addExclusivelyEventListener( CollectionEvent.COLLECTION_UPDATE, _collectionUpdate, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定されたシーン識別子、または URL に移動します。
		 * 引数が省略された場合には、予め CastButton インスタンスに指定されている sceneId プロパティまたは href プロパティが示す先に移動します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param location
		 * <span lang="ja">移動先を示すシーン識別子、または URL です。</span>
		 * <span lang="en"></span>
		 * @param windowTarget
		 * <span lang="ja">location パラメータで指定されたドキュメントを表示するブラウザウィンドウまたは HTML フレームです。</span>
		 * <span lang="en"></span>
		 */
		public function navigateTo( location:* = null, windowTarget:String = null ):void {
			var request:URLRequest;
			var sceneId:SceneId;
			
			// location を型によって振り分ける
			switch ( true ) {
				case location is String			: { request = new URLRequest( location ); break; }
				case location is URLRequest		: { request = URLRequest( location ); break; }
				case location is SceneId		: { sceneId = SceneId( location ); break; }
				default							: {
					request = _href ? new URLRequest( _href ) : null;
					sceneId = _sceneId;
				}
			}
			
			// windowTarget を設定する
			windowTarget ||= _windowTarget || "_self";
			
			// URL を移動する
			if ( request ) {
				navigateToURL( request, windowTarget );
			}
			
			// シーンを移動する
			else if ( sceneId ) {
				// 自身を指していればそのまま移動する
				if ( _progression && windowTarget == "_self" ) {
					_progression.goto( sceneId );
				}
				
				// それ以外の場合には navigateToURL を使用する
				else {
					navigateToURL( new URLRequest( "#" + SceneIdUtil.toShortPath( sceneId ) ), windowTarget );
				}
			}
		}
		
		/**
		 * Progression インスタンスとの関連付けを更新します。
		 */
		private function _updateProgression():void {
			var progression:Progression = _progression;
			
			// すでに Progression と関連付いていれば
			if ( _progression ) {
				_progression.completelyRemoveEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
			}
			
			// すでにシーンと関連付いていればと関連付いていれば
			if ( _scene ) {
				_scene.completelyRemoveEventListener( SceneEvent.SCENE_TITLE, _sceneTitle );
			}
			
			// 値を設定する
			_progression = _sceneId ? ProgressionCollection.progression_internal::__getInstanceBySceneId( _sceneId ) : null;
			_scene = _sceneId ? SceneCollection.progression_internal::__getInstanceBySceneId( _sceneId ) : null;
			
			// Progression と関連付いていれば
			if ( _progression ) {
				_progression.addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, int.MAX_VALUE, true );
				_processScene( new ProcessEvent( ProcessEvent.PROCESS_SCENE, false, false, _progression.current, _progression.eventType ) );
			}
			
			// シーンと関連付いていれば
			if ( _scene ) {
				// Accessibility を更新する
				_scene.addExclusivelyEventListener( SceneEvent.SCENE_TITLE, _sceneTitle, false, 0, true );
				accessibilityProperties.name = _scene.title;
				if ( Accessibility.active ) {
					Accessibility.updateProperties();
				}
			}
			
			// 変更されていれば
			if ( progression != _progression ) {
				// イベントを送出する
				dispatchEvent( new CastEvent( CastEvent.UPDATE ) );
			}
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
			_executor.progression_internal::__addCommand.apply( this, commands );
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
			_executor.progression_internal::__insertCommand.apply( this, commands );
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
			_executor.progression_internal::__clearCommand( completely );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _addedToStage( e:Event ):void {
			// stage の参照を保存する
			_stage = stage;
			
			// イベントリスナーを登録する
			_stage.addEventListener( KeyboardEvent.KEY_DOWN, _keyDown, false, int.MAX_VALUE, true );
			_stage.addEventListener( KeyboardEvent.KEY_UP, _keyUp, false, int.MAX_VALUE, true );
		}
		
		/**
		 * 表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _removedFromStage( e:Event ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, _keyDown );
			_stage.removeEventListener( KeyboardEvent.KEY_UP, _keyUp );
			
			// stage の参照を破棄する
			_stage = null;
		}
		
		/**
		 * ユーザーがキーを押したときに送出されます。
		 */
		private function _keyDown( e:KeyboardEvent ):void {
			// CTRL キー、または SHIFT キーが押されているかどうかを設定します。
			_isCTRLorShiftKeyDown = e.ctrlKey || e.shiftKey;
		}
		
		/**
		 * ユーザーがキーを離したときに送出されます。
		 */
		private function _keyUp( e:KeyboardEvent ):void {
			// CTRL キー、または SHIFT キーが押されているかどうかを無効化します。
			_isCTRLorShiftKeyDown = false;
			
			// キャラコードが一致しなければ終了する
			if ( !_accessKey || e.charCode != _accessKey.toLowerCase().charCodeAt() ) { return; }
			
			// 移動する
			navigateTo();
		}
		
		/**
		 * Flash Player ウィンドウの InteractiveObject インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _mouseDown( e:MouseEvent ):void {
			// イベントリスナーを登録する
			_stage.addEventListener( MouseEvent.MOUSE_UP, _mouseUpStage, false, int.MAX_VALUE, true );
			
			// ダウン状態にする
			_isMouseDown = true;
			
			// コマンドを実行する
			executor.progression_internal::__execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_DOWN, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ), {}, false, true );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopPropagation();
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _mouseUp( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_stage.removeEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
			
			// アップ状態にする
			_isMouseDown = false;
			
			// 新しいウィンドウで開くかどうかを設定します。
			_openNewWindow = _isCTRLorShiftKeyDown;
			
			// コマンドを実行する
			executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteMouseUp, false, 0, true );
			executor.progression_internal::__execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_UP, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ), {}, true, true );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopPropagation();
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _mouseUpStage( e:MouseEvent ):void {
			if ( !_stage ) { return; }
			
			// イベントリスナーを解除する
			_stage.removeEventListener( MouseEvent.MOUSE_UP, _mouseUpStage );
			
			// アップ状態にする
			_isMouseDown = false;
			
			// コマンドを実行する
			executor.progression_internal::__execute( new CastMouseEvent( CastMouseEvent.CAST_MOUSE_UP, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ), {}, true, true );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopPropagation();
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _rollOver( e:MouseEvent ):void {
			// ロールオーバー状態にする
			_isRollOver = true;
			
			// ステータスバーに移動先を表示する
			SWFAddress.setStatus( navigateURL );
			
			// コマンドを実行する
			executor.progression_internal::__execute( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OVER, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ), {}, false, true );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopPropagation();
		}
		
		/**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _rollOut( e:MouseEvent ):void {
			// ロールオーバー状態を解除する
			_isRollOver = false;
			
			// ステータスバーをクリアする
			SWFAddress.resetStatus();
			
			// コマンドを実行する
			executor.progression_internal::__execute( new CastMouseEvent( CastMouseEvent.CAST_ROLL_OUT, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta ), {}, true, true );
			
			// 後続するノードでイベントリスナーが処理されないようにする
			e.stopPropagation();
		}
		
		/**
		 * Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _castMouseDown( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastMouseDown();
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castMouseUp( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastMouseUp();
		}
		
		/**
		 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _castRollOver( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastRollOver();
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _castRollOut( e:CastMouseEvent ):void {
			// イベントハンドラメソッドを実行する
			onCastRollOut();
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandCompleteMouseUp( e:CommandEvent ):void {
			// イベントリスナーを解除する
			executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandCompleteMouseUp );
			
			// 移動する
			navigateTo( null, _openNewWindow ? "_blank" : _windowTarget );
			
			// 無効化する
			_openNewWindow = false;
		}
		
		/**
		 * シーン移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			// カレントシーンを取得する
			var current:SceneObject = e.scene;
			
			// カレントシーンが存在しなければ終了する
			if ( !current ) {
				_isCurrent = false;
				_isParent = false;
				_isChild = false;
				return;
			}
			
			// 現在の設定を保存する
			var isCurrent:Boolean = _isCurrent;
			var isParent:Boolean = _isParent;
			var isChild:Boolean = _isChild;
			
			// シーンの関連性を再設定する
			_isCurrent = _sceneId.equals( current.sceneId );
			_isParent = Boolean( !_isCurrent && current.sceneId.contains( _sceneId ) );
			_isChild = Boolean( !_isCurrent && _sceneId.contains( current.sceneId ) );
			
			// 状態が変更されていれば
			switch ( true ) {
				case isCurrent != _isCurrent	:
				case isParent != _isParent		:
				case isChild != _isChild		: {
					// イベントを送出する
					dispatchEvent( new CastEvent( CastEvent.STATUS_CHANGE ) );
					break;
				}
			}
		}
		
		/**
		 * Progression インスタンスがコレクションに登録された場合に送出されます。
		 */
		private function _collectionUpdate( e:CollectionEvent ):void {
			// Progression との関連付けを更新する
			_updateProgression();
		}
		
		/**
		 * Progression インスタンスがコレクションに登録された場合に送出されます。
		 */
		private function _sceneTitle( e:SceneEvent ):void {
			// Accessibility を更新する
			accessibilityProperties.name = _scene.title;
			if ( Accessibility.active ) {
				Accessibility.updateProperties();
			}
		}
		
		
		
		
		
		/**
		 * 
		 */
		include "../core/includes/CastButton_contextMenu.inc"
	}
}
