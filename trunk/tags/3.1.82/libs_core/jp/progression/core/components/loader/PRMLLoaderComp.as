﻿/**
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
package jp.progression.core.components.loader {
	import flash.net.URLRequest;
	import jp.nium.utils.MovieClipUtil;
	import jp.nium.utils.StageUtil;
	import jp.progression.core.components.loader.LoaderComp;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.loader.PRMLLoader;
	
	[IconFile( "PRMLLoader.png" )]
	/**
	 * @private
	 */
	public class PRMLLoaderComp extends LoaderComp {
		
		/**
		 * PRMLLoader インスタンスを取得します。
		 */
		private var _loader:PRMLLoader;
		
		
		
		
		
		/**
		 * @private
		 */
		public function PRMLLoaderComp() {
			// イベントリスナーを登録する
			addExclusivelyEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded, false, 0, true );
		}
		
		
		
		
		
		/**
		 * 読み込み処理を実行します。
		 */
		private function _load():void {
			// 読み込むファイルの基点を設定する
			var url:String = useSWFBasePath ? StageUtil.toSWFBasePath( stage, url ) : url;
			
			// PRMLLoader を作成する
			_loader = new PRMLLoader( stage );
			_loader.autoLock = autoLock;
			_loader.sync = sync;
			_loader.load( new URLRequest( url ) );
		}
		
		
		
		
		
		/**
		 * コンポーネントが有効化された状態で、表示オブジェクトが、直接、または表示オブジェクトを含むサブツリーの追加により、ステージ上の表示リストに追加されたときに送出されます。
		 */
		private function _componentAdded( e:ComponentEvent ):void {
			// イベントリスナーを解除する
			completelyRemoveEventListener( ComponentEvent.COMPONENT_ADDED, _componentAdded );
			
			// コンポーネントのパラメータ設定を待って実行する
			MovieClipUtil.doLater( null, _load );
		}
	}
}
