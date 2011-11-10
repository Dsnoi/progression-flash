/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.events {
	import flash.display.Stage;
	import flash.events.Event;
	import jp.nium.display.ExDocument;
	
	/**
	 * <span lang="ja">SWF ファイルのサイズが変更されたときに Stage オブジェクトから送出されるイベントを受け取った ExDocument オブジェクトによって DocumentEvent オブジェクトが送出されます。</span>
	 * <span lang="en">DocumentEvent object will be sent from ExDocument object which received the event sent by Stage object when the size of the SWF file chages.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class DocumentEvent extends Event {
		
		/**
		 * <span lang="ja">init イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The DocumentEvent.INIT constant defines the value of the type property of an init event object.</span>
		 */
		public static const INIT:String = "init";
		
		/**
		 * <span lang="ja">resizeStart イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The DocumentEvent.RESIZE_START constant defines the value of the type property of an resizeStart event object.</span>
		 */
		public static const RESIZE_START:String = "resizeStart";
		
		/**
		 * <span lang="ja">resizeProgress イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The DocumentEvent.RESIZE_PROGRESS constant defines the value of the type property of an resizeProgress event object.</span>
		 */
		public static const RESIZE_PROGRESS:String = "resizeProgress";
		
		/**
		 * <span lang="ja">resizeComplete イベントオブジェクトの type プロパティ値を定義します。</span>
		 * <span lang="en">The DocumentEvent.RESIZE_COMPLETE constant defines the value of the type property of an resizeComplete event object.</span>
		 */
		public static const RESIZE_COMPLETE:String = "resizeComplete";
		
		
		
		
		
		/**
		 * <span lang="ja">ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</span>
		 * <span lang="en">For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</span>
		 */
		public function get root():ExDocument { return _root; }
		private var _root:ExDocument;
		
		/**
		 * <span lang="ja">表示オブジェクトのステージです。</span>
		 * <span lang="en">The Stage of the display object.</span>
		 */
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		/**
		 * <span lang="ja">ステージの現在の幅をピクセル単位で指定します。</span>
		 * <span lang="en">Specifies the current width, in pixels, of the Stage.</span>
		 */
		public function get stageWidth():int { return _stageWidth; }
		private var _stageWidth:int = 0;
		
		/**
		 * <span lang="ja">ステージの現在の高さをピクセル単位で指定します。</span>
		 * <span lang="en">The current height, in pixels, of the Stage.</span>
		 */
		public function get stageHeight():int { return _stageHeight; }
		private var _stageHeight:int = 0;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DocumentEvent インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DocumentEvent object.</span>
		 * 
		 * @param type
		 * <span lang="ja">DocumentEvent.type としてアクセス可能なイベントタイプです。</span>
		 * <span lang="en">The type of the event, accessible as DocumentEvent.type.</span>
		 * @param bubbles
		 * <span lang="ja">DocumentEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the DocumentEvent object participates in the bubbling stage of the event flow. The default value is false.</span>
		 * @param cancelable
		 * <span lang="ja">DocumentEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</span>
		 * <span lang="en">Determines whether the DocumentEvent object can be canceled. The default values is false.</span>
		 * @param root
		 * <span lang="ja">イベントが発生した Document インスタンスです。</span>
		 * <span lang="en">The Document instance which the event occur.</span>
		 * @param stage
		 * <span lang="ja">関連付けられる stage インスタンスです。</span>
		 * <span lang="en">The stage instance which will be related.</span>
		 */
		public function DocumentEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, root:ExDocument = null, stage:Stage = null ) {
			// スーパークラスを初期化する
			super( type, bubbles, cancelable );
			
			// 引数を設定する
			_root = root;
			_stage = stage;
			_stageWidth = _stage.stageWidth;
			_stageHeight = _stage.stageHeight;
		}
		
		
		
		
		
		/**
		 * <span lang="ja">DocumentEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DocumentEvent subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DocumentEvent インスタンスです。</span>
		 * <span lang="en">A new DocumentEvent object that is identical to the original.</span>
		 */
		public override function clone():Event {
			return new DocumentEvent( type, bubbles, cancelable, _root, _stage );
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
			return formatToString( "DocumentEvent", "type", "bubbles", "cancelable", "root", "stage" );
		}
	}
}
