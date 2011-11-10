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
package jp.progression.scenes {
	import flash.errors.IllegalOperationError;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.commands.Command;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneObject;
	
	/*======================================================================*//**
	 * <p>ResumingScene クラスは、Command を使用せずに関数でイベントフローを制御するシーンクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ResumingScene extends SceneObject {
		
		/*======================================================================*//**
		 * <p>実行処理のタイムアウト時間（ミリ秒）を取得または設定します。
		 * 指定された時間中に resume() メソッドが実行されなかった場合にエラーが送出されます。
		 * この値が 0 に設定されている場合、タイムアウトは発生しません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get timeOut():int { return _timeOut; }
		public function set timeOut( value:int ):void { _timeOut = Math.max( 0, value ); }
		private var _timeOut:int = 10000;
		
		/*======================================================================*//**
		 * <p>SceneEvent.LOAD イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeLoad():Boolean { return !!_resumeLoad; }
		public function set resumeLoad( value:Boolean ):void { _resumeLoad = value ? SceneEvent.LOAD : null; }
		private var _resumeLoad:String;
		
		/*======================================================================*//**
		 * <p>SceneEvent.UNLOAD イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeUnload():Boolean { return !!_resumeUnload; }
		public function set resumeUnload( value:Boolean ):void { _resumeUnload = value ? SceneEvent.UNLOAD : null; }
		private var _resumeUnload:String;
		
		/*======================================================================*//**
		 * <p>SceneEvent.INIT イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeInit():Boolean { return !!_resumeInit; }
		public function set resumeInit( value:Boolean ):void { _resumeInit = value ? SceneEvent.INIT : null; }
		private var _resumeInit:String;
		
		/*======================================================================*//**
		 * <p>SceneEvent.GOTO イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeGoto():Boolean { return !!_resumeGoto; }
		public function set resumeGoto( value:Boolean ):void { _resumeGoto = value ? SceneEvent.GOTO : null; }
		private var _resumeGoto:String;
		
		/*======================================================================*//**
		 * <p>SceneEvent.DESCEND イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeDescend():Boolean { return !!_resumeDescend; }
		public function set resumeDescend( value:Boolean ):void { _resumeDescend = value ? SceneEvent.DESCEND : null; }
		private var _resumeDescend:String = SceneEvent.DESCEND;
		
		/*======================================================================*//**
		 * <p>SceneEvent.ASCEND イベントが発生した際に、レジューム処理を行うかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get resumeAscend():Boolean { return !!_resumeAscend; }
		public function set resumeAscend( value:Boolean ):void { _resumeAscend = value ? SceneEvent.ASCEND : null; }
		private var _resumeAscend:String = SceneEvent.ASCEND;
		
		/*======================================================================*//**
		 * @private
		 */
		public override function get parallelMode():Boolean { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parallelMode" ) ); }
		public override function set parallelMode( value:Boolean ):void { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_8000", "parallelMode" ) ); }
		
		/*======================================================================*//**
		 * イベントタイプを取得します。
		 */
		private var _eventType:String;
		
		/*======================================================================*//**
		 * Command インスタンスを取得します。
		 */
		private var _command:Command = new Command( function():void {} );
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ResumingScene インスタンスを作成します。</p>
		 * <p>Creates a new ResumingScene object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param name
		 * 	<p>シーンの名前です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
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
		
		
		
		
		
		/*======================================================================*//**
		 * <p>現在実行中のイベントを完了させます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>完了させたいイベントタイプです。このパラメータを省略すると全てのイベントタイプに対して有効になります。</p>
		 * 	<p></p>
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
		
		/*======================================================================*//**
		 * @private
		 */
		public override function addCommand( ... commands:Array ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "addCommand" ) );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		public override function insertCommand( ... commands:Array ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "insertCommand" ) );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		public override function clearCommand( completely:Boolean = false ):void {
			throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_1001", "clearCommand" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
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









