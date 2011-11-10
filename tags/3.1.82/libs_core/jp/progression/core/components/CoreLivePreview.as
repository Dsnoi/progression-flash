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
package jp.progression.core.components {
	import fl.livepreview.LivePreviewParent;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.StringUtil;
	
	/**
	 * @private
	 */
	public class CoreLivePreview extends LivePreviewParent {
		
		/**
		 */
		public function get parameters():Object { return _parameters; }
		private var _parameters:Object = {};
		
		
		
		
		
		/**
		 * @private
		 */
		public function CoreLivePreview() {
			// 継承せずにオブジェクト化されたらエラーを送出する
			if ( getQualifiedSuperclassName( this ) == getQualifiedClassName( LivePreviewParent ) ) { throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "CoreLivePreview" ) ); }
		}
		
		
		
		
		
		/**
		 * @private
		 */
		public override function onUpdate( ... updateArray:Array ):void {
			// パラメータを初期化する
			_parameters = {};
			
			// パラメータを設定する
			var l:int = updateArray.length;
			for ( var i:int = 0; i < l; i += 2 ) {
				_parameters[updateArray[i]] = StringUtil.toProperType( updateArray[i + 1] );
			}
			
			// イベントを送出する
			dispatchEvent( new Event( Event.CHANGE ) );
		}
	}
}
