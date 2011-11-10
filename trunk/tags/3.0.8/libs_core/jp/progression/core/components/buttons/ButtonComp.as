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
package jp.progression.core.components.buttons {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.casts.buttons.ButtonBase;
	import jp.progression.core.components.CoreComp;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.CastButtonContextMenu;
	import jp.progression.events.CastEvent;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * @private
	 */
	public class ButtonComp extends CoreComp {
		
		/*======================================================================*//**
		 * <p>コンポーネントとして適用する ButtonBase インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get component():ButtonBase { return _component; }
		private var _component:ButtonBase;
		
		/*======================================================================*//**
		 * <p>CastMouseEvent.CAST_MOUSE_UP イベント、または CastMouseEvent.CAST_ROLL_OUT イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="upStateFrame", type="Default", defaultValue="up", verbose="1" )]
		public function get upStateFrame():* { return _component.upStateFrame; }
		public function set upStateFrame( value:* ):void { _component.upStateFrame = value; }
		
		/*======================================================================*//**
		 * <p>CastMouseEvent.CAST_ROLL_OVER イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="overStateFrame", type="Default", defaultValue="over", verbose="1" )]
		public function get overStateFrame():* { return _component.overStateFrame; }
		public function set overStateFrame( value:* ):void { _component.overStateFrame = value; }
		
		/*======================================================================*//**
		 * <p>CastMouseEvent.CAST_MOUSE_DOWN イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="downStateFrame", type="Default", defaultValue="down", verbose="1" )]
		public function get downStateFrame():* { return _component.downStateFrame; }
		public function set downStateFrame( value:* ):void { _component.downStateFrame = value; }
		
		/*======================================================================*//**
		 * <p>ボタンに設定されている移動先が、関連付けられている Progression インスタンスのカレントシーンと同様であった場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="currentStateFrame", type="Default", defaultValue="current", verbose="1" )]
		public function get currentStateFrame():* { return _component.currentStateFrame; }
		public function set currentStateFrame( value:* ):void { _component.currentStateFrame = value; }
		
		/*======================================================================*//**
		 * <p>ボタンが無効化されている場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="disableStateFrame", type="Default", defaultValue="disable", verbose="1" )]
		public function get disableStateFrame():* { return _component.disableStateFrame; }
		public function set disableStateFrame( value:* ):void { _component.disableStateFrame = value; }
		
		/*======================================================================*//**
		 * <p>ボタンの機能をキーボードから使用するためのアクセスキーを取得または設定します。
		 * 設定できるキーはアルファベットの A ～ Z までの値です。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="accessKey", type="String", defaultValue="" )]
		public function get accessKey():String { return _component.accessKey; }
		public function set accessKey( value:String ):void { _component.accessKey = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップに表示するテキストを取得または設定します。
		 * この値が設定されていない場合にはツールチップは表示されません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipText", type="String", defaultValue="" )]
		public function get toolTipText():String { return _component.toolTip.text; }
		public function set toolTipText( value:String ):void { _component.toolTip.text = value; }
		
		/*======================================================================*//**
		 * <p>表示するテキストの色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipTextColor", type="Color", defaultValue="#000000", verbose="1" )]
		public function get toolTipTextColor():uint { return _component.toolTip.textColor; }
		public function set toolTipTextColor( value:uint ):void { _component.toolTip.textColor = value; }
		
		/*======================================================================*//**
		 * <p>表示するテキストのフォントを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipTextFont", type="Font Name", defaultValue="_ゴシック", verbose="1" )]
		public function get toolTipTextFont():String { return _component.toolTip.textFont; }
		public function set toolTipTextFont( value:String ):void { _component.toolTip.textFont = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップの背景色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipBackgroundColor", type="Color", defaultValue="#FFFFEE", verbose="1" )]
		public function get toolTipBackgroundColor():uint { return _component.toolTip.backgroundColor; }
		public function set toolTipBackgroundColor( value:uint ):void { _component.toolTip.backgroundColor = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップのボーダー色を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipBorderColor", type="Color", defaultValue="#000000", verbose="1" )]
		public function get toolTipBorderColor():uint { return _component.toolTip.borderColor; }
		public function set toolTipBorderColor( value:uint ):void { _component.toolTip.borderColor = value; }
		
		/*======================================================================*//**
		 * <p>ツールチップを表示するまでの遅延時間をミリ秒で取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipDelay", type="Number", defaultValue="750", verbose="1" )]
		public function get toolTipDelay():int { return _component.toolTip.delay; }
		public function set toolTipDelay( value:int ):void { _component.toolTip.delay = value; }
		
		/*======================================================================*//**
		 * <p>表示されたツールチップが対象にロールオーバーしている際に、マウスカーソルに追従するかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		[Inspectable( name="toolTipFollowMouse", type="Boolean", defaultValue="true", verbose="1" )]
		public function get toolTipFollowMouse():Boolean { return _component.toolTip.followMouse; }
		public function set toolTipFollowMouse( value:Boolean ):void { _component.toolTip.followMouse = value; }
		
		/*======================================================================*//**
		 * CastButtonContextMenu インスタンスを取得します。
		 */
		private var _uiContextMenu:CastButtonContextMenu;
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function ButtonComp( component:ButtonBase ) {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( CoreComp ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ButtonComp" ) ); }
			
			// 引数を設定する
			_component = component;
			
			// 再生を停止する
			_component.gotoAndStop( 1 );
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, int.MAX_VALUE, true );
			addExclusivelyEventListener( ComponentEvent.COMPONENT_REMOVED, _componentRemoved, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _componentAdded( e:ComponentEvent ):void {
			// _target に __progressionCurrentButton が登録されていれば
			if ( target.__progressionCurrentButton ) {
				Verbose.warning( target, VerboseMessageConstants.getMessage( "VERBOSE_0004", target.name, className ) );
				return;
			}
			
			// 親に __progressionCurrentButton が登録されていれば
			var parent:DisplayObject = target;
			while ( parent ) {
				if ( "__progressionCurrentButton" in parent && Object( parent ).__progressionCurrentButton ) {
					Verbose.warning( parent, VerboseMessageConstants.getMessage( "VERBOSE_0005", parent.name, className ) );
					return;
				}
				
				parent = parent.parent;
			}
			
			// target を設定する
			_component.progression_internal::__target = target;
			
			// __progressionCurrentButton を登録する
			target.__progressionCurrentButton = this;
			
			// 表示リストに追加する
			if ( !contains( _component ) ) {
				addChild( _component );
			}
			
			// コンテクストメニューを設定する
			target.contextMenu = new ContextMenu();
			target.contextMenu.hideBuiltInItems();
			
			// CastButtonContextMenu を作成する
			_uiContextMenu = CastButtonContextMenu.progression_internal::__createInstance( _component, target.contextMenu = new ContextMenu() );
			
			// イベントリスナーを登録する
			_component.addExclusivelyEventListener( CastEvent.BUTTON_ENABLED_CHANGE, _buttonEnabledChange, false, int.MAX_VALUE, true );
			
			// ボタン状態を再設定する
			_component.buttonEnabled = _component.buttonEnabled;
			
			// 初期表示を作成する
			switch ( true ) {
				case !_component.buttonEnabled	: { target.gotoAndStop( disableStateFrame ); break; }
				case _component.isCurrent		: { target.gotoAndStop( currentStateFrame ); break; }
				case _component.isRollOver		: { target.gotoAndStop( overStateFrame ); break; }
				case _component.isMouseDown		: { target.gotoAndStop( downStateFrame ); break; }
			}
		}
		
		/*======================================================================*//**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの削除により、表示リストから削除されようとしているときに送出されます。
		 */
		private function _componentRemoved( e:ComponentEvent ):void {
			// 表示リストから削除する
			if ( contains( _component ) ) {
				removeChild( _component );
			}
			
			// target を破棄する
			_component.progression_internal::__target = target;
			
			// __progressionCurrentButton を破棄する
			target.__progressionCurrentButton = null;
			
			// ボタン状態を解除する
			target.buttonMode = false;
			target.mouseChildren = true;
			target.useHandCursor = false;
			
			// コンテクストメニューを破棄する
			target.contextMenu = null;
			_uiContextMenu = null;
			
			// イベントリスナーを解除する
			_component.completelyRemoveEventListener( CastEvent.BUTTON_ENABLED_CHANGE, _buttonEnabledChange );
		}
		
		/*======================================================================*//**
		 * オブジェクトの buttonEnabled プロパティの値が変更されたときに送出されます。
		 */
		private function _buttonEnabledChange( e:CastEvent ):void {
			var buttonEnabled:Boolean = _component.buttonEnabled;
			
			target.buttonMode = buttonEnabled;
			target.mouseChildren = !buttonEnabled;
			target.useHandCursor = buttonEnabled;
			
			if ( buttonEnabled ) {
				target.addEventListener( MouseEvent.MOUSE_DOWN, _component.dispatchEvent, false, int.MAX_VALUE, true );
				target.addEventListener( MouseEvent.MOUSE_UP, _component.dispatchEvent, false, int.MAX_VALUE, true );
				target.addEventListener( MouseEvent.ROLL_OVER, _component.dispatchEvent, false, int.MAX_VALUE, true );
				target.addEventListener( MouseEvent.ROLL_OUT, _component.dispatchEvent, false, int.MAX_VALUE, true );
			}
			else {
				target.removeEventListener( MouseEvent.MOUSE_DOWN, _component.dispatchEvent );
				target.removeEventListener( MouseEvent.MOUSE_UP, _component.dispatchEvent );
				target.removeEventListener( MouseEvent.ROLL_OVER, _component.dispatchEvent );
				target.removeEventListener( MouseEvent.ROLL_OUT, _component.dispatchEvent );
			}
		}
	}
}









