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
package jp.progression.scenes {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.commands.Command;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <span lang="ja">ResumingScene クラスは、Command を使用せずに関数でイベントフローを制御するシーンクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ResumingScene extends SceneObject {
		
		/**
		 * <span lang="ja">実行処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に resume() メソッドが実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</span>
		 * <span lang="en"></span>
		 */
		public function get timeOut():int { return _timeOut; }
		public function set timeOut( value:int ):void { _timeOut = Math.max( 0, value ); }
		private var _timeOut:int = 10000;
		
		/**
		 * <span lang="ja">SceneEvent.LOAD イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeLoad():Boolean { return !!_resumeLoad; }
		public function set resumeLoad( value:Boolean ):void { _resumeLoad = value ? SceneEvent.LOAD : null; }
		private var _resumeLoad:String;
		
		/**
		 * <span lang="ja">SceneEvent.UNLOAD イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeUnload():Boolean { return !!_resumeUnload; }
		public function set resumeUnload( value:Boolean ):void { _resumeUnload = value ? SceneEvent.UNLOAD : null; }
		private var _resumeUnload:String;
		
		/**
		 * <span lang="ja">SceneEvent.INIT イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeInit():Boolean { return !!_resumeInit; }
		public function set resumeInit( value:Boolean ):void { _resumeInit = value ? SceneEvent.INIT : null; }
		private var _resumeInit:String;
		
		/**
		 * <span lang="ja">SceneEvent.GOTO イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeGoto():Boolean { return !!_resumeGoto; }
		public function set resumeGoto( value:Boolean ):void { _resumeGoto = value ? SceneEvent.GOTO : null; }
		private var _resumeGoto:String;
		
		/**
		 * <span lang="ja">SceneEvent.DESCEND イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeDescend():Boolean { return !!_resumeDescend; }
		public function set resumeDescend( value:Boolean ):void { _resumeDescend = value ? SceneEvent.DESCEND : null; }
		private var _resumeDescend:String = SceneEvent.DESCEND;
		
		/**
		 * <span lang="ja">SceneEvent.ASCEND イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get resumeAscend():Boolean { return !!_resumeAscend; }
		public function set resumeAscend( value:Boolean ):void { _resumeAscend = value ? SceneEvent.ASCEND : null; }
		private var _resumeAscend:String = SceneEvent.ASCEND;
		
		/**
		 * @private
		 */
		public override function get parallelMode():Boolean { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parallelMode" ) ); }
		public override function set parallelMode( value:Boolean ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parallelMode" ) ); }
		
		/**
		 * イベントタイプを取得します。
		 */
		private var _eventType:String;
		
		/**
		 * Command インスタンスを取得します。
		 */
		private var _command:Command = new Command( function():void {} );
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ResumingScene インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ResumingScene object.</span>
		 * 
		 * @param name
		 * <span lang="ja">シーンの名前です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function ResumingScene( name:String = null, initObject:Object = null ) {
			// スーパークラスを初期化する
			super( name, initObject );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( SceneEvent.LOAD, _sceneEvent, false, 0, true );
			addExclusivelyEventListener( SceneEvent.UNLOAD, _sceneEvent, false, 0, true );
			addExclusivelyEventListener( SceneEvent.INIT, _sceneEvent, false, 0, true );
			addExclusivelyEventListener( SceneEvent.GOTO, _sceneEvent, false, 0, true );
			addExclusivelyEventListener( SceneEvent.DESCEND, _sceneEvent, false, 0, true );
			addExclusivelyEventListener( SceneEvent.ASCEND, _sceneEvent, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">現在実行中のイベントを完了させます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param type
		 * <span lang="ja">完了させたいイベントタイプです。このパラメータを省略すると全てのイベントタイプに対して有効になります。</span>
		 * <span lang="en"></span>
		 */
		public function resume( type:String = null ):void {
			// type が存在し、現在のイベントと違っていれば終了する
			if ( type && _eventType != type ) { return; }
			
			// すでに実行されていれば
			if ( executor.running ) {
				// コマンドを完了する
				_command.executeComplete();
			}
			else {
				// コマンドを削除する
				super.clearCommand();
			}
		}
		
		/**
		 * @private
		 */
		public override function addCommand( ... commands:Array ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "addCommand" ) );
		}
		
		/**
		 * @private
		 */
		public override function insertCommand( ... commands:Array ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "insertCommand" ) );
		}
		
		/**
		 * @private
		 */
		public override function clearCommand( completely:Boolean = false ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "clearCommand" ) );
		}
		
		
		
		
		
		/**
		 * SceneEvent イベントが発生した瞬間に送出されます。
		 */
		private function _sceneEvent( e:SceneEvent ):void {
			// イベントタイプを保存する
			_eventType = e.eventType;
			
			// イベントがレジューム対象に設定されていれば
			switch ( e.type ) {
				case _resumeLoad		:
				case _resumeUnload		:
				case _resumeInit		:
				case _resumeGoto		:
				case _resumeDescend		:
				case _resumeAscend		: { break; }
				default					: { return; }
			}
			
			// タイムアウトを設定する
			_command.timeOut = _timeOut;
			
			// コマンドを実行する
			super.addCommand( _command );
		}
	}
}
