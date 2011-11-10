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
package jp.progression.core.commands {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.errors.FormatError;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.core.collections.CommandCollection;
	import jp.progression.core.commands.CommandList;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.errors.CommandExecuteError;
	import jp.progression.core.errors.CommandTimeOutError;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.CommandEvent;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>コマンドの処理が開始された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_START
	 */
	[Event( name="commandStart", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>コマンドの処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_COMPLETE
	 */
	[Event( name="commandComplete", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>コマンドの処理を停止した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_INTERRUPT
	 */
	[Event( name="commandInterrupt", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>コマンド処理中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_ERROR
	 */
	[Event( name="commandError", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>コマンドがコマンドリストに追加された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_ADDED
	 */
	[Event( name="commandAdded", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>コマンドがコマンドリストから削除された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.progression.events.CommandEvent.COMMAND_REMOVED
	 */
	[Event( name="commandRemoved", type="jp.progression.events.CommandEvent" )]
	
	/*======================================================================*//**
	 * <p>Command クラスは、全てのコマンドの基本となるクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class Command extends EventIntegrator {
		
		/*======================================================================*//**
		 * @private
		 */
		public static function get defaultTimeOut():int { return _defaultTimeOut; }
		public static function set defaultTimeOut( value:int ):void { _defaultTimeOut = Math.max( 0, value ); }
		private static var _defaultTimeOut:int = 15000;
		
		/*======================================================================*//**
		 * @private
		 */
		public static function get thresholdLength():int { return _thresholdLength; }
		public static function set thresholdLength( value:int ):void { _thresholdLength = Math.max( 0, value ); }
		private static var _thresholdLength:int = 200;
		
		/*======================================================================*//**
		 * 現在のプロセス数を取得します。
		 */
		private static function get _processNum():int { return __processNum; }
		private static function set _processNum( value:int ):void { __processNum = Math.max( 0, value ); }
		private static var __processNum:int = 0;
		
		/*======================================================================*//**
		 * 実行中の Command インスタンスの参照を格納した配列を取得します。
		 */
		private static var _executedCommands:Array = [];
		
		
		
		
		
		/*======================================================================*//**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the Command.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get className():String { return _className; }
		private var _className:String;
		
		/*======================================================================*//**
		 * <p>インスタンスの名前を取得または設定します。</p>
		 * <p>Indicates the instance name of the Command.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get name():String { return _name; }
		public function set name( value:String ):void { _name = value || "command_" + CommandCollection.progression_internal::__getNumByInstance( this ); }
		private var _name:String;
		
		/*======================================================================*//**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id of the Command.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void { _id = CommandCollection.progression_internal::__addInstanceAtId( this, value ); }
		private var _id:String;
		
		/*======================================================================*//**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the Command.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = CommandCollection.progression_internal::__addInstanceAtGroup( this, value ); }
		private var _group:String;
		
		/*======================================================================*//**
		 * <p>コマンドツリー構造の一番上に位置するコマンドを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get root():Command { return _root || this; }
		private var _root:Command;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __root():Command { return _root; }
		progression_internal function set __root( value:Command ):void { _root = value; }
		
		/*======================================================================*//**
		 * <p>このコマンドを子に含んでいる親の CommandList インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parent():CommandList { return _parent; }
		private var _parent:CommandList;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __parent():CommandList { return _parent; }
		progression_internal function set __parent( value:CommandList ):void { _parent = value; }
		
		/*======================================================================*//**
		 * <p>このコマンドが CommandList インスタンスに関連付けられている場合に、次に位置するコマンドを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get next():Command { return _next; }
		private var _next:Command;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __next():Command { return _next; }
		progression_internal function set __next( value:Command ):void { _next = value; }
		
		/*======================================================================*//**
		 * <p>このコマンドが CommandList インスタンスに関連付けられている場合に、前に位置するコマンドを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get previous():Command { return _previous; }
		private var _previous:Command;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __previous():Command { return _previous; }
		progression_internal function set __previous( value:Command ):void { _previous = value; }
		
		/*======================================================================*//**
		 * <p>コマンドの深度を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get length():int { return _length; }
		private var _length:int = 1;
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal function get __length():int { return _length; }
		progression_internal function set __length( value:int ):void {
			_length = value;
			
			// インデントを設定する
			_indent = StringUtil.repeat( "  ", value );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		private var _indent:String = "  ";
		
		/*======================================================================*//**
		 * <p>コマンドが実行可能かどうかを取得または設定します。
		 * この値を false に設定した状態で execute() メソッドを実行すると、何も処理を行わずに CommandEvent.COMMAND_COMPLETE イベントを送出します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void { _enabled = value; }
		private var _enabled:Boolean = true;
		
		/*======================================================================*//**
		 * <p>コマンドが実行中かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get running():Boolean { return _running; }
		private var _running:Boolean = false;
		
		/*======================================================================*//**
		 * <p>コマンドが中断処理中かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get interrupting():Boolean { return _interrupting; }
		private var _interrupting:Boolean = false;
		
		/*======================================================================*//**
		 * <p>コマンドが強制中断処理中かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enforcedInterrupting():Boolean { return _enforcedInterrupting; }
		private var _enforcedInterrupting:Boolean = false;
		
		/*======================================================================*//**
		 * プロセスが処理中かどうかを取得します。
		 */
		private var _processing:Boolean = false;
		
		/*======================================================================*//**
		 * <p>コマンド実行までの遅延時間（ミリ秒）を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get delay():int { return _delay; }
		public function set delay( value:int ):void { _delay = Math.max( 0, value ); }
		private var _delay:int = 0;
		
		/*======================================================================*//**
		 * <p>コマンド実行処理、および中断処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、もしくは interruptComplete() が実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>コマンド実行処理、および中断処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に executeComplete() メソッド、もしくは interruptComplete() が実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get scope():Object { return _scope; }
		public function set scope( value:Object ):void { _scope = value || this; }
		private var _scope:Object;
		
		/*======================================================================*//**
		 * <p>execute() メソッド実行時に引数として指定されたオブジェクトを取得します。
		 * このコマンドが親の CommandList インスタンスによって実行されている場合には、親の extra オブジェクトの内容をコマンド実行順にリレーする形で引き継ぎます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get extra():Object { return _extra; }
		private var _extra:Object;
		
		/*======================================================================*//**
		 * <p>CommandList 上で、自身より前に実行された外部データ読み込み系のコマンドが持っている外部データを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * 通常処理に使用する関数を取得します。
		 */
		private var _executeFunction:Function;
		
		/*======================================================================*//**
		 * 中断処理に使用する関数を取得します。
		 */
		private var _interruptFunction:Function;
		
		/*======================================================================*//**
		 * 事前処理に使用する関数と引数を取得します。
		 */
		private var _beforeFunction:Function;
		private var _beforeArgs:Array = [];
		
		/*======================================================================*//**
		 * 事後処理に使用する関数と引数を取得します。
		 */
		private var _afterFunction:Function;
		private var _afterArgs:Array = [];
		
		/*======================================================================*//**
		 * エラー処理に使用する関数を取得します。
		 */
		private var _errorFunction:Function;
		
		/*======================================================================*//**
		 * Timer インスタンスを取得します。 
		 */
		private var _timerDelay:Timer;
		private var _timerTimeOut:Timer;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Command インスタンスを作成します。</p>
		 * <p>Creates a new Command object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param executeFunction
		 * 	<p>コマンドの実行関数です。</p>
		 * 	<p></p>
		 * @param interruptFunction
		 * 	<p>コマンドの中断関数です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
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
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された id と同じ値が設定されている Command インスタンスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getCommandById( id:String ):Command {
			return CommandCollection.progression_internal::__getInstanceById( id );
		}
		
		/*======================================================================*//**
		 * <p>指定された group と同じ値を持つ Command インスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param group
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getCommandsByGroup( group:String, sort:Boolean = false ):Array {
			return CommandCollection.progression_internal::__getInstancesByGroup( group, sort );
		}
		
		/*======================================================================*//**
		 * <p>指定された fieldName が条件と一致する Command インスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param fieldName
		 * 	<p>調査するフィールド名です。</p>
		 * 	<p></p>
		 * @param pattern
		 * 	<p>条件となる正規表現です。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getCommandsByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return CommandCollection.progression_internal::__getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/*======================================================================*//**
		 * <p>コマンドに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param props
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>設定対象の Command インスタンスです。</p>
		 * 	<p></p>
		 */
		public function setProperties( props:Object ):Command {
			ObjectUtil.setProperties( this, props );
			
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンドを実行します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param extra
		 * 	<p>実行時にコマンドフローをリレーするオブジェクトです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
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
			_processNum--;
		}
		
		/*======================================================================*//**
		 * <p>実行中のコマンド処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>コマンド処理を中断します。
		 * このメソッドを実行するためには、事前に execute() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param enforced
		 * 	<p>現在実行中のコマンド以降の中断処理を無視して、強制的に中断するかどうかです。</p>
		 * 	<p></p>
		 * @param extra
		 * 	<p>実行時にコマンドフローをリレーするオブジェクトです。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * <p>実行中のコマンド中断処理が完了したことを通知します。
		 * このメソッドを実行するためには、事前に interrupt() メソッドが実行されている必要があります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>コマンド処理でエラーが発生した場合の処理を行います。
		 * エラー処理が発生すると、コマンド処理が停止します。
		 * 問題を解決し、通常フローに戻す場合には executeComplete() メソッドを、問題が解決されない為に中断処理を行いたい場合には interrupt() メソッドを実行してください。
		 * 関数内で問題が解決、または中断処理に移行しなかった場合には CommandEvent.COMMAND_ERROR イベントが送出されます。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p></p>
		 * 	<p></p>
		 * @param error
		 * 	<p></p>
		 * 	<p></p>
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
			} else {
				// エラーの発生源であれば内容を表示する
				if ( target == this ) {
					trace( error );
				}
			}
			
			// 問題が解決されなければ
			if ( target.running ) {
				// イベントを送出する
				dispatchEvent( new CommandEvent( CommandEvent.COMMAND_ERROR, false, false, _enforcedInterrupting, error ) );
			}
		}
		
		/*======================================================================*//**
		 * <p>コマンドの実行直前に処理させたい関数を設定します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param beforeFunction
		 * 	<p>実行させたい関数です。</p>
		 * 	<p></p>
		 * @param beforeArgs
		 * 	<p>関数実行時に引数として使用したい配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public function before( beforeFunction:Function, ... beforeArgs:Array ):Command {
			_beforeFunction = beforeFunction;
			_beforeArgs = beforeArgs || [];
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンドの実行完了直後に処理させたい関数を設定します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param afterFunction
		 * 	<p>実行させたい関数です。</p>
		 * 	<p></p>
		 * @param afterArgs
		 * 	<p>関数実行時に引数として使用したい配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public function after( afterFunction:Function, ... afterArgs:Array ):Command {
			_afterFunction = afterFunction;
			_afterArgs = afterArgs || [];
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンドに対してすぐに関数を実行します。
		 * 関数実行時の this 参照は実行しているコマンドインスタンスになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param applyFunction
		 * 	<p>実行させたい関数です。</p>
		 * 	<p></p>
		 * @param applyArgs
		 * 	<p>関数実行時に引数として使用したい配列です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public function apply( applyFunction:Function, ... applyArgs:Array ):Command {
			applyFunction.apply( this, applyArgs );
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンド実行中にイベントが発生した場合に呼び出されるリスナー関数を設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p></p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p></p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p></p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public function listen( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0 ):Command {
			addEventListener( type, listener, useCapture, priority, true );
			return this;
		}
		
		/*======================================================================*//**
		 * <p>コマンド実行中に例外エラーが発生した場合に呼び出される関数を設定します。
		 * 関数実行時の this 参照はエラーが発生したコマンドインスタンスになります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param errorFunction
		 * 	<p>実行させたい関数です。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>自身の参照です。</p>
		 * 	<p></p>
		 */
		public function error( errorFunction:Function ):Command {
			_errorFunction = errorFunction;
			return this;
		}
		
		/*======================================================================*//**
		 * <p>Command インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Command subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Command インスタンスです。</p>
		 * 	<p>A new Command object that is identical to the original.</p>
		 */
		public function clone():Command {
			return new Command( _executeFunction, _interruptFunction, this );
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>オブジェクトのストリング表現です。</p>
		 * 	<p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return '[' + _className + ' id="' + _id + '" name="' + _name + '" group="' + _group + '"]';
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
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









