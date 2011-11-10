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
package jp.progression.events {
	import flash.events.Event;
	
	/**
	 * <span lang="ja">ICastObject インターフェイスを実装したオブジェクトが AddChild コマンドや RemoveChild コマンドなどによって表示リストに追加された場合などに CastEvent オブジェクトが送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CastEvent extends Event {
		
		/**
		 * <span lang="ja">castAdded イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.CAST_ADDED constant defines the value of the type property of an castAdded event object.</span>
		 */
		public static const CAST_ADDED:String = "castAdded";
		
		/**
		 * <span lang="ja">castRemoved イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.CAST_REMOVED constant defines the value of the type property of an castRemoved event object.</span>
		 */
		public static const CAST_REMOVED:String = "castRemoved";
		
		/**
		 * <span lang="ja">castLoadStart イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.CAST_LOAD_START constant defines the value of the type property of an castLoadStart event object.</span>
		 */
		public static const CAST_LOAD_START:String = "castLoadStart";
		
		/**
		 * <span lang="ja">castLoadComplete イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.CAST_LOAD_COMPLETE constant defines the value of the type property of an castLoadComplete event object.</span>
		 */
		public static const CAST_LOAD_COMPLETE:String = "castLoadComplete";
		
		/**
		 * <span lang="ja">update イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.UPDATE constant defines the value of the type property of an update event object.</span>
		 */
		public static const UPDATE:String = "update";
		
		/**
		 * <span lang="ja">statusChange イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.STATUS_CHANGE constant defines the value of the type property of an statusChange event object.</span>
		 */
		public static const STATUS_CHANGE:String = "statusChange";
		
		/**
		 * <span lang="ja">buttonEnabledChange イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The CastEvent.BUTTON_ENABLED_CHANGE constant defines the value of the type property of an buttonEnabledChange event object.</span>
		 */
		public static const BUTTON_ENABLED_CHANGE:String = "buttonEnabledChange";
		
		
		
		
		
		/**
		 * <span lang="ja">新しい CastEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new CastEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">CastEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as CastEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">CastEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CastEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">CastEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the CastEvent object can be canceled. The default values is false.</span>
		 */
		public function CastEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">CastEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an CastEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい CastEvent インスタンスです。</span>
		 * <span lang="en">A new CastEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new CastEvent( type, bubbles, cancelable );
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
			return formatToString( "CastEvent", "type", "bubbles", "cancelable" );
		}
	}
}
