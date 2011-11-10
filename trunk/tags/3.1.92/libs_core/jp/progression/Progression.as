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
package jp.progression {
	import com.asual.swfaddress.SWFAddress;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.system.Capabilities;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.external.BrowserInterface;
	import jp.nium.net.URLObject;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.version.Version;
	import jp.progression.core.casts.Background;
	import jp.progression.core.casts.Container;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.managers.KeyboardManager;
	import jp.progression.core.managers.SceneManager;
	import jp.progression.core.managers.SyncManager;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.PackageInfo;
	import jp.progression.core.ui.CastObjectContextMenu;
	import jp.progression.core.utils.SceneIdUtil;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">シーン移動処理が開始された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_START
	 */
	[Event( name="processStart", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">シーン移動処理が完了した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_COMPLETE
	 */
	[Event( name="processComplete", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">シーン移動処理が停止された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_INTERRUPT
	 */
	[Event( name="processInterrupt", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">シーン移動処理中に対象シーンが変更された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_SCENE
	 */
	[Event( name="processScene", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">シーン移動処理中に対象シーンでイベントが発生した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_EVENT
	 */
	[Event( name="processEvent", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">シーン移動処理中に移動先のシーンが存在しなかった場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.ProcessEvent.PROCESS_ERROR
	 */
	[Event( name="processError", type="jp.progression.events.ProcessEvent" )]
	
	/**
	 * <span lang="ja">Progression クラスは、Progression を使用するための基本クラスです。
	 * シーン作成やシーン移動の処理は、全て Progression インスタンスを通じて行います。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // Progression インスタンスを作成します。
	 * var prog:Progression = new Progression( "index", stage );
	 * 
	 * // ルートシーンのイベントハンドラメソッドを設定します。
	 * prog.root.onLoad = function():void {
	 * 	trace( "ルートシーンで SceneEvent.LOAD イベントが送出されました。" );
	 * };
	 * prog.root.onInit = function():void {
	 * 	trace( "ルートシーンで SceneEvent.INIT イベントが送出されました。" );
	 * };
	 * 
	 * // ルートシーン以下に子シーンを追加します。
	 * prog.root.addScene( new SceneObject( "scene1" ) );
	 * prog.root.addScene( new SceneObject( "scene2" ) );
	 * prog.root.addScene( new SceneObject( "scene3" ) );
	 * 
	 * // scene1 シーンに移動します。
	 * prog.goto( new SceneId( "/index/scene1" ) );
	 * </listing>
	 */
	public class Progression extends EventIntegrator {
		
		/**
		 * <span lang="ja">パッケージの名前を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const NAME:String = "Progression";
		
		/**
		 * <span lang="ja">パッケージのバージョン情報を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const VERSION:Version = new Version( "3.1.92" );
		
		/**
		 * <span lang="ja">パッケージの制作者を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const AUTHOR:String = "Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.";
		
		/**
		 * <span lang="ja">パッケージの URL を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const URL:String = "http://progression.jp/";
		
		/**
		 * <span lang="ja">対応している Flash Player のバージョンを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const PLAYER_VERSION:Version = new Version( "9.0.45" );
		
		
		
		
		
		/**
		 * <span lang="ja">適用されているライセンスの種類を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get activatedLicenseType():String { return _activatedLicenseType; }
		private static var _activatedLicenseType:String;
		
		/**
		 * <span lang="ja">背景に関連付けられている CastObjectContextMenu インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get uiContextMenu():CastObjectContextMenu { return _background.uiContextMenu; }
		
		/**
		 * @private
		 */
		progression_internal static const $BUILT_ON_LABEL:String = "Built on " + Progression.NAME + " " + Progression.VERSION.majorVersion;
		
		/**
		 * @private
		 */
		progression_internal static function get $BUILT_ON_URL():String {
			var url:String = Progression.URL + "built_on/";
			var info:Object = {
				ver	:Progression.VERSION.toString(),
				twn	:int( PackageInfo.hasTweener ),
				sad	:int( PackageInfo.hasSWFAddress ),
				swh	:int( PackageInfo.hasSWFWheel )
			};
			
			url += "?" + ObjectUtil.toQueryString( info );
			
			return encodeURI( url );
		}
		
		/**
		 * Stage インスタンスを取得します。 
		 */
		private static var _stage:Stage;
		
		/**
		 * Background インスタンスを取得します。 
		 */
		private static var _background:Background = Background.progression_internal::__createInstance();
		
		/**
		 * Container インスタンスを取得します。 
		 */
		private static var _container:Container = Container.progression_internal::__createInstance();
		
		
		
		
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得します。</span>
		 * <span lang="en">Indicates the instance id of the Progression.</span>
		 */
		public function get id():String { return _id; }
		private var _id:String;
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the Progression.</span>
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = ProgressionCollection.progression_internal::__addInstanceAtGroup( this, value ); }
		private var _group:String;
		
		/**
		 * <span lang="ja">制御対象のシーンリストのツリー構造部分の一番上にある SceneObject インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get root():SceneObject { return _sceneManager.root; }
		
		/**
		 * <span lang="ja">カレントである SceneObject インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get current():SceneObject { return _sceneManager.current; }
		
		/**
		 * <span lang="ja">出発地となるシーン識別子を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get departedSceneId():SceneId { return _sceneManager.departedSceneId; }
		
		/**
		 * <span lang="ja">目的地となるシーン識別子を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get destinedSceneId():SceneId { return _sceneManager.destinedSceneId; }
		
		/**
		 * <span lang="ja">インスタンスを作成した際の状況から判断された、最初に表示するシーンに適したシーン識別子を取得します。
		 * この値はブラウザ上で再生させた場合に、コンテンツが設置されている URL のフラグメント値から自動的に設定されます。
		 * その他の状況で再生された場合には、常にルートシーンのシーン識別子が設定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get firstSceneId():SceneId { return _firstSceneId; }
		private var _firstSceneId:SceneId;
		
		/**
		 * <span lang="ja">現在表示中のシーンで発生しているイベントタイプを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventType():String { return _sceneManager.eventType; }
		
		/**
		 * <span lang="ja">ブラウザ上でコンテンツを実行している場合に、URL と Progression インスタンスのシーンを同期させるかどうかを取得または設定します。
		 * 同一コンテンツ上で有効化できる Progression インスタンスは 1 つのみであり、複数に対して有効化を試みた場合、最後に有効化された Progression インスタンス以外の sync プロパティは自動的に false に設定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get sync():Boolean { return _syncManager.sync; }
		public function set sync( value:Boolean ):void { _syncManager.sync = value; }
		
		/**
		 * <span lang="ja">コマンド処理を実行中に、外部からの goto() メソッドの呼び出しを有効にするかどうかを設定または取得します。
		 * このプロパティを設定すると autoLock プロパティが強制的に false に設定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get lock():Boolean { return _sceneManager.lock; }
		public function set lock( value:Boolean ):void { _sceneManager.lock = value; }
		
		/**
		 * <span lang="ja">コマンド処理を実行中に lock プロパティの値を自動的に有効化するかどうかを設定または取得します。
		 * この設定が有効である場合には、コマンド処理が開始されると lock プロパティが true に、処理完了後に false となります。</span>
		 * <span lang="en"></span>
		 */
		public function get autoLock():Boolean { return _sceneManager.autoLock; }
		public function set autoLock( value:Boolean ):void { _sceneManager.autoLock = value; }
		
		/**
		 * <span lang="ja">現在の処理状態を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get running():Boolean { return _sceneManager.running; }
		
		/**
		 * <span lang="ja">中断処理中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get interrupting():Boolean { return _sceneManager.interrupting; }
		
		/**
		 * <span lang="ja">インスタンスに関連付けられている Stage インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get stage():Stage { return _stage; }
		
		/**
		 * <span lang="ja">インスタンスに関連付けられている Container インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get container():Container { return _container; }
		
		/**
		 * <span lang="ja">キーボード操作に関連する設定を行う KeyboardManager インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get keyboard():KeyboardManager { return _keyboard; }
		private var _keyboard:KeyboardManager;
		
		/**
		 * SceneManager インスタンスを取得します。 
		 */
		private var _sceneManager:SceneManager;
		
		/**
		 * SyncManager インスタンスを取得します。 
		 */
		private var _syncManager:SyncManager;
		
		/**
		 * <span lang="ja">オブジェクトのイベントハンドラメソッドを有効化するかどうかを指定します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventHandlerEnabled():Boolean { return _eventHandlerEnabled; }
		public function set eventHandlerEnabled( value:Boolean ):void {
			if ( _eventHandlerEnabled = value ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( ProcessEvent.PROCESS_START, _processStart, false, 0, true );
				addExclusivelyEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete, false, 0, true );
				addExclusivelyEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt, false, 0, true );
				addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, _processScene, false, 0, true );
				addExclusivelyEventListener( ProcessEvent.PROCESS_EVENT, _ProcessEvent, false, 0, true );
				addExclusivelyEventListener( ProcessEvent.PROCESS_ERROR, _processError, false, 0, true );
			}
			else {
				// イベントリスナーを解除する
				completelyRemoveEventListener( ProcessEvent.PROCESS_START, _processStart );
				completelyRemoveEventListener( ProcessEvent.PROCESS_COMPLETE, _processComplete );
				completelyRemoveEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt );
				completelyRemoveEventListener( ProcessEvent.PROCESS_SCENE, _processScene );
				completelyRemoveEventListener( ProcessEvent.PROCESS_EVENT, _ProcessEvent );
				completelyRemoveEventListener( ProcessEvent.PROCESS_ERROR, _processError );
			}
		}
		private var _eventHandlerEnabled:Boolean = true;
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_START イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessStart():Function { return __onProcessStart || _onProcessStart; }
		public function set onProcessStart( value:Function ):void { __onProcessStart = value; }
		private var __onProcessStart:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessStart イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessStart プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessStart():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_COMPLETE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessComplete():Function { return __onProcessComplete || _onProcessComplete; }
		public function set onProcessComplete( value:Function ):void { __onProcessComplete = value; }
		private var __onProcessComplete:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessComplete イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessComplete プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessComplete():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_INTERRUPT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessInterrupt():Function { return __onProcessInterrupt || _onProcessInterrupt; }
		public function set onProcessInterrupt( value:Function ):void { __onProcessInterrupt = value; }
		private var __onProcessInterrupt:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessInterrupt イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessInterrupt プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessInterrupt():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_SCENE イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessScene():Function { return __onProcessScene || _onProcessScene; }
		public function set onProcessScene( value:Function ):void { __onProcessScene = value; }
		private var __onProcessScene:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessScene イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessScene プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessScene():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_EVENT イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessEvent():Function { return __onProcessEvent || _onProcessEvent; }
		public function set onProcessEvent( value:Function ):void { __onProcessEvent = value; }
		private var __onProcessEvent:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessEvent イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessEvent プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessEvent():void {}
		
		/**
		 * <span lang="ja">シーンオブジェクトが ProcessEvent.PROCESS_ERROR イベントを受け取った場合に呼び出されるイベントハンドラメソッドを取得または設定します。
		 * このイベント処理の実行中には、addCommand() メソッド、及び insertCommand() メソッドによるコマンドの同期処理が行えます。</span>
		 * <span lang="en"></span>
		 */
		public function get onProcessError():Function { return __onProcessError || _onProcessError; }
		public function set onProcessError( value:Function ):void { __onProcessError = value; }
		private var __onProcessError:Function;
		
		/**
		 * <span lang="ja">サブクラスで onProcessError イベントハンドラメソッドの処理を override で実装したい場合に上書きします。
		 * onProcessError プロパティに、別のメソッドを設定された場合は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		protected function _onProcessError():void {}
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Progression インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Progression object.</span>
		 * 
		 * @param id
		 * <span lang="ja">インスタンスの識別子です。</span>
		 * <span lang="en"></span>
		 * @param stage
		 * <span lang="ja">関連付けたい Stage インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param rootClass
		 * <span lang="ja">ルートシーンに関連付けたいクラスの参照です。</span>
		 * <span lang="en"></span>
		 */
		public function Progression( id:String, stage:Stage = null, rootClass:Class = null ) {
			// 再生している Flash Player のバージョンを取得する
			var version:Version = new Version( Capabilities.version.split( " " )[1] );
			if ( Progression.PLAYER_VERSION.compare( version ) > 0 ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9000", Progression.PLAYER_VERSION ) ); }
			
			// Progression 識別子がすでに登録されていればエラーを送出する
			if ( !id ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_1507", "id" ) ); }
			if ( ProgressionCollection.progression_internal::__getInstanceById( id ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9001" ) ); }
			
			// 初期化されていなければ、自動的にライセンスを設定する
			_activatedLicenseType ||= ActivatedLicenseType.PLL_BASIC;
			
			// 引数を設定する
			_stage ||= stage;
			
			// _stage が存在しなければ
			if ( !_stage ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9010" ) ); }
			
			// パッケージ情報を出力する
			trace( "\n" + Progression.NAME + " " + Progression.VERSION + "\n" + Progression.AUTHOR + "\n" );
			
			// SceneCollection に登録する
			_id = id;
			
			// 初期化する
			eventHandlerEnabled = true;
			
			// firstSceneId を取得する
			var scenePath:String = "/" + _id;
			if ( BrowserInterface.enabled ) {
				var url:URLObject = new URLObject( BrowserInterface.locationHref );
				if ( SceneId.validate( scenePath + url.fragment ) ) {
					scenePath += url.fragment;
				}
			}
			_firstSceneId = new SceneId( scenePath );
			
			// Background を表示する
			if ( !_stage.contains( _background ) ) {
				_stage.addChildAt( _background, 0 );
			}
			
			// Container を表示する
			if ( !_stage.contains( _container ) ) {
				_stage.addChild( _container );
			}
			
			// SceneManager インスタンスを作成する
			_sceneManager = SceneManager.progression_internal::__createInstance();
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_START, dispatchEvent, false, int.MAX_VALUE, true );
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_COMPLETE, dispatchEvent, false, int.MAX_VALUE, true );
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_INTERRUPT, dispatchEvent, false, int.MAX_VALUE, true );
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_SCENE, dispatchEvent, false, int.MAX_VALUE, true );
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_EVENT, dispatchEvent, false, int.MAX_VALUE, true );
			_sceneManager.addExclusivelyEventListener( ProcessEvent.PROCESS_ERROR, dispatchEvent, false, int.MAX_VALUE, true );
			
			// KeyboardManager インスタンスを作成する
			_keyboard = KeyboardManager.progression_internal::__createInstance( _stage );
			
			// SyncManager インスタンスを作成する
			_syncManager = SyncManager.progression_internal::__createInstance( _sceneManager );
			
			// rootClass が存在しなければ SceneObject に変換する
			rootClass ||= SceneObject;
			
			// rootClass を作成する
			SceneObject.progression_internal::__owner = this;
			var root:SceneObject = new rootClass() as SceneObject;
			
			// root が SceneObject クラスを継承していなければエラーを送出する
			if ( !root ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_9002" ) ); }
			
			// SceneManager の root に設定する
			_sceneManager.root = root;
			
			// コレクションに登録する
			ProgressionCollection.progression_internal::__addInstanceAtId( this, _id );
			ProgressionCollection.progression_internal::__addInstance( this );
			
			// イベントを送出する
			root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED, false, false, root ) );
			root.dispatchEvent( new SceneEvent( SceneEvent.SCENE_ADDED_TO_ROOT, false, false, root ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * 
		 * @param activatedLicenseType
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public static function initialize( activatedLicenseType:String ):Boolean {
			if ( _activatedLicenseType ) { return false; }
			
			switch( activatedLicenseType ) {
				case ActivatedLicenseType.GPL				:
				case ActivatedLicenseType.PLL_APPLICATION	:
				case ActivatedLicenseType.PLL_BASIC			:
				case ActivatedLicenseType.PLL_WEB			: { _activatedLicenseType = activatedLicenseType; break; }
				default										: { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_2008", "activatedLicenseType" ) ); }
			}
			
			return true;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている Progression インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getProgressionById( id:String ):Progression {
			return ProgressionCollection.progression_internal::__getInstanceById( id );
		}
		
		/**
		 * <span lang="ja">指定された sceneId インスタンスの指し示す Progression インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param id
		 * <span lang="ja">条件となる SceneId インスタンスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getProgressionBySceneId( sceneId:SceneId ):Progression {
			return ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
		}
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ Progression インスタンスを含む配列を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param group
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getProgressionsByGroup( group:String, sort:Boolean = false ):Array {
			return ProgressionCollection.progression_internal::__getInstancesByGroup( group, sort );
		}
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する Progression インスタンスを含む配列を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param fieldName
		 * <span lang="ja">調査するフィールド名です。</span>
		 * <span lang="en"></span>
		 * @param pattern
		 * <span lang="ja">条件となる正規表現です。</span>
		 * <span lang="en"></span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getProgressionsByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return ProgressionCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/**
		 * <span lang="ja">インスタンスに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">設定対象の Progression インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function setProperties( props:Object ):Progression {
			ObjectUtil.setProperties( this, props );
			return this;
		}
		
		/**
		 * <span lang="ja">シーンを移動します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">移動先を示すシーン識別子です。</span>
		 * <span lang="en"></span>
		 */
		public function goto( sceneId:SceneId ):void {
			// ロックされていたら終了する
			if ( _sceneManager.lock ) { return; }
			
			// 同期が有効化されていれば
			if ( _syncManager.enabled ) {
				var shortPath:String = SceneIdUtil.toShortPath( sceneId );
				
				// 発行されている URL と移動先が違っていれば
				if ( SWFAddress.getValue() != shortPath ) {
					SWFAddress.setValue( SceneIdUtil.toShortPath( sceneId ) );
					return;
				}
			}
			
			_sceneManager.goto( sceneId );
		}
		
		/**
		 * <span lang="ja">シーン移動処理を中断します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param enforced
		 * <span lang="ja">現在の処理で強制的に中断するかどうかです。</span>
		 * <span lang="en"></span>
		 */
		public function interrupt( enforced:Boolean = false ):void {
			_sceneManager.interrupt( enforced );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return '[Progression id="' + _id + '" group="' + _group + '" sync="' + sync + '"]';
		}
		
		
		
		
		
		/**
		 * シーン移動処理が開始された場合に送出されます。
		 */
		private function _processStart( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessStart();
		}
		
		/**
		 * シーン移動処理が完了した場合に送出されます。
		 */
		private function _processComplete( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessComplete();
		}
		
		/**
		 * シーン移動処理が停止された場合に送出されます。
		 */
		private function _processInterrupt( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessInterrupt();
		}
		
		/**
		 * シーン移動処理中に対象シーンが変更された場合に送出されます。
		 */
		private function _processScene( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessScene();
		}
		
		/**
		 * シーン移動処理中に対象シーンでイベントが発生した場合に送出されます。
		 */
		private function _ProcessEvent( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessEvent();
		}
		
		/**
		 * シーン移動処理中に移動先のシーンが存在しなかった場合に送出されます。
		 */
		private function _processError( e:ProcessEvent ):void {
			// イベントハンドラメソッドを実行する
			onProcessError();
		}
	}
}
