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
package jp.progression.core {
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.utils.getDefinitionByName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.StageUtil;
	import jp.nium.utils.StringUtil;
	import jp.progression.Progression;
	
	/**
	 * @private
	 */
	public final class PackageInfo {
		
		/**
		 * @private
		 */
		public static function get hasTweener():Boolean { return _hasTweener; }
		private static var _hasTweener:Boolean = ( function():Boolean {
			try { return Boolean( !!getDefinitionByName( "caurina.transitions.Tweener" ) ); }
			catch ( e:Error ) {}
			
			return false;
		} )();
		
		/**
		 * @private
		 */
		public static function get hasSWFAddress():Boolean { return _hasSWFAddress; }
		private static var _hasSWFAddress:Boolean = ( function():Boolean {
			try { return Boolean( !!getDefinitionByName( "com.asual.swfaddress.SWFAddress" ) ); }
			catch ( e:Error ) {}
			
			return false;
		} )();
		
		/**
		 * @private
		 */
		public static function get hasSWFWheel():Boolean { return _hasSWFWheel; }
		private static var _hasSWFWheel:Boolean = ( function():Boolean {
			try { return Boolean( !!getDefinitionByName( "org.libspark.ui.SWFWheel" ) ); }
			catch ( e:Error ) {}
			
			return false;
		} )();
		
		/**
		 * 
		 */
		private static var _local:LocalConnection;
		
		/**
		 * 
		 */
		private static var _activated:Boolean = false;
		
		
		
		
		
		/**
		 * @private
		 */
		public function PackageInfo() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "PackageInfo" ) );
		}
		
		
		
		
		
		/**
		 * @private
		 */
		public static function activate( stage:Stage ):void {
			if ( _activated ) { return; }
			
			try {
				var url:String = StringUtil.toProperType( ExternalInterface.call( "function() { return window.location.href; }" ) ) || StageUtil.getDocument( stage ).loaderInfo.url;
			}
			catch ( e:Error ) {}
			
			try {
				_local = new LocalConnection();
				_local.addEventListener( StatusEvent.STATUS, _status, false, 0, true );
				_local.send( "application/progression-license-activation", "output", { version:Progression.VERSION.toString(), activatedLicenseType:Progression.activatedLicenseType, url:url } );
			}
			catch ( e:Error ) {}
			
			_activated = true;
		}
		
		
		
		
		
		/**
		 * 
		 */
		private static function _status( e:StatusEvent ):void {
			_local.removeEventListener( StatusEvent.STATUS, _status );
		}
	}		
}
