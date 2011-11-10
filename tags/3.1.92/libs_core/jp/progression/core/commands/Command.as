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
package jp.progression.core.commands {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.collections.CommandCollection;
	import jp.progression.core.commands.CommandList;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.errors.CommandTimeOutError;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">コマンドの処理が開始された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_START
	 */
	[Event( name="commandStart", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドの処理が完了した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event( name="commandComplete", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドの処理を停止した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_INTERRUPT
	 */
	[Event( name="commandInterrupt", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンド処理中にエラーが発生した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_ERROR
	 */
	[Event( name="commandError", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドがコマンドリストに追加された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_ADDED
	 */
	[Event( name="commandAdded", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">コマンドがコマンドリストから削除された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.progression.events.CommandEvent.COMMAND_REMOVED
	 */
	[Event( name="commandRemoved", type="jp.progression.events.CommandEvent" )]
	
	/**
	 * <span lang="ja">Command クラスは、全てのコマンドの基本となるクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class Command extends EventIntegrator {
		
		/**
		 * @private
		 */
		public static function get defaultTimeOut():int { return _defaultTimeOut; }
		public static function set defaultTimeOut( value:int ):void { _defaultTimeOut = Math.max( 0, value ); }
		private static var _defaultTimeOut:int = 0;
		
		/**
		 * @private
		 */
		public static function get thresholdLength():int { return _thresholdLength; }
		public static function set thresholdLength( value:int ):void { _thresholdLength = Math.max( 0, value ); }
		private static var _thresholdLength:int = 200;
		
		/**
		 * 現在のプロセス数を取得します。
		 */
		private static var _processNum:int = 0;
		
		/**
		 * 実行中の Command インスタンスの参照を格納した配列を取得します。
		 */
		private static var _executedCommands:Array = [];
		
		
		
		
		
		/**
		 * <span lang="ja">インスタンスのクラス名を取得します。</span>
		 * <span lang="en">Indicates the instance className of the Command.</span>
		 */
		public function get className():String { return _className; }
		private var _className:String;
		
		/**
		 * <span lang="ja">インスタンスの名前を取得または設定します。</span>
		 * <span lang="en">Indicates the instance name of the Command.</span>
		 */
		public function get name():String { return _name; }
		public function set name( value:String ):void { _name = value || "command_" + CommandCollection.progression_internal::__getNumByInstance( this ); }
		private var _name:String;
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得または設定します。</span>
		 * <span lang="en">Indicates the instance id of the Command.</span>
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void { _id = CommandCollection.progression_internal::__addInstanceAtId( this, value ); }
		private var _id:String;
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the Command.</span>
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = CommandCollection.progression_internal::__addInstanceAtGroup( this, value ); }
		private var _group:String;
		
		/**
		 * <span lang="ja">コマンドツリー構造の一番上に位置するコマンドを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get root():Command { return _root || this; }
		private var _root:Command;
		
		/**
		 * @private
		 */
		progression_internal function get __root():Command { return _root; }
		progression_internal function set __root( value:Command ):void { _root = value; }
		
		/**
		 * <span lang="ja">このコマンドを子に含んでいる親の CommandList インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get parent():CommandList { return _parent; }
		private var _parent:CommandList;
		
		/**
		 * @private
		 */
		progression_internal function get __parent():CommandList { return _parent; }
		progression_internal function set __parent( value:CommandList ):void { _parent = value; }
		
		/**
		 * <span lang="ja">このコマンドが CommandList インスタンスに関連付けられている場合に、次に位置するコマンドを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get next():Command { return _next; }
		private var _next:Command;
		
		/**
		 * @private
		 */
		progression_internal function get __next():Command { return _next; }
		progression_internal function set __next( value:Command ):void { _next = value; }
		
		/**
		 * <span lang="ja">このコマンドが CommandList インスタンスに関連付けられている場合に、前に位置するコマンドを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get previous():Command { return _previous; }
		private var _previous:Command;
		
		/**
		 * @private
		 */
		progression_internal function get __previous():Command { return _previous; }
		progression_internal function set __previous( value:Command ):void { _previous = value; }
		
		/**
		 * <span lang="ja">コマンドの深度を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get length():int { return _length; }
		private var _length:int = 1;
		
		/**
		 * @private
		 */
		progression_internal function get __length():int { return _length; }
		progression_internal function set __length( value:int ):void {
			_length = value;
			
			// インデントを設定する
			_indent = StringUtil.repeat( "  ", value );
		}
		
		/**
		 * @private
		 */
		private var _indent:String = "  ";
		
		/**
		 * <span lang="ja">コマンドが実行可能かどうかを取得または設定します。
		 * この値を false に設定した状態で execute() メソッドを実行すると、何も処理を行わずに CommandEvent.COMMAND_COMPLETE イベントを送出します。</span>
		 * <span lang="en"></span>
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void { _enabled = value; }
		private var _enabled:Boolean = true;
		
		/**
		 * <span lang="ja">コマンドが実行中かどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get running():Boolean { return _running; }
		private var _running:Boolean = false;
		
		/**
		 * <span lang="ja">コマンドが中断処理中かどうかを取得します。</span>
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
		 * プロセスが処理中かどうかを取得します。
		 */
		private var _processing:Boolean = false;
		
		/**
		 * <span lang="ja">コマンド実行までの遅延時間（ミリ秒）を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get delay():int { return _delay; }
		public function set delay( value:int ):void { _delay = Math.max( 0, value ); }
		private var _delay:int = 0;
		
		/**
		 * <span lang="ja">コマンド実行処理、および中断処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、もしくは interruptComplete() が実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</span>
		 * <span lang="en"></span>
		 */
		public function get timeOut():int { return _timeOut; }
		public function set timeOut( value:int ):void {
			_timeOut = Math.max( 0, value );
			
			// タイムアウト用 Timer が存在しなければ
			if ( !_timerTimeOut ) { return; }
			
			// 値が存在していれば
			if ( value > 0 ) {
				// タイムアウトを再設定する
				_timerTimeOut.reset();
				_timerTimeOut.delay = value;
				_timerTimeOut.start();
			}
			else {
				// イベントリスナーを解除する
				_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
				
				// タイムアウト用 Timer を破棄する
				_timerTimeOut = null;
			}
		}
		private var _timeOut:int = 0;
		
		/**
		 * <span lang="ja">コマンド実行処理、および中断処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、もしくは interruptComplete() が実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</span>
		 * <span lang="en"></span>
		 */
		public function get scope():Object { return _scope; }
		public function set scope( value:Object ):void { _scope = value || this; }
		private var _scope:Object;
		
		/**
		 * <span lang="ja">execute() メソッド実行時に引数として指定されたオブジェクトを取得します。
		 * このコマンドが親の CommandList インスタンスによって実行されている場合には、親の extra オブジェクトの内容をコマンド実行順にリレーする形で引き継ぎます。</span>
		 * <span lang="en"></span>
		 */
		public function get extra():Object { return _extra; }
		private var _extra:Object;
		
		/**
		 * <span lang="ja">CommandList 上で、自身より前に実行された外部データ読み込み系のコマンドが持っている外部データを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get latestData():* {
			// データが存在すれば
			if ( _latestData ) { return _latestData; }
			
			// 前が存在すれば
			if ( _previous ) { return _previous.latestData; }
			
			// 親が存在すれば
			if ( _parent ) { return _parent.latestData; }
			
			return null;
		}
		public function set latestData( value:* ):void { _latestData = value; }
		private var _latestData:*;
		
		/**
		 * 通常処理に使用する関数を取得します。
		 */
		private var _executeFunction:Function;
		
		/**
		 * 中断処理に使用する関数を取得します。
		 */
		private var _interruptFunction:Function;
		
		/**
		 * 事前処理に使用する関数と引数を取得します。
		 */
		private var _beforeFunction:Function;
		private var _beforeArgs:Array = [];
		
		/**
		 * 事後処理に使用する関数と引数を取得します。
		 */
		private var _afterFunction:Function;
		private var _afterArgs:Array = [];
		
		/**
		 * エラー処理に使用する関数を取得します。
		 */
		private var _errorFunction:Function;
		
		/**
		 * Timer インスタンスを取得します。 
		 */
		private var _timerDelay:Timer;
		private var _timerTimeOut:Timer;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Command インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Command object.</span>
		 * 
		 * @param executeFunction
		 * <span lang="ja">コマンドの実行関数です。</span>
		 * <span lang="en"></span>
		 * @param interruptFunction
		 * <span lang="ja">コマンドの中断関数です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Command( executeFunction:Function = null, interruptFunction:Function = null, initObject:Object = null ) {
			// クラス名を取得する
			_className = ClassUtil.getClassName( this );
			
			// CommandCollection に登録する
			CommandCollection.progression_internal::__addInstance( this );
			
			// 引数を設定する
			_executeFunction = executeFunction || executeComplete;
			_interruptFunction = interruptFunction || interruptComplete;
			
			// 初期化する
			this.name = null;
			this.scope = this;
			this.timeOut = _defaultTimeOut;
			setProperties( initObject );
			
			// initObject が Command であれば
			if ( initObject is Command ) {
				var com:Command = Command( initObject );
				
				// 特定のプロパティを継承する
				_delay = com._delay;
				_extra = com._extra;
				_executeFunction = com._executeFunction;
				_interruptFunction = com._interruptFunction;
				_beforeFunction = com._beforeFunction;
				_beforeArgs = com._beforeArgs.slice();
				_afterFunction = com._afterFunction;
				_afterArgs = com._afterArgs.slice();
				_errorFunction = com._errorFunction;
			}
		}
		
		
		
		
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている Command インスタンスを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function getCommandById( id:String ):Command {
			return CommandCollection.progression_internal::__getInstanceById( id );
		}
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ Command インスタンスを含む配列を返します。</span>
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
		public function getCommandsByGroup( group:String, sort:Boolean = false ):Array {
			return CommandCollection.progression_internal::__getInstancesByGroup( group, sort );
		}
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する Command インスタンスを含む配列を返します。</span>
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
		public function getCommandsByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return CommandCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/**
		 * <span lang="ja">コマンドに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">設定対象の Command インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function setProperties( props:Object ):Command {
			ObjectUtil.setProperties( this, props );
			
			return this;
		}
		
		/**
		 * <span lang="ja">コマンドを実行します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param extra
		 * <span lang="ja">実行時にコマンドフローをリレーするオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function execute( extra:Object = null ):void {
			// 実行中なら終了する
			if ( _running ) { return; }
			
			// 引数を保存する
			_extra = extra || {};
			
			// 処理を開始する
			_running = true;
			_processing = true; 
			
			// イベントを送出する
			dispatchEvent( new CommandEvent( CommandEvent.COMMAND_START ) );
			
			// 処理が終了されていれば
			if ( !_running ) { return; }
			
			// 無効化されていたら終了する
			if ( !_enabled ) {
				// 処理を終了する
				_running = false;
				_processing = false; 
				
				// イベントを送出する
				dispatchEvent( new CommandEvent( CommandEvent.COMMAND_COMPLETE ) );
				return;
			}
			
			// 実行コマンドリストに追加する
			if ( ArrayUtil.getItemIndex( _executedCommands, this ) == -1 ) {
				_executedCommands.push( this );
			}
			
			// 限界数以上の処理を実行していれば強制的に遅延させる
			if ( _processNum > _thresholdLength ) {
				_delay = Math.max( 1, _delay );
			}
			
			// 遅延時間の設定が存在しなければ処理を開始する
			if ( _delay == 0 ) {
				_executeStart();
				return;
			}
			
			// プロセスを終了する
			_processing = false;
			
			// 遅延用 Timer を初期化する
			_timerDelay = new Timer( _delay, 1 );
			_timerDelay.addEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteDelay, false, int.MAX_VALUE, true );
			_timerDelay.start();
		}
		
		/**
		 * コマンド処理の初期処理を行います。
		 */
		private function _executeStart():void {
			Verbose.log( this, _indent + VerboseMessageConstants.getMessage( "VERBOSE_0016", _className, _id || _name ) );
			
			// 事前処理が存在すれば
			if ( _beforeFunction is Function ) {
				try {
					// 処理を実行する
					_beforeFunction.apply( _scope, _beforeArgs );
				}
				catch ( e:Error ) {
					// エラーを送出する
					_catchError( this, e );
					return;
				}
			}
			
			// 処理が終了されていれば
			if ( !_running ) { return; }
			
			// タイムアウトが設定されていれば
			if ( _timeOut > 0 ) {
				// タイムアウト用 Timer を初期化する
				_timerTimeOut = new Timer( _timeOut, 1 );
				_timerTimeOut.addEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut, false, int.MAX_VALUE, true );
				_timerTimeOut.start();
			}
			
			// プロセスを追加する
			_processNum++;
			
			try {
				// 処理を実行する
				_executeFunction.apply( _scope );
			}
			catch ( e:Error ) {
				// エラー関数を実行する
				_catchError( this, e );
			}
			
			// プロセスを削除する
			_processNum = Math.max( 0, _processNum - 1 );
		}
		
		/**
		 * <span lang="ja">実行中のコマンド処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</span>
		 * <span lang="en"></span>
		 */
		public function executeComplete():void {
			// 実行していなければ終了する
			if ( !_running ) { return; }
			
			// タイムアウト用 Timer が存在すれば
			if ( _timerTimeOut ) {
				// イベントリスナーを解除する
				_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
				
				// タイムアウト用 Timer を破棄する
				_timerTimeOut = null;
			}
			
			// 事後処理が存在すれば
			if ( _afterFunction is Function ) {
				try {
					// 処理を実行する
					_afterFunction.apply( _scope, _afterArgs );
				}
				catch ( e:Error ) {
					// エラーを送出する
					_catchError( this, e );
					return;
				}
			}
			
			// 処理を終了する
			_running = false;
			_interrupting = false;
			_enforcedInterrupting = false;
			_processing = false;
			
			// 実行コマンドリストから削除する
			_executedCommands.splice( ArrayUtil.getItemIndex( _executedCommands, this ), 1 );
			
			// イベントを送出する
			dispatchEvent( new CommandEvent( CommandEvent.COMMAND_COMPLETE ) );
		}
		
		/**
		 * <span lang="ja">コマンド処理を中断します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param enforced
		 * <span lang="ja">現在実行中のコマンド以降の中断処理を無視して、強制的に中断するかどうかです。</span>
		 * <span lang="en"></span>
		 * @param extra
		 * <span lang="ja">実行時にコマンドフローをリレーするオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function interrupt( enforced:Boolean = false, extra:Object = null ):void {
			// 中断処理中なら終了する
			if ( _interrupting ) { return; }
			
			// 実行中ではなく、強制中断するのであれば
			if ( !_running && enforced ) {
				interruptComplete();
				return;
			}
			
			// 引数を保存する
			_extra = extra || {};
			
			// 実行コマンドリストに追加する
			if ( ArrayUtil.getItemIndex( _executedCommands, this ) == -1 ) {
				_executedCommands.push( this );
			}
			
			// 中断処理を開始する
			_interrupting = true;
			_enforcedInterrupting = enforced;
			
			// 中断処理を開始する
			_interruptStart();
		}
		
		/**
		 * コマンド中断処理の初期処理を行います。
		 */
		private function _interruptStart():void {
			Verbose.log( this, _indent + VerboseMessageConstants.getMessage( "VERBOSE_0017", _className, _id || _name ) );
			
			// 遅延中であれば
			if ( _timerDelay ) {
				// イベントリスナーを解除する
				_timerDelay.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteDelay );
				
				// 遅延用 Timer を破棄する
				_timerDelay = null;
				
				// 強制中断であれば
				if ( _enforcedInterrupting ) {
					interruptComplete();
					return;
				}
			}
			
			// タイムアウト用 Timer が存在すれば
			if ( _timerTimeOut ) {
				// イベントリスナーを解除する
				_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
				
				// タイムアウト用 Timer を破棄する
				_timerTimeOut = null;
			}
			
			// タイムアウトが設定されていれば
			if ( _timeOut > 0 ) {
				// タイムアウト用 Timer を初期化する
				_timerTimeOut = new Timer( _timeOut, 1 );
				_timerTimeOut.addEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut, false, int.MAX_VALUE, true );
				_timerTimeOut.start();
			}
			
			try {
				// 停止処理を開始する
				_interruptFunction.apply( _scope );
			}
			catch ( e:Error ) {
				// エラーを送出する
				_catchError( this, e );
			}
		}
		
		/**
		 * <span lang="ja">実行中のコマンド中断処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に interrupt() メソッドが実行されている必要があります。</span>
		 * <span lang="en"></span>
		 */
		public function interruptComplete():void {
			// 中断処理を実行していなければ終了する
			if ( !_interrupting ) { return; }
			
			// タイムアウト用 Timer が存在すれば
			if ( _timerTimeOut ) {
				// イベントリスナーを解除する
				_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
				
				// タイムアウト用 Timer を破棄する
				_timerTimeOut = null;
			}
			
			// 強制中断かどうかを保存する
			var enforcedInterrupting:Boolean = _enforcedInterrupting;
			
			// 処理を終了する
			_running = false;
			_interrupting = false;
			_enforcedInterrupting = false;
			_processing = false;
			
			// 実行コマンドリストから削除する
			_executedCommands.splice( ArrayUtil.getItemIndex( _executedCommands, this ), 1 );
			
			// イベントを送出する
			dispatchEvent( new CommandEvent( CommandEvent.COMMAND_INTERRUPT, false, false, enforcedInterrupting ) );
		}
		
		/**
		 * <span lang="ja">コマンド処理でエラーが発生した場合の処理を行います。
		 * エラー処理が発生すると、コマンド処理が停止します。
		 * 問題を解決し、通常フローに戻す場合には executeComplete() メソッドを、問題が解決されない為に中断処理を行いたい場合には interrupt() メソッドを実行してください。
		 * 関数内で問題が解決、または中断処理に移行しなかった場合には CommandEvent.COMMAND_ERROR イベントが送出されます。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @param error
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		protected function _catchError( target:Command, error:Error ):void {
			Verbose.error( this, _indent + VerboseMessageConstants.getMessage( "VERBOSE_0018", _className, _id || _name, ClassUtil.getClassName( error ) ) );
			
			// タイムアウト用 Timer が存在すれば
			if ( _timerTimeOut ) {
				// イベントリスナーを解除する
				_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
				
				// タイムアウト用 Timer を破棄する
				_timerTimeOut = null;
			}
			
			// エラー関数が登録されていれば
			if ( _errorFunction is Function ) {
				_errorFunction.apply( target, [ error ] );
			}
			else {
				// エラーの発生源であれば内容を表示する
				if ( target == this ) {
					trace.apply( null, [ error.getStackTrace() ] );
				}
			}
			
			// 問題が解決されなければ
			if ( target.running ) {
				// イベントを送出する
				dispatchEvent( new CommandEvent( CommandEvent.COMMAND_ERROR, false, false, _enforcedInterrupting, error ) );
			}
		}
		
		/**
		 * <span lang="ja">コマンドの実行直前に処理させたい関数を設定します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param beforeFunction
		 * <span lang="ja">実行させたい関数です。</span>
		 * <span lang="en"></span>
		 * @param beforeArgs
		 * <span lang="ja">関数実行時に引数として使用したい配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function before( beforeFunction:Function, ... beforeArgs:Array ):Command {
			_beforeFunction = beforeFunction;
			_beforeArgs = beforeArgs || [];
			return this;
		}
		
		/**
		 * <span lang="ja">コマンドの実行完了直後に処理させたい関数を設定します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param afterFunction
		 * <span lang="ja">実行させたい関数です。</span>
		 * <span lang="en"></span>
		 * @param afterArgs
		 * <span lang="ja">関数実行時に引数として使用したい配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function after( afterFunction:Function, ... afterArgs:Array ):Command {
			_afterFunction = afterFunction;
			_afterArgs = afterArgs || [];
			return this;
		}
		
		/**
		 * <span lang="ja">コマンドに対してすぐに関数を実行します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param applyFunction
		 * <span lang="ja">実行させたい関数です。</span>
		 * <span lang="en"></span>
		 * @param applyArgs
		 * <span lang="ja">関数実行時に引数として使用したい配列です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function apply( applyFunction:Function, ... applyArgs:Array ):Command {
			applyFunction.apply( this, applyArgs );
			return this;
		}
		
		/**
		 * <span lang="ja">コマンド実行中にイベントが発生した場合に呼び出されるリスナー関数を設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en"></span>
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en"></span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en"></span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function listen( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0 ):Command {
			addEventListener( type, listener, useCapture, priority, true );
			return this;
		}
		
		/**
		 * <span lang="ja">コマンド実行中に例外エラーが発生した場合に呼び出される関数を設定します。
		 * 関数実行時の this 参照はエラーが発生したコマンドインスタンスになります。</span>
		 * <span lang="en"></span>
		 * 
		 * @param errorFunction
		 * <span lang="ja">実行させたい関数です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">自身の参照です。</span>
		 * <span lang="en"></span>
		 */
		public function error( errorFunction:Function ):Command {
			_errorFunction = errorFunction;
			return this;
		}
		
		/**
		 * <span lang="ja">Command インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Command subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Command インスタンスです。</span>
		 * <span lang="en">A new Command object that is identical to the original.</span>
		 */
		public function clone():Command {
			return new Command( _executeFunction, _interruptFunction, this );
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
			return '[' + _className + ' id="' + _id + '" name="' + _name + '" group="' + _group + '"]';
		}
		
		
		
		
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerCompleteDelay( e:TimerEvent ):void {
			// イベントリスナーを解除する
			_timerDelay.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteDelay );
			
			// 遅延用 Timer を破棄する
			_timerDelay = null;
			
			// 処理を開始する
			_executeStart();
		}
		
		/**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerCompleteTimeOut( e:TimerEvent ):void {
			// イベントリスナーを解除する
			_timerTimeOut.removeEventListener( TimerEvent.TIMER_COMPLETE, _timerCompleteTimeOut );
			
			// タイムアウト用 Timer を破棄する
			_timerTimeOut = null;
			
			// エラーを送出する
			_catchError( this, new CommandTimeOutError( ErrorMessageConstants.getMessage( "ERROR_9021", this ) ) );
		}
	}
}
