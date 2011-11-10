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
package jp.nium.core.collections {
	import flash.utils.Dictionary;
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.core.namespaces.nium_internal;

	use namespace nium_internal;
	
	/*======================================================================*//**
	 * @private
	 */
	public class ExDisplayCollection {
		
		/*======================================================================*//**
		 * 全てのインスタンスを保存した Dictionary インスタンスを取得します。
		 */
		private static var _instances:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 登録されたインスタンス数を取得します。
		 */
		private static var _numInstances:int = 0;
		
		/*======================================================================*//**
		 * 登録されたインスタンス番号をキーとして保存した Dictionary インスタンスを取得します。
		 */
		private static var _nums:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 登録されたインスタンスを識別子をキーとして保存した Dictionary インスタンスを取得します。
		 */
		private static var _ids:Dictionary = new Dictionary( true );
		
		/*======================================================================*//**
		 * 登録されたインスタンスを group の値をキーとして保存した Dictionary インスタンスを取得します。
		 */
		private static var _groups:Dictionary = new Dictionary( true );
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		public function ExDisplayCollection() {
			throw new ArgumentError( ErrorMessageConstants.getMessage( "ERROR_2012", "ExDisplayCollection" ) );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function addInstance( instance:IExDisplayObject ):void {
			_instances[_numInstances] = instance;
			_nums[instance] = _numInstances++;
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function addInstanceAtId( instance:IExDisplayObject, id:String ):String {
			id ||= "";
			
			var oldInstance:IExDisplayObject = IExDisplayObject( _ids[id] );
			
			// 既存の設定が存在すれば削除する
			if ( oldInstance ) {
				oldInstance.id = "";
				delete _ids[id];
			}
			
			// 旧設定を削除する
			delete _ids[instance.id];
			
			// 新しい設定を行う
			if ( id != "" ) {
				_ids[id] = instance;
			}
			
			return id;
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function addInstanceAtGroup( instance:IExDisplayObject, group:String ):String {
			group ||= "";
			
			var groups:Array = _groups[group] as Array;
			
			// 既存の設定が存在すれば削除する
			if ( groups ) {
				var l:int = groups.length;
				for ( var i:int = 0; i < l; i++ ) {
					// 違っていれば次へ
					if ( groups[i] != instance ) { continue; }
					
					instance.group = "";
					groups.splice( i, 1 );
					
					break;
				}
			}
			
			// 新しい設定を行う
			if ( group != "" ) {
				// 配列が存在しなければ作成する
				if ( !_groups[group] ) {
					_groups[group] = [];
				}
				
				groups = _groups[group];
				
				// 登録する
				groups.push( instance );
			}
			else {
				groups = _groups[instance.group];
				
				l = groups.length;
				for ( i = 0; i < l; i++ ) {
					// 違っていれば次へ
					if ( groups[i] != instance ) { continue; }
					
					groups.splice( i, 1 );
					instance.group = "";
					
					break;
				}
			}
			
			return group;
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function getNumByInstance( instance:IExDisplayObject ):int {
			return int( _nums[instance] );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function getInstanceById( id:String ):IExDisplayObject {
			return IExDisplayObject( _ids[id] );
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
			var groups:Array = _groups[group] as Array;
			groups = groups ? groups.slice() : []
			
			// ソートを行うのであれば
			if ( sort ) {
				groups.sortOn( [ "id", "name", "group" ] );
			}
			
			return groups;
		}
		
		/*======================================================================*//**
		 * @private
		 */
		nium_internal static function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			var instances:Array = [];
			
			for each ( var instance:IExDisplayObject in _instances ) {
				// プロパティが存在しなければ次へ
				if ( !( fieldName in instance ) ) { continue; }
				
				// 条件に合致しなければ次へ
				pattern.lastIndex = 0;
				if ( !pattern.test( String( instance[fieldName] ) ) ) { continue; }
				
				instances.push( instance );
			}
			
			// ソートを行うのであれば
			if ( sort ) {
				instances.sortOn( [ "id", "name", "group" ] );
			}
			
			return instances;
		}
	}
}









