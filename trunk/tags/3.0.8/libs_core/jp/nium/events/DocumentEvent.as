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
package jp.nium.events {
	import flash.display.Stage;
	import flash.events.Event;
	import jp.nium.display.ExDocument;
	
	/*======================================================================*//**
	 * <p>SWF ファイルのサイズが変更されたときに Stage オブジェクトから送出されるイベントを受け取った ExDocument オブジェクトによって DocumentEvent オブジェクトが送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class DocumentEvent extends Event {
		
		/*======================================================================*//**
		 * <p>init イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The DocumentEvent.INIT constant defines the value of the type property of an init event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const INIT:String = "init";
		
		/*======================================================================*//**
		 * <p>resizeStart イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The DocumentEvent.RESIZE_START constant defines the value of the type property of an resizeStart event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RESIZE_START:String = "resizeStart";
		
		/*======================================================================*//**
		 * <p>resizeProgress イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The DocumentEvent.RESIZE_PROGRESS constant defines the value of the type property of an resizeProgress event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RESIZE_PROGRESS:String = "resizeProgress";
		
		/*======================================================================*//**
		 * <p>resizeComplete イベントオブジェクトの type プロパティ値を定義します。</p>
		 * <p>The DocumentEvent.RESIZE_COMPLETE constant defines the value of the type property of an resizeComplete event object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public static const RESIZE_COMPLETE:String = "resizeComplete";
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ロードされた SWF ファイル内の表示オブジェクトの場合、root プロパティはその SWF ファイルが表す表示リストのツリー構造部分の一番上にある表示オブジェクトとなります。</p>
		 * <p>For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get root():ExDocument { return _root; }
		private var _root:ExDocument;
		
		/*======================================================================*//**
		 * <p>表示オブジェクトのステージです。</p>
		 * <p>The Stage of the display object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		/*======================================================================*//**
		 * <p>ステージの現在の幅をピクセル単位で指定します。</p>
		 * <p>Specifies the current width, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get stageWidth():int { return _stageWidth; }
		private var _stageWidth:int = 0;
		
		/*======================================================================*//**
		 * <p>ステージの現在の高さをピクセル単位で指定します。</p>
		 * <p>The current height, in pixels, of the Stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get stageHeight():int { return _stageHeight; }
		private var _stageHeight:int = 0;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい DocumentEvent インスタンスを作成します。</p>
		 * <p>Creates a new DocumentEvent object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>DocumentEvent.type としてアクセス可能なイベントタイプです。</p>
		 * 	<p>The type of the event, accessible as DocumentEvent.type.</p>
		 * @param bubbles
		 * 	<p>DocumentEvent インスタンスがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the DocumentEvent object participates in the bubbling stage of the event flow. The default value is false.</p>
		 * @param cancelable
		 * 	<p>DocumentEvent インスタンスがキャンセル可能かどうかを判断します。デフォルト値は false です。</p>
		 * 	<p>Determines whether the DocumentEvent object can be canceled. The default values is false.</p>
		 * @param root
		 * 	<p>イベントが発生した Document インスタンスです。</p>
		 * 	<p></p>
		 * @param stage
		 * 	<p>関連付けられる stage インスタンスです。</p>
		 * 	<p></p>
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
		
		
		
		
		
		/*======================================================================*//**
		 * <p>DocumentEvent インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DocumentEvent subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい DocumentEvent インスタンスです。</p>
		 * 	<p>A new DocumentEvent object that is identical to the original.</p>
		 */
		public override function clone():Event {
			return new DocumentEvent( type, bubbles, cancelable, _root, _stage );
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
			return formatToString( "DocumentEvent", "type", "bubbles", "cancelable", "root", "stage" );
		}
	}
}









