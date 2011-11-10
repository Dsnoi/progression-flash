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
package jp.progression.commands {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.collections.ProgressionCollection;
	import jp.progression.core.commands.Command;
	import jp.progression.core.errors.CommandExecuteError;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.events.ProcessEvent;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneId;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">Goto クラスは、指定されたシーン識別子の指すシーンに移動するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">移動先を示すシーン識別子を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get sceneId():SceneId { return _sceneId; }
		public function set sceneId( value:SceneId ):void { _sceneId = value; }
		private var _sceneId:SceneId;
		
		/**
		 * Progression インスタンスを取得します。
		 */
		private var _progression:Progression;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Goto インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Goto object.</span>
		 * 
		 * @param sceneId
		 * <span lang="ja">移動先を示すシーン識別子です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Goto( sceneId:SceneId, initObject:Object = null ) {
			// 引数を設定する
			_sceneId = sceneId;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// Progression を取得する
			_progression = ProgressionCollection.progression_internal::__getInstanceBySceneId( _sceneId );
			
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
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">Goto インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Goto subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Goto インスタンスです。</span>
		 * <span lang="en">A new Goto object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Goto( _sceneId, this );
		}
		
		
		
		
		
		/**
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
