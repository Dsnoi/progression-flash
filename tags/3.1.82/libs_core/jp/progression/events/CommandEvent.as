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
package jp.progression.events {
	import flash.events.Event;
	
	/**
	 * <span lang="ja">Command オブジェクトが処理を実行、完了、中断、等を行った場合に CommandEvent オブジェクトが送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CommandEvent extends Event {
		
		/**
		 * <span lang="ja">commandStart イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_START constant defines the value of the type property of an commandStart event object.</span>
		 */
		public static const COMMAND_START:String = "commandStart";
		
		/**
		 * <span lang="ja">commandComplete イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_COMPLETE constant defines the value of the type property of an commandComplete event object.</span>
		 */
		public static const COMMAND_COMPLETE:String = "commandComplete";
		
		/**
		 * <span lang="ja">commandInterrupt イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_INTERRUPT constant defines the value of the type property of an commandInterrupt event object.</span>
		 */
		public static const COMMAND_INTERRUPT:String = "commandInterrupt";
		
		/**
		 * <span lang="ja">commandError イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_ERROR constant defines the value of the type property of an commandError event object.</span>
		 */
		public static const COMMAND_ERROR:String = "commandError";
		
		/**
		 * <span lang="ja">commandAdded イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_ADDED constant defines the value of the type property of an commandAdded event object.</span>
		 */
		public static const COMMAND_ADDED:String = "commandAdded";
		
		/**
		 * <span lang="ja">commandRemoved イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CommandEvent.COMMAND_REMOVED constant defines the value of the type property of an commandRemoved event object.</span>
		 */
		public static const COMMAND_REMOVED:String = "commandRemoved";
		
		
		
		
		
		/**
		 * <span lang="ja">コマンドが強制中断処理されたかどうかを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get enforcedInterrupted():Boolean { return _enforcedInterrupted; }
		private var _enforcedInterrupted:Boolean = false;
		
		/**
		 * <span lang="ja">コマンドオブジェクトからスローされた例外を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get errorObject():Error { return _errorObject; }
		private var _errorObject:Error;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CommandEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CommandEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">CommandEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as CommandEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">CommandEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CommandEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">CommandEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CommandEvent object can be canceled. The default values is false.</span>
		 * @param enforcedInterrupted
		 * <span lang="ja">コマンドが強制中断処理されたかどうかです。</span>
		 * <span lang="en"></span>
		 * @param errorObject
		 * <span lang="ja">コマンドオブジェクトからスローされた例外です。</span>
		 * <span lang="en"></span>
		 */
		public function CommandEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, enforcedInterrupted:Boolean = false, errorObject:Error = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_enforcedInterrupted = enforcedInterrupted;
			_errorObject = errorObject;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">CommandEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an CommandEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい CommandEvent インスタンスです。</span>
		 * <span lang="en">A new CommandEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new CommandEvent( type, bubbles, cancelable, _enforcedInterrupted, _errorObject );
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
			return formatToString( "CommandEvent", "type", "bubbles", "cancelable", "errorObject" );
		}
	}
}
