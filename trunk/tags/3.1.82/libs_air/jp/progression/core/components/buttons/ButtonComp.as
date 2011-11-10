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
package jp.progression.core.components.buttons {
	import flash.display.DisplayObject;
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
	
	/**
	 * @private
	 */
	public class ButtonComp extends CoreComp {
		
		/**
		 * <span lang="ja">コンポーネントとして適用する ButtonBase インスタンスを取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get component():ButtonBase { return _component; }
		private var _component:ButtonBase;
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_MOUSE_UP イベント、または CastMouseEvent.CAST_ROLL_OUT イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="upStateFrame", type="Default", defaultValue="up", verbose="1" )]
		public function get upStateFrame():* { return _component.upStateFrame; }
		public function set upStateFrame( value:* ):void { _component.upStateFrame = value; }
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_ROLL_OVER イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="overStateFrame", type="Default", defaultValue="over", verbose="1" )]
		public function get overStateFrame():* { return _component.overStateFrame; }
		public function set overStateFrame( value:* ):void { _component.overStateFrame = value; }
		
		/**
		 * <span lang="ja">CastMouseEvent.CAST_MOUSE_DOWN イベントが送出された場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="downStateFrame", type="Default", defaultValue="down", verbose="1" )]
		public function get downStateFrame():* { return _component.downStateFrame; }
		public function set downStateFrame( value:* ):void { _component.downStateFrame = value; }
		
		/**
		 * <span lang="ja">ボタンに設定されている移動先が、関連付けられている Progression インスタンスのカレントシーンと同様であった場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="currentStateFrame", type="Default", defaultValue="current", verbose="1" )]
		public function get currentStateFrame():* { return _component.currentStateFrame; }
		public function set currentStateFrame( value:* ):void { _component.currentStateFrame = value; }
		
		/**
		 * <span lang="ja">ボタンが無効化されている場合の表示アニメーションを示すフレームラベルまたはフレーム番号を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="disableStateFrame", type="Default", defaultValue="disable", verbose="1" )]
		public function get disableStateFrame():* { return _component.disableStateFrame; }
		public function set disableStateFrame( value:* ):void { _component.disableStateFrame = value; }
		
		/**
		 * <span lang="ja">ボタンの機能をキーボードから使用するためのアクセスキーを取得または設定します。
		 * 設定できるキーはアルファベットの A ～ Z までの値です。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="accessKey", type="String", defaultValue="" )]
		public function get accessKey():String { return _component.accessKey; }
		public function set accessKey( value:String ):void { _component.accessKey = value; }
		
		/**
		 * <span lang="ja">ボタンのコンテクストメニューを使用するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="useContextMenu", type="Boolean", defaultValue="true" )]
		public function get useContextMenu():Boolean { return _useContextMenu; }
		public function set useContextMenu( value:Boolean ):void { _useContextMenu = value; }
		private var _useContextMenu:Boolean = true;
		
		/**
		 * <span lang="ja">ツールチップに表示するテキストを取得または設定します。
		 * この値が設定されていない場合にはツールチップは表示されません。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipText", type="String", defaultValue="" )]
		public function get toolTipText():String { return _component.toolTip.text; }
		public function set toolTipText( value:String ):void { _component.toolTip.text = value; }
		
		/**
		 * <span lang="ja">表示するテキストの色を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipTextColor", type="Color", defaultValue="#000000", verbose="1" )]
		public function get toolTipTextColor():uint { return _component.toolTip.textColor; }
		public function set toolTipTextColor( value:uint ):void { _component.toolTip.textColor = value; }
		
		/**
		 * <span lang="ja">表示するテキストのフォントを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipTextFont", type="Font Name", defaultValue="_ゴシック", verbose="1" )]
		public function get toolTipTextFont():String { return _component.toolTip.textFont; }
		public function set toolTipTextFont( value:String ):void { _component.toolTip.textFont = value; }
		
		/**
		 * <span lang="ja">ツールチップの背景色を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipBackgroundColor", type="Color", defaultValue="#FFFFEE", verbose="1" )]
		public function get toolTipBackgroundColor():uint { return _component.toolTip.backgroundColor; }
		public function set toolTipBackgroundColor( value:uint ):void { _component.toolTip.backgroundColor = value; }
		
		/**
		 * <span lang="ja">ツールチップのボーダー色を取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipBorderColor", type="Color", defaultValue="#000000", verbose="1" )]
		public function get toolTipBorderColor():uint { return _component.toolTip.borderColor; }
		public function set toolTipBorderColor( value:uint ):void { _component.toolTip.borderColor = value; }
		
		/**
		 * <span lang="ja">ツールチップを表示するまでの遅延時間をミリ秒で取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipDelay", type="Number", defaultValue="750", verbose="1" )]
		public function get toolTipDelay():int { return _component.toolTip.delay; }
		public function set toolTipDelay( value:int ):void { _component.toolTip.delay = value; }
		
		/**
		 * <span lang="ja">表示されたツールチップが対象にロールオーバーしている際に、マウスカーソルに追従するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		[Inspectable( name="toolTipFollowMouse", type="Boolean", defaultValue="true", verbose="1" )]
		public function get toolTipFollowMouse():Boolean { return _component.toolTip.followMouse; }
		public function set toolTipFollowMouse( value:Boolean ):void { _component.toolTip.followMouse = value; }
		
		/**
		 * CastButtonContextMenu インスタンスを取得します。
		 */
		private var _uiContextMenu:CastButtonContextMenu;
		
		
		
		
		
		/**
		 * @private
		 */
		public function ButtonComp( component:ButtonBase ) {
			_uiContextMenu;
			
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
		
		
		
		
		
		/**
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
			Object( this )._initContextMenu();
			
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
		
		/**
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
			Object( this )._disposeContextMenu();
			
			// イベントリスナーを解除する
			_component.completelyRemoveEventListener( CastEvent.BUTTON_ENABLED_CHANGE, _buttonEnabledChange );
			target.removeEventListener( MouseEvent.MOUSE_DOWN, _component.dispatchEvent );
			target.removeEventListener( MouseEvent.MOUSE_UP, _component.dispatchEvent );
			target.removeEventListener( MouseEvent.ROLL_OVER, _component.dispatchEvent );
			target.removeEventListener( MouseEvent.ROLL_OUT, _component.dispatchEvent );
		}
		
		/**
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
		
		
		
		
		
		/**
		 * 
		 */
		include "../../includes/ButtonComp_contextMenu.inc"
	}
}
