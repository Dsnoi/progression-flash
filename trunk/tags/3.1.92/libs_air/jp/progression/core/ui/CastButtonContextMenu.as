/**
 * Progression
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://progression.jp/
 * 
 * Progression is (C) taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.core.ui {
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.ui.ICastContextMenu;
	
	use namespace progression_internal;
	
	/**
	 * <span lang="ja">CastButtonContextMenu クラスは、ContextMenu クラスの基本機能を拡張した jp.progression パッケージで使用される基本的なボタンメニュークラスです。
	 * CastButtonContextMenu クラスを直接インスタンス化することはできません。
	 * new CastButtonContextMenu() コンストラクタを呼び出すと、ArgumentError 例外がスローされます。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class CastButtonContextMenu implements ICastContextMenu {
		
		/**
		 * <span lang="ja">コンテクストメニューを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void { _enabled = value; }
		private static var _enabled:Boolean = true;
		
		
		
		
		
		/**
		 * <span lang="ja">コンテクストメニューを有効化するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void { _enabled = value; }
		private var _enabled:Boolean = true;
		
		/**
		 * <span lang="ja">ユーザー定義の ContextMenuItem を含む配列を取得します。</span>
		 * <span lang="en"></span>
		 */
		public function get customItems():Array { return _customItems; }
		private var _customItems:Array = [];
		
		/**
		 * <span lang="ja">[開く] メニューを表示するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get hideOpen():Boolean { return _hideOpen; }
		public function set hideOpen( value:Boolean ):void { _hideOpen = value; }
		private var _hideOpen:Boolean = false;
		
		/**
		 * <span lang="ja">[新規ウィンドウで開く] メニューを表示するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get hideOpenNewWindow():Boolean { return _hideOpenNewWindow; }
		public function set hideOpenNewWindow( value:Boolean ):void { _hideOpenNewWindow = value; }
		private var _hideOpenNewWindow:Boolean = false;
		
		/**
		 * <span lang="ja">[URL をコピーする] メニューを表示するかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get hideCopyURL():Boolean { return _hideCopyURL; }
		public function set hideCopyURL( value:Boolean ):void { _hideCopyURL = value; }
		private var _hideCopyURL:Boolean = false;
		
		
		
		
		
		/**
		 * <span lang="ja">[設定] を除き、指定された ContextMenu オブジェクト内のすべてのビルトインメニューアイテムを非表示にします。</span>
		 * <span lang="en"></span>
		 */
		public function hideBuiltInItems():void {
			Object( this )._hideBuiltInItems();
		}
		
		/**
		 * <span lang="ja">指定された ContextMenu オブジェクト内の Progression に関連するすべてのメニューアイテムを非表示にします。</span>
		 * <span lang="en"></span>
		 */
		public function hideProgressionItems():void {
			Object( this )._hideProgressionItems();
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			return "[object CastButtonContextMenu]";
		}
		
		
		
		
		
		/**
		 * 
		 */
		include "../includes/CastButtonContextMenu.inc"
	}
}
