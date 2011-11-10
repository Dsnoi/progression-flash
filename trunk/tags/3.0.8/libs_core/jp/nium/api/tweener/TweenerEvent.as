/*======================================================================*//**
 * 
 * jp.nium Classes
 * 
 * @author Copyright (c) 2007-2008 taka:nium
 * @version 3.0.8
 * @see http://classes.nium.jp/
 * 
 * Developed by taka:nium
 * @see http://nium.jp/
 * 
 * Progression is (c) 2007-2008 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
package jp.nium.api.tweener {
	import flash.events.Event;
	
	/*======================================================================*//**
	 * <p>TweenerHelper オブジェクトを実行した場合に TweenerEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class TweenerEvent extends Event {
		
		/*======================================================================*//**
		 * <p>complete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TweenerEvent.COMPLETE constant defines the value of the type property of an complete event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const COMPLETE:String = "complete";
		
		/*======================================================================*//**
		 * <p>error イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TweenerEvent.ERROR constant defines the value of the type property of an error event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const ERROR:String = "error";
		
		/*======================================================================*//**
		 * <p>overwrite イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TweenerEvent.OVERWRITE constant defines the value of the type property of an overwrite event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const OVERWRITE:String = "overwrite";
		
		/*======================================================================*//**
		 * <p>start イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TweenerEvent.START constant defines the value of the type property of an start event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const START:String = "start";
		
		/*======================================================================*//**
		 * <p>update イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The TweenerEvent.UPDATE constant defines the value of the type property of an update event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const UPDATE:String = "update";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>Tweenwe オブジェクトからスローされた例外を取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get metaError():Error { return _metaError; }
		private var _metaError:Error;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい TweenerEvent インスタンスを作成します。</p>
		 * <p>Creates a new TweenerEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>TweenerEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as TweenerEvent.type.</p>
		 * @param bubbles
		 * 	<p>TweenerEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the TweenerEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>TweenerEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the TweenerEvent object can be canceled. The default values is false.</p>
		 * @param metaError
		 * 	<p>Tweenwe オブジェクトからスローされた例外です。</p>
		 * 	<p></p>
		 */
		public function TweenerEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, metaError:Error = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_metaError = metaError;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>TweenerEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an TweenerEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい TweenerEvent インスタンスです。</p>
		 * 	<p>A new TweenerEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new TweenerEvent( type, bubbles, cancelable, _metaError );
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
			return formatToString( "TweenerEvent", "type", "bubbles", "cancelable", "metaError" );
		}
	}
}









