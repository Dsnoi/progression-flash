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
package jp.progression.events {
	import flash.events.Event;
	
	/*======================================================================*//**
	 * <p>Command オブジェクトが処理を実行、完了、中断、等を行った場合に CommandEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class CommandEvent extends Event {
		
		/*======================================================================*//**
		 * <p>commandStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_START constant defines the value of the type property of an commandStart event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_START:String = "commandStart";
		
		/*======================================================================*//**
		 * <p>commandComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_COMPLETE constant defines the value of the type property of an commandComplete event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_COMPLETE:String = "commandComplete";
		
		/*======================================================================*//**
		 * <p>commandInterrupt イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_INTERRUPT constant defines the value of the type property of an commandInterrupt event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_INTERRUPT:String = "commandInterrupt";
		
		/*======================================================================*//**
		 * <p>commandError イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_ERROR constant defines the value of the type property of an commandError event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_ERROR:String = "commandError";
		
		/*======================================================================*//**
		 * <p>commandAdded イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_ADDED constant defines the value of the type property of an commandAdded event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_ADDED:String = "commandAdded";
		
		/*======================================================================*//**
		 * <p>commandRemoved イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The CommandEvent.COMMAND_REMOVED constant defines the value of the type property of an commandRemoved event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMMAND_REMOVED:String = "commandRemoved";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>コマンドが強制中断処理されたかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enforcedInterrupted():Boolean { return _enforcedInterrupted; }
		private var _enforcedInterrupted:Boolean = false;
		
		/*======================================================================*//**
		 * <p>コマンドオブジェクトからスローされた例外を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get errorObject():Error { return _errorObject; }
		private var _errorObject:Error;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい CommandEvent インスタンスを作成します。</p>
		 * <p>Creates a new CommandEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>CommandEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as CommandEvent.type.</p>
		 * @param bubbles
		 * 	<p>CommandEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CommandEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>CommandEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the CommandEvent object can be canceled. The default values is false.</p>
		 * @param enforcedInterrupted
		 * 	<p>コマンドが強制中断処理されたかどうかです。</p>
		 * 	<p></p>
		 * @param errorObject
		 * 	<p>コマンドオブジェクトからスローされた例外です。</p>
		 * 	<p></p>
		 */
		public function CommandEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, enforcedInterrupted:Boolean = false, errorObject:Error = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_enforcedInterrupted = enforcedInterrupted;
			_errorObject = errorObject;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>CommandEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an CommandEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい CommandEvent インスタンスです。</p>
		 * 	<p>A new CommandEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new CommandEvent( type, bubbles, cancelable, _enforcedInterrupted, _errorObject );
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
			return formatToString( "CommandEvent", "type", "bubbles", "cancelable", "errorObject" );
		}
	}
}









