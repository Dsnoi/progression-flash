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
package jp.progression.core.managers {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.net.Query;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.commands.CommandExecutor;
	import jp.progression.core.commands.ICommandExecutable;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.managers.HistoryManager;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.PackageInfo;
	import jp.progression.events.CommandEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.Progression;
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
	 * @private
	 */
	public class SceneManager extends EventIntegrator implements ICommandExecutable {
		
		/**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">制御対象のシーンリストのツリー構造部分の一番上にある SceneObject インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get root():SceneObject { return _root; }
		public function set root( value:SceneObject ):void {
			if ( value.root != value ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9014" ) ); }
			PackageInfo.activate( value.progression.stage );
			
			_root = value;
			_current = null;
			
			_currentSceneId = null;
			_departedSceneId = null;
			_destinedSceneId = null;
			
			_eventType = null;
			
			_running = false;
			_interrupting = false;
		}
		private var _root:SceneObject;
		
		/**
		 * <span lang="ja">カレントである SceneObject インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get current():SceneObject { return _current; }
		private var _current:SceneObject;
		
		/**
		 * ひとつ前に表示したシーンオブジェクトを取得します。
		 */
		private var _previous:SceneObject;
		
		/**
		 * カレントであるシーン識別子を取得します。
		 */
		private var _currentSceneId:SceneId;
		
		/**
		 * <span lang="ja">出発地となるシーン識別子を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get departedSceneId():SceneId { return _departedSceneId; }
		private var _departedSceneId:SceneId;
		
		/**
		 * <span lang="ja">目的地となるシーン識別子を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get destinedSceneId():SceneId { return _destinedSceneId; }
		private var _destinedSceneId:SceneId;
		
		/**
		 * <span lang="ja">現在表示中のシーンで発生しているイベントタイプを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get eventType():String { return _eventType; }
		private var _eventType:String = SceneEvent.UNLOAD;
		
		/**
		 * <span lang="ja">コマンド処理を実行中に、外部からの goto() メソッドの呼び出しを有効にするかどうかを設定または取得します。
		 * このプロパティを設定すると autoLock プロパティが強制的に false に設定されます。</span>
		 * <span lang="en"></span>
		 */
		public function get lock():Boolean { return _lock; }
		public function set lock( value:Boolean ):void {
			// autoLock が有効化されていれば無効化する
			if ( _autoLock ) {
				_autoLock = false;
			}
			
			_lock = value;
		}
		private var _lock:Boolean = false;
		
		/**
		 * <span lang="ja">コマンド処理を実行中に lock プロパティの値を自動的に有効化するかどうかを設定または取得します。
		 * この設定が有効である場合には、コマンド処理が開始されると lock プロパティが true に、処理完了後に false となります。</span>
		 * <span lang="en"></span>
		 */
		public function get autoLock():Boolean { return _autoLock; }
		public function set autoLock( value:Boolean ):void { _autoLock = value; }
		private var _autoLock:Boolean = true;
		
		/**
		 * <span lang="ja">現在の処理状態を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get running():Boolean { return _running; }
		private var _running:Boolean = false;
		
		/**
		 * <span lang="ja">中断処理中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get interrupting():Boolean { return _interrupting; }
		private var _interrupting:Boolean = false;
		
		/**
		 * <span lang="ja">コマンドが強制中断処理中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get enforcedInterrupting():Boolean { return _enforcedInterrupting; }
		private var _enforcedInterrupting:Boolean = false;
		
		/**
		 * <span lang="ja">コマンドを実行する CommandExecutor インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get executor():CommandExecutor { return _executor; }
		private var _executor:CommandExecutor;
		
		/**
		 * 実行時に渡される任意のリレーオブジェクトを取得します。
		 */
		private var _extra:Object;
		
		
		
		
		
		/**
		 * @private
		 */
		public function SceneManager() {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "SceneManager" ) ); };
			
			// CommandExecutor を作成する
			_executor = CommandExecutor.progression_internal::__createInstance( this );
			
			// 初期化する
			_internallyCalled = false;
		}
		
		
		
		
		
		/**
		 * @private
		 */
		progression_internal static function __createInstance():SceneManager {
			_internallyCalled = true;
			return new SceneManager();
		}
		
		
		
		
		
		/**
		 * <span lang="ja">シーンを移動します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param sceneId
		 * <span lang="ja">移動先を示すシーン識別子です。</span>
		 * <span lang="en"></span>
		 * @param extra
		 * <span lang="ja">実行時に渡したい任意のリレーオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function goto( sceneId:SceneId, extra:Object = null ):void {
			// ルートシーンが登録されていなければ
			if ( !_root ) { throw new IllegalOperationError( "" ); }
			
			// SceneManager が管理しているルートシーン以外のルートシーン上にあるシーンが指定されていれば
			if ( sceneId.getNameByIndex( 0 ) != _root.name ) {
				var prog:Progression = ProgressionCollection.progression_internal::__getInstanceBySceneId( sceneId );
				
				// 対象が存在すれば
				if ( prog ) {
					prog.goto( sceneId );
					return;
				}
				
				// エラーを送出して終了する
				Verbose.error( this, VerboseMessageConstants.getMessage( "VERBOSE_0007", _destinedSceneId.path ) );
				dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_ERROR, false, false, _current, _eventType ) );
				return;
			}
			
			// ロックされていたら終了する
			if ( _lock ) { return; }
			
			// すでに目的のシーンを表示していれば、クエリを更新して終了する
			if ( _currentSceneId && _currentSceneId.equals( sceneId ) && _eventType == SceneEvent.INIT ) {
				_current.sceneInfo.progression_internal::__query = new Query( true, sceneId.query );
				return;
			}
			
			// 目的地を設定する
			_departedSceneId = _currentSceneId ? _currentSceneId.clone() : null;
			_destinedSceneId = sceneId.clone();
			
			// 引数を設定する
			_extra = extra;
			
			// すでに中断処理中であれば終了する
			if ( _interrupting ) { return; }
			
			// すでに処理を開始していれば停止させる
			if ( _running ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt, false, int.MAX_VALUE, true );
				
				// 停止処理を実行する
				interrupt( _departedSceneId.contains( _destinedSceneId ) );
				return;
			}
			
			// 処理を開始する
			_setRunning( true );
			
			// 履歴を追加する
			HistoryManager.progression_internal::__addHistory( _destinedSceneId );
			
			// イベントを送出する
			Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0008", _destinedSceneId.path ) );
			dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_START, false, false, _current, _eventType ) );
			
			// 処理を開始する
			_executeStart();
		}
		
		/**
		 * 移動処理の開始処理です。
		 */
		private function _executeStart():void {
			// 現在のシーン状態を保存する
			_previous = _current;
			
			// 現在のシーンが存在しなければ
			if ( !_currentSceneId ) {
				_eventType = SceneEvent.LOAD;
				_current = _root;
			}
			
			// 目的のシーンと現在のシーンが同じであれば
			else if ( _currentSceneId.equals( _destinedSceneId ) ) {
				switch ( _eventType ) {
					case SceneEvent.LOAD		: { _eventType = SceneEvent.INIT; break; }
					case SceneEvent.DESCEND		: { _eventType = SceneEvent.INIT; break; }
					case SceneEvent.INIT		: { break; }
					case SceneEvent.GOTO		: { _eventType = SceneEvent.INIT; break; }
					case SceneEvent.ASCEND		: { _eventType = SceneEvent.INIT; break; }
					case SceneEvent.UNLOAD		: { _eventType = SceneEvent.LOAD; break; }
				}
			}
			
			// 目的のシーンが現在のシーンの子であれば
			else if ( _currentSceneId.contains( _destinedSceneId ) ) {
				switch ( _eventType ) {
					case SceneEvent.LOAD		: { _eventType = SceneEvent.DESCEND; break; }
					case SceneEvent.DESCEND		: {
						// 子シーンに移動する
						_current = _current.getSceneByName( _destinedSceneId.getNameByIndex( _currentSceneId.length ) );
						_eventType = SceneEvent.LOAD;
						break;
					}
					case SceneEvent.INIT		: { _eventType = SceneEvent.GOTO; break; }
					case SceneEvent.GOTO		: {
						// 子シーンに移動する
						_current = _current.getSceneByName( _destinedSceneId.getNameByIndex( _currentSceneId.length ) );
						_eventType = SceneEvent.LOAD;
						break;
					}
					case SceneEvent.ASCEND		: { _eventType = SceneEvent.DESCEND; break; }
					case SceneEvent.UNLOAD		: { _eventType = SceneEvent.LOAD; break; }
				}
			}
			
			// 目的のシーンが現在のシーンの親もしくは親戚であれば
			else {
				switch ( _eventType ) {
					case SceneEvent.LOAD		: { _eventType = SceneEvent.UNLOAD; break; }
					case SceneEvent.DESCEND		: { _eventType = SceneEvent.ASCEND; break; }
					case SceneEvent.INIT		: { _eventType = SceneEvent.GOTO; break; }
					case SceneEvent.GOTO		: { _eventType = SceneEvent.UNLOAD; break; }
					case SceneEvent.ASCEND		: { _eventType = SceneEvent.UNLOAD; break; }
					case SceneEvent.UNLOAD		: {
						// 親シーンに移動する
						_current = _current.parent;
						
						// 現在地と目的地のシーンがルートシーンであれば
						if ( _current.sceneId.equals( _root.sceneId ) && _destinedSceneId.equals( _root.sceneId ) ) {
							// ルートシーンに移動する
							_current = _root;
							_eventType = SceneEvent.INIT;
							break;
						}
						
						// 目的のシーンと移動先のシーンが同一であれば
						if ( _current.sceneId.equals( _destinedSceneId ) ) {
							_eventType = SceneEvent.INIT;
							break;
						}
						
						// 目的のシーンが移動先のシーンの子であれば
						if ( _current.sceneId.contains( _destinedSceneId ) ) {
							_current = _current.getSceneByName( _destinedSceneId.getNameByIndex( _current.sceneId.length ) );
							_eventType = SceneEvent.LOAD;
							break;
						}
						
						// 目的のシーンが移動先のシーンの親シーンであれば
						_eventType = SceneEvent.ASCEND;
						break;
					}
				}
			}
			
			// 処理を実行する
			_executeProgress();
		}
		
		/**
		 * 移動処理の実行処理です。
		 */
		private function _executeProgress():void {
			// カレントシーンが存在すれば
			if ( _current is SceneObject ) {
				_currentSceneId = _current.sceneId.clone();
			}
			
			// 前のシーンが存在すれば
			else {
				// ひとつ前のシーンで停止する
				_current = _previous;
				_currentSceneId = _previous.sceneId.clone();
				
				// 処理を終了する
				_setRunning( false );
				
				// シーンが存在しなければ、エラーを送出して終了する
				Verbose.error( this, VerboseMessageConstants.getMessage( "VERBOSE_0007", _destinedSceneId.path ) );
				dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_ERROR, false, false, _current, _eventType ) );
				return;
			}
			
			// シーンが変更されていればイベントを送出する
			if ( _current != _previous ) {
				Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0009", _currentSceneId.path ) );
				dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_SCENE, false, false, _current, _eventType ) );
			}
			
			// イベントを送出する
			Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0010", _currentSceneId.path, _eventType ) );
			dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_EVENT, false, false, _current, _eventType ) );
			
			// CommandExecutor を登録する
			_executor.progression_internal::__addExecutable( _current );
			
			// コマンドを実行する
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_executor.progression_internal::__execute( new SceneEvent( _eventType, false, false, _current, _eventType ), _extra, false, false );
		}
		
		/**
		 * 移動処理の終了処理です。
		 */
		private function _executeComplete():void {
			// 目的のシーンに到達していない、もしくはイベントタイプ SceneEvent.INIT でなければ
			if ( !_currentSceneId.equals( _destinedSceneId ) || _eventType != SceneEvent.INIT ) {
				// 処理を開始する
				_executeStart();
				return;
			}
			
			// 処理を終了する
			_setRunning( false );
			_enforcedInterrupting = false;
			
			// イベントを送出する
			Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0011" ) + "\n" );
			dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_COMPLETE, false, false, _current, _eventType ) );
		}
		
		/**
		 * <span lang="ja">シーン移動処理を中断します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param enforced
		 * <span lang="ja">現在の処理で強制的に中断するかどうかです。</span>
		 * <span lang="en"></span>
		 * @param extra
		 * <span lang="ja">実行時に渡したい任意のリレーオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function interrupt( enforced:Boolean = false, extra:Object = null ):void {
			// 実行中でなければ終了する
			if ( !_running ) { return; }
			
			// すでに処理していれば終了する
			if ( _interrupting ) { return; }
			
			// 引数を設定する
			_extra = extra;
			
			// 処理を開始する
			_setInterrupting( true );
			_enforcedInterrupting = enforced;
			
			// コマンドを実行する
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_executor.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_executor.progression_internal::__interrupt( new SceneEvent( _eventType, false, false, _current, _eventType ), _extra, false, enforced );
		}
		
		/**
		 * 中断処理を完了します。
		 */
		private function _interruptComplete():void {
			// 処理を終了する
			_setInterrupting( false );
			_enforcedInterrupting = false;
			
			// イベントを送出する
			Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0012" ) + "\n" );
			dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_INTERRUPT, false, false, _current, _eventType ) );
		}
		
		/**
		 * running プロパティの値を変更します。
		 */
		private function _setRunning( value:Boolean ):void {
			_running = value;
			
			// オートロックが有効であればロックする
			if ( _autoLock ) {
				_lock = value;
			}
		}
		
		/**
		 * running プロパティの値を変更します。
		 */
		private function _setInterrupting( value:Boolean ):void {
			_running = value;
			_interrupting = value;
			
			// オートロックが有効であればロックする
			if ( _autoLock ) {
				_lock = value;
			}
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
			return "[object SceneManager]";
		}
		
		
		
		
		
		/**
		 * イベント処理が停止された場合に送出されます。
		 */
		private function _processInterrupt( e:ProcessEvent ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt );
			
			// 移動する
			goto( _destinedSceneId );
		}
		
		/**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// CommandExecutor を登録解除する
			_executor.progression_internal::__removeExecutable( _current );
			
			// 処理を終了する
			_executeComplete();
		}
		
		/**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// CommandExecutor を登録解除する
			_executor.progression_internal::__removeExecutable( _current );
			
			// 処理を終了する
			_interruptComplete();
		}
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_executor.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// エラーを送出して終了する
			Verbose.error( this, VerboseMessageConstants.getMessage( "VERBOSE_0013" ) );
			dispatchEvent( new ProcessEvent( ProcessEvent.PROCESS_ERROR, false, false, _current, _eventType ) );
		}
	}
}
