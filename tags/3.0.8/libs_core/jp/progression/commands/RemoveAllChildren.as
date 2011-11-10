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
	import flash.display.DisplayObjectContainer;
	import jp.nium.display.ChildIterator;
	import jp.progression.core.commands.Command;
	import jp.progression.events.CommandEvent;
	
	/*======================================================================*//**
	 * <p>RemoveAllChildren クラスは、対象の DisplayObjectContainer インスタンスに登録されている全てのディスプレイオブジェクトを削除するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // 表示コンテナに追加する CastSprite インスタンスを作成します。
	 * var child1:CastSprite = new CastSprite();
	 * var child2:CastSprite = new CastSprite();
	 * var child3:CastSprite = new CastSprite();
	 * 
	 * // container インスタンスの子として child1 ～ child3 インスタンスを登録します。
	 * container.addChild( child1 );
	 * container.addChild( child2 );
	 * container.addChild( child3 );
	 * 
	 * // RemoveAllChildren コマンドを作成します。
	 * var com:RemoveAllChildren = new RemoveAllChildren( container );
	 * 
	 * // RemoveAllChildren コマンドを実行します。
	 * com.execute();
	 * 
	 * // 結果を出力します。
	 * trace( container.contains( child1 ) ); // false
	 * trace( container.contains( child2 ) ); // false
	 * trace( container.contains( child3 ) ); // false
	 * </listing>
	 */
	public class RemoveAllChildren extends Command {
		
		/*======================================================================*//**
		 * <p>全てのインスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/*======================================================================*//**
		 * <p>全てのインスタンスを表示する際に、alpha プロパティを使用したアルファフェード効果を適用するミリ秒を取得または設定します。
		 * この値が 0 である場合には、アルファフェード効果は無効化されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get autoAlpha():int { return _autoAlpha; }
		public function set autoAlpha( value:int ):void { _autoAlpha = Math.max( 0, value ); }
		private var _autoAlpha:int = 0;
		
		/*======================================================================*//**
		 * ParallelList インスタンスを取得します。 
		 */
		private var _commandList:ParallelList;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい RemoveAllChildren インスタンスを作成します。</p>
		 * <p>Creates a new RemoveAllChildren object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param container
		 * 	<p>全てのインスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスです。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function RemoveAllChildren( container:DisplayObjectContainer = null, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
			
			// 初期化する
			timeOut = initObject ? initObject.timeOut : 0;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// ParallelList を作成する
			_commandList = new ParallelList();
			
			// ChildIterator を作成する
			var iterator:ChildIterator = new ChildIterator( _container );
			while ( iterator.hasNext() ) {
				_commandList.addCommand( new RemoveChild( _container, iterator.next(), { autoAlpha:_autoAlpha } ) );
			}
			
			// 処理を実行する
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
			_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
			_commandList.execute( extra );
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 実行中のコマンドがあれば
			if ( _commandList ) {
				_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete, false, int.MAX_VALUE, true );
				_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt, false, int.MAX_VALUE, true );
				_commandList.addExclusivelyEventListener( CommandEvent.COMMAND_ERROR, _commandError, false, int.MAX_VALUE, true );
				_commandList.interrupt( enforcedInterrupting, extra );
				return;
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>RemoveAllChildren インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an RemoveAllChildren subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい RemoveAllChildren インスタンスです。</p>
		 * 	<p>A new RemoveAllChildren object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new RemoveAllChildren( _container, this ).setProperties( {
				autoAlpha:_autoAlpha
			} );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * コマンドの処理が完了した場合に送出されます。
		 */
		private function _commandComplete( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// コマンドを消去する
			_commandList = null;
			
			// 処理を完了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * コマンドの処理を停止した場合に送出されます。
		 */
		private function _commandInterrupt( e:CommandEvent ):void {
			// イベントリスナーを解除する
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_COMPLETE, _commandComplete );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_INTERRUPT, _commandInterrupt );
			_commandList.completelyRemoveEventListener( CommandEvent.COMMAND_ERROR, _commandError );
			
			// コマンドを消去する
			_commandList = null;
			
			// 中断処理を実行する
			if ( interrupting ) {
				interruptComplete();
			}
			else {
				interrupt( e.enforcedInterrupted, extra );
			}
		}
		
		/*======================================================================*//**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// エラー処理を実行する
			_catchError( Command( e.target ), e.errorObject );
		}
	}
}









