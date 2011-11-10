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
package jp.progression.commands {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.commands.Command;
	import jp.progression.core.errors.CommandExecuteError;
	import jp.progression.events.ProcessEvent;
	import jp.progression.getProgressionBySceneId;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	/*======================================================================*//**
	 * <p>Goto クラスは、指定されたシーン識別子の指すシーンに移動するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // Progression インスタンスを作成します。
	 * var prog:Progression = new Progression( "index", stage );
	 * 
	 * // Goto コマンドを作成します。
	 * var com:Goto = new Goto( new SceneId( "/index" ) );
	 * 
	 * // Goto コマンドでルートシーンに移動します。
	 * com.execute();
	 * </listing>
	 */
	public class Goto extends Command {
		
		/*======================================================================*//**
		 * <p>移動先を示すシーン識別子を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get sceneId():SceneId { return _sceneId; }
		public function set sceneId( value:SceneId ):void { _sceneId = value; }
		private var _sceneId:SceneId;
		
		/*======================================================================*//**
		 * Progression インスタンスを取得します。
		 */
		private var _progression:Progression;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Goto インスタンスを作成します。</p>
		 * <p>Creates a new Goto object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param sceneId
		 * 	<p>移動先を示すシーン識別子です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Goto( sceneId:SceneId = null, initObject:Object = null ) {
			// 引数を設定する
			_sceneId = sceneId;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// 初期化する
			timeOut = initObject ? initObject.timeOut : 0;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// Progression を取得する
			_progression = getProgressionBySceneId( _sceneId );
			
			// 存在しなければ終了する
			if ( !_progression ) {
				_catchError( this, new CommandExecuteError( ErrorMessageConstants.getMessage( "ERROR_9018" ) ) );
				return;
			}
			
			// すでに実行されていれば中断する
			if ( _progression.running ) {
				_progression.addExclusivelyEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt, false, int.MAX_VALUE, true );
				_progression.interrupt( true );
				return;
			}
			
			// 移動する
			_progression.goto( _sceneId );
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>Goto インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Goto subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Goto インスタンスです。</p>
		 * 	<p>A new Goto object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Goto( _sceneId, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * イベント処理が停止された場合に送出されます。
		 */
		private function _processInterrupt( e:ProcessEvent ):void {
			// イベントリスナーを解除する
			_progression.completelyRemoveEventListener( ProcessEvent.PROCESS_INTERRUPT, _processInterrupt );
			
			// 移動する
			_progression.goto( _sceneId );
			
			// 処理を終了する
			executeComplete();
		}
	}
}









