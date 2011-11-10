/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.api.tweener {
	import flash.events.Event;
	
	/**
	 * <span lang="ja">TweenerHelper オブジェクトを実行した場合に TweenerEvent オブジェクトが送出されます。</span>
	 * <span lang="en">When the TweenerHelper object is executed, the TweenerEvent object is sent.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class TweenerEvent extends Event {
		
		/**
		 * <span lang="ja">complete イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TweenerEvent.COMPLETE constant defines the value of the type property of an complete event object.</span>
		 */
		public static const COMPLETE:String = "complete";
		
		/**
		 * <span lang="ja">error イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TweenerEvent.ERROR constant defines the value of the type property of an error event object.</span>
		 */
		public static const ERROR:String = "error";
		
		/**
		 * <span lang="ja">overwrite イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TweenerEvent.OVERWRITE constant defines the value of the type property of an overwrite event object.</span>
		 */
		public static const OVERWRITE:String = "overwrite";
		
		/**
		 * <span lang="ja">start イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TweenerEvent.START constant defines the value of the type property of an start event object.</span>
		 */
		public static const START:String = "start";
		
		/**
		 * <span lang="ja">update イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The TweenerEvent.UPDATE constant defines the value of the type property of an update event object.</span>
		 */
		public static const UPDATE:String = "update";
		
		
		
		
		
		/**
		 * <span lang="ja">Tweenwe オブジェクトからスローされた例外を取得します。</span>
		 * <span lang="en">Acquire the exception thrown by Tweenwe object.</span>
		 */
		public function get metaError():Error { return _metaError; }
		private var _metaError:Error;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい TweenerEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new TweenerEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">TweenerEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as TweenerEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">TweenerEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the TweenerEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">TweenerEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the TweenerEvent object can be canceled. The default values is false.</span>
		 * @param metaError
		 * <span lang="ja">Tweenwe オブジェクトからスローされた例外です。</span>
		 * <span lang="en">The exception thrown by Tweenwe object.</span>
		 */
		public function TweenerEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, metaError:Error = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_metaError = metaError;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">TweenerEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an TweenerEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい TweenerEvent インスタンスです。</span>
		 * <span lang="en">A new TweenerEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new TweenerEvent( type, bubbles, cancelable, _metaError );
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
			return formatToString( "TweenerEvent", "type", "bubbles", "cancelable", "metaError" );
		}
	}
}
