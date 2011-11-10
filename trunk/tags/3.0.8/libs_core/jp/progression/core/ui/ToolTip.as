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
package jp.progression.core.ui {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.MathUtil;
	import jp.nium.utils.StageUtil;
	import jp.progression.casts.CastButton;
	import jp.progression.casts.ICastObject;
	import jp.progression.core.namespaces.progression_internal;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>ToolTip クラスは、基本的なツールチップを提供する表示オブジェクトクラスです。
	 * ToolTip クラスを直接インスタンス化することはできません。
	 * new ToolTip() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ToolTip {
		
		/*======================================================================*//**
		 * ツールチップのテキストを判別する正規表現を取得します。
		 */
		private static const _TEXT_REGEXP:RegExp = new RegExp( "^[ 　]*$" );
		
		
		
		
		
		/*======================================================================*//**
		 * パッケージ内からの呼び出しかどうかを取得します。
		 */
		private static var _internallyCalled:Boolean = false;
		
		/*======================================================================*//**
		 * 現在表示しているツールチップを取得します。
		 */
		private static var _currentTextField:TextField;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ツールチップが使用可能かどうかを取得します。
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get enabled():Boolean { return _enabled; }
		private var _enabled:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ツールチップに表示するテキストを取得または設定します。
		 * この値が設定されていない場合には、ツールチップは表示されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get text():String { return _textField.text; }
		public function set text( value:String ):void {
			// 空白、またはスペースのみだった場合
			if ( _TEXT_REGEXP.test( value ) ) {
				// 無効化する
				_enabled = false;
				_text = "";
				
				// イベントリスナーを解除する
				_target.completelyRemoveEventListener( MouseEvent.ROLL_OVER, _rollOver );
				_target.completelyRemoveEventListener( MouseEvent.ROLL_OUT, _mouseDownAndRollOut );
				return;
			}
			
			// 有効化する
			_enabled = true;
			_text = value;
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( MouseEvent.ROLL_OVER, _rollOver, false, int.MAX_VALUE, true );
		}
		private var _text:String;
		
		/*======================================================================*//**
		 * <p>表示するテキストの色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get textColor():uint { return _textColor; }
		public function set textColor( value:uint ):void { _textField.textColor = MathUtil.range( value, 0x000000, 0xFFFFFF ); }
		private var _textColor:uint = 0x000000;
		
		/*======================================================================*//**
		 * <p>表示するテキストのフォントを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get textFont():String { return _textField.getTextFormat().font; }
		public function set textFont( value:String ):void {
			var fmt:TextFormat = _textField.getTextFormat();
			fmt.font = value;
			_textField.defaultTextFormat = fmt;
			_textField.setTextFormat( fmt );
		}
		
		/*======================================================================*//**
		 * <p>新しく挿入するテキスト (replaceSelectedText() メソッドで挿入したテキストまたはユーザーが入力したテキストなど) に適用するフォーマットを指定します。</p>
		 * <p>Specifies the format applied to newly inserted text, such as text inserted with the replaceSelectedText() method or text entered by a user.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get defaultTextFormat():TextFormat { return _textField.defaultTextFormat; }
		public function set defaultTextFormat( value:TextFormat ):void { _textField.defaultTextFormat = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップの背景色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get backgroundColor():uint { return _textField.backgroundColor; }
		public function set backgroundColor( value:uint ):void { _textField.backgroundColor = MathUtil.range( value, 0x000000, 0xFFFFFF ); }
		
		/*======================================================================*//**
		 * <p>ツールチップのボーダー色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get borderColor():uint { return _textField.borderColor; }
		public function set borderColor( value:uint ):void { _textField.borderColor = MathUtil.range( value, 0x000000, 0xFFFFFF ); }
		
		/*======================================================================*//**
		 * <p>ツールチップに現在関連付けられている各フィルタオブジェクトが格納されているインデックス付きの配列です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get filters():Array { return _textField.filters; }
		public function set filters( value:Array ):void { _textField.filters = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップを表示するまでの遅延時間をミリ秒で取得または設定します。</p>
		 * <p>An indexed array that contains each filter object currently associated with the ToolTip object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get delay():int { return _timer.delay; }
		public function set delay( value:int ):void { _timer.delay = value; }
		
		/*======================================================================*//**
		 * <p>表示されたツールチップが対象にロールオーバーしている際に、マウスカーソルに追従するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get followMouse():Boolean { return _followMouse; }
		public function set followMouse( value:Boolean ):void { _followMouse = value; }
		private var _followMouse:Boolean = true;
		
		/*======================================================================*//**
		 * <p>followMouse プロパティが有効化された際の摩擦係数を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get friction():Number { return _friction; }
		public function set friction( value:Number ):void { _friction = MathUtil.range( value, 0, 1 ); }
		private var _friction:Number = 25 / 100;
		
		/*======================================================================*//**
		 * 
		 */
		private var _padding:Number = 10;
		
		/*======================================================================*//**
		 * ツールチップを表示する X 座標を、マウスカーソルの位置からの相対的な数値で取得または設定します。
		 */
		private var _marginX:Number = 5;
		
		/*======================================================================*//**
		 * ツールチップを表示する Y 座標を、マウスカーソルの位置からの相対的な数値で取得または設定します。
		 */
		private var _marginY:Number = 22;
		
		/*======================================================================*//**
		 * TextField インスタンスを取得します。 
		 */
		private var _textField:TextField;
		
		/*======================================================================*//**
		 * Timer インスタンスを取得します。 
		 */
		private var _timer:Timer;
		
		/*======================================================================*//**
		 * ICastObject インスタンスを取得します。 
		 */
		private var _target:ICastObject;
		
		/*======================================================================*//**
		 * Stage インスタンスを取得します。 
		 */
		private var _stage:Stage;
		
		/*======================================================================*//**
		 * 
		 */
		private var _originalWidth:Number;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function ToolTip( target:ICastObject ) {
			// パッケージ外から呼び出されたらエラーを送出する
			if ( !_internallyCalled ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ToolTip" ) ); };
			
			// 引数を設定する
			_target = target;
			
			// 初期化する
			_internallyCalled = false;
			
			// Timer を作成する
			_timer = new Timer( 750, 1 );
			
			// TextField を作成する
			_textField = new TextField()
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.background = true;
			_textField.backgroundColor = 0xFFFFEE;
			_textField.border = true;
			_textField.borderColor = 0x000000;
			_textField.defaultTextFormat = new TextFormat( "_sans", null, null, null, null, null, null, null, null, 2, 0 );
			_textField.mouseEnabled = false;
			_textField.multiline = true;
			_textField.selectable = false;
			_textField.textColor = 0x000000;
			_textField.filters = [ new DropShadowFilter( 1, 45, 0x000000, 0.5, 4, 4, 1 ) ];
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		progression_internal static function __createInstance( target:ICastObject ):ToolTip {
			_internallyCalled = true;
			return new ToolTip( target );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>format パラメータで指定したテキストフォーマットを、ツールチップ内の指定されたテキストに適用します。</p>
		 * <p>Applies the text formatting that the format parameter specifies to the specified text in a tool tip.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param format
		 * 	<p>文字と段落のフォーマット情報を含む TextFormat オブジェクトです。</p>
		 * 	<p>A TextFormat object that contains character and paragraph formatting information.</p>
		 * @param beginIndex
		 * 	<p>必要なテキスト範囲の最初の文字を指定する 0 から始まるインデックス位置です。</p>
		 * 	<p>Optional; an integer that specifies the zero-based index position specifying the first character of the desired range of text.</p>
		 * @param endIndex
		 * 	<p>必要なテキスト範囲の最初の文字を指定する 0 から始まるインデックス位置です。</p>
		 * 	<p>Optional; an integer that specifies the first character after the desired text span. As designed, if you specify beginIndex and endIndex values, the text from beginIndex to endIndex-1 is updated.</p>
		 */
		public function setTextFormat( format:TextFormat, beginIndex:int = -1, endIndex:int = -1 ):void {
			_textField.setTextFormat( format, beginIndex, endIndex );
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
		public function toString():String {
			return "[object ToolTip]";
		}
		
		
		
		
		
		/*======================================================================*//**
		 * ユーザーが InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _rollOver( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.completelyRemoveEventListener( MouseEvent.ROLL_OVER, _rollOver );
			
			// stage の参照を保存する
			_stage = DisplayObject( _target ).stage;
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( MouseEvent.MOUSE_DOWN, _mouseDownAndRollOut, false, int.MAX_VALUE, true );
			_target.addExclusivelyEventListener( MouseEvent.ROLL_OUT, _mouseDownAndRollOut, false, int.MAX_VALUE, true );
			
			// Timer を開始する
			_timer.reset();
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _timerComplete, false, int.MAX_VALUE, true );
			_timer.start();
		}
		
		/*======================================================================*//**
		 * ユーザーが InteractiveObject インスタンスからポインティングデバイスを離したときに送出されます。
		 */
		private function _mouseDownAndRollOut( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.completelyRemoveEventListener( Event.ENTER_FRAME, _enterFrame );
			_target.completelyRemoveEventListener( MouseEvent.ROLL_OUT, _mouseDownAndRollOut );
			_stage.removeEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			
			// Timer を停止する
			_timer.stop();
			
			// ツールチップが存在すれば
			if ( _currentTextField ) {
				_currentTextField.parent.removeChild( _currentTextField );
				_currentTextField = null;
			}
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( MouseEvent.ROLL_OVER, _rollOver, false, int.MAX_VALUE, true );
		}
		
		/*======================================================================*//**
		 * Timer.repeatCount で設定された数の要求が完了するたびに送出されます。
		 */
		private function _timerComplete( e:TimerEvent ):void {
			// 表示中のツールチップがあれば削除する
			if ( _currentTextField ) {
				_stage.removeChild( _currentTextField );
			}
			
			// ツールチップを表示する
			_currentTextField = TextField( _stage.addChild( _textField ) );
			_currentTextField.text = _text;
			
			// 対象が CastButton であれば
			if ( _target is CastButton ) {
				_currentTextField.appendText( "\n" + CastButton( _target ).navigateURL );
			}
			
			// 現在の横幅を保存する
			_currentTextField.wordWrap = false;
			_originalWidth = _currentTextField.width + 1;
			_currentTextField.wordWrap = true;
			
			// サイズを調整する
			_currentTextField.width = Math.ceil( Math.min( _originalWidth, _stage.stageWidth - _padding * 2 ) );
			
			// 初期座標を設定する
			_currentTextField.x = Math.min( _stage.stageWidth - StageUtil.getMarginLeft( _stage ) - _currentTextField.width - _padding, _stage.mouseX + _marginX );
			_currentTextField.y = Math.min( _stage.stageHeight - StageUtil.getMarginTop( _stage ) - _currentTextField.height - _padding, _stage.mouseY + _marginY );
			
			// 追従が有効であれば
			if ( _followMouse ) {
				_target.addExclusivelyEventListener( Event.ENTER_FRAME, _enterFrame, false, int.MAX_VALUE, true );
				_target.addEventListener( MouseEvent.MOUSE_DOWN, _mouseDown, false, int.MAX_VALUE, true );
				_stage.addEventListener( MouseEvent.MOUSE_DOWN, _mouseDown, false, int.MAX_VALUE, true );
			}
			else {
				_target.addExclusivelyEventListener( MouseEvent.MOUSE_MOVE, _mouseMove, false, int.MAX_VALUE, true );
			}
		}
		
		/*======================================================================*//**
		 * 再生ヘッドが新しいフレームに入るときに送出されます。
		 */
		private function _enterFrame( e:Event ):void {
			// 存在しなければ終了する
			if ( !_currentTextField ) { return; }
			
			// 移動先の位置を取得します。
			var x:Number = _stage.mouseX + _marginX;
			var y:Number = _stage.mouseY + _marginY;
			
			// ステージからはみ出ている場合に補正する
			x = Math.min( _stage.stageWidth - StageUtil.getMarginLeft( _stage ) - _currentTextField.width - _padding, x );
			y = Math.min( _stage.stageHeight - StageUtil.getMarginTop( _stage ) - _currentTextField.height - _padding * 3, y );
			
			// マウスを追従する
			_currentTextField.x += ( x - _currentTextField.x ) * _friction;
			_currentTextField.y += ( y - _currentTextField.y ) * _friction;
		}
		
		/*======================================================================*//**
		 * Flash Player ウィンドウの InteractiveObject インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 */
		private function _mouseDown( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.completelyRemoveEventListener( Event.ENTER_FRAME, _enterFrame );
			_target.completelyRemoveEventListener( MouseEvent.ROLL_OUT, _mouseDownAndRollOut );
			_stage.removeEventListener( MouseEvent.MOUSE_DOWN, _mouseDown );
			
			// ツールチップを消去する
			if ( _currentTextField ) {
				_currentTextField.parent.removeChild( _currentTextField );
				_currentTextField = null;
			}
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( MouseEvent.ROLL_OVER, _rollOver, false, int.MAX_VALUE, true );
		}
		
		/*======================================================================*//**
		 * ユーザーが Flash Player ウィンドウの InteractiveObject インスタンスにポインティングデバイスを合わせたときに送出されます。
		 */
		private function _mouseMove( e:MouseEvent ):void {
			// イベントリスナーを解除する
			_target.completelyRemoveEventListener( MouseEvent.MOUSE_MOVE, _mouseMove );
			_target.completelyRemoveEventListener( MouseEvent.ROLL_OUT, _mouseDownAndRollOut );
			
			// ツールチップを消去する
			if ( _currentTextField ) {
				_currentTextField.parent.removeChild( _currentTextField );
				_currentTextField = null;
			}
			
			// イベントリスナーを登録する
			_target.addExclusivelyEventListener( MouseEvent.ROLL_OVER, _rollOver, false, int.MAX_VALUE, true );
		}
	}
}









