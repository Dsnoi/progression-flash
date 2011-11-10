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
	import flash.display.DisplayObjectContainer;
	import jp.nium.display.ChildIterator;
	import jp.progression.core.commands.Command;
	import jp.progression.events.CommandEvent;
	
	/**
	 * <span lang="ja">RemoveAllChildren クラスは、対象の DisplayObjectContainer インスタンスに登録されている全てのディスプレイオブジェクトを削除するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
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
		
		/**
		 * <span lang="ja">全てのインスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get container():DisplayObjectContainer { return _container; }
		public function set container( value:DisplayObjectContainer ):void { _container = value; }
		private var _container:DisplayObjectContainer;
		
		/**
		 * <span lang="ja">全てのインスタンスを表示する際に、alpha プロパティを使用したアルファフェード効果を適用するミリ秒を取得または設定します。
		 * この値が 0 である場合には、アルファフェード効果は無効化されます。</span>
		 * <span lang="en"></span>
		 */
		public function get autoAlpha():int { return _autoAlpha; }
		public function set autoAlpha( value:int ):void { _autoAlpha = Math.max( 0, value ); }
		private var _autoAlpha:int = 0;
		
		/**
		 * ParallelList インスタンスを取得します。 
		 */
		private var _commandList:ParallelList;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい RemoveAllChildren インスタンスを作成します。</span>
		 * <span lang="en">Creates a new RemoveAllChildren object.</span>
		 * 
		 * @param container
		 * <span lang="ja">全てのインスタンスを削除する対象のディスプレイリストを含む DisplayObjectContainer インスタンスです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function RemoveAllChildren( container:DisplayObjectContainer, initObject:Object = null ) {
			// 引数を設定する
			_container = container;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
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
		
		/**
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
		
		/**
		 * <span lang="ja">RemoveAllChildren インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an RemoveAllChildren subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい RemoveAllChildren インスタンスです。</span>
		 * <span lang="en">A new RemoveAllChildren object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new RemoveAllChildren( _container, this ).setProperties( {
				autoAlpha:_autoAlpha
			} );
		}
		
		
		
		
		
		/**
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
		
		/**
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
		
		/**
		 * コマンド処理中にエラーが発生した場合に送出されます。
		 */
		private function _commandError( e:CommandEvent ):void {
			// エラー処理を実行する
			_catchError( Command( e.target ), e.errorObject );
		}
	}
}
