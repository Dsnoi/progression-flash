/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.92
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.core.display {
	import flash.display.DisplayObject;
	import jp.nium.events.IEventIntegrator;
	
	/**
	 * <span lang="ja">IExDisplayObject インターフェイスは IEventIntegrator を拡張し、DisplayObject の基本機能を強化する機能を実装します。</span>
	 * <span lang="en">IExDisplayObject interface extends IEventIntegrator and implements the function to enhance the basic function of the DisplayObject.</span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public interface IExDisplayObject extends IEventIntegrator {
		
		/**
		 * <span lang="ja">インスタンスのクラス名を取得します。</span>
		 * <span lang="en">Indicates the instance className of the IExDisplayObject.</span>
		 */
		function get className():String;
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得または設定します。</span>
		 * <span lang="en">Indicates the instance id of the IExDisplayObject.</span>
		 */
		function get id():String;
		function set id( value:String ):void;
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the IExDisplayObject.</span>
		 */
		function get group():String;
		function set group( value:String ):void;
		
		
		
		
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</span>
		 * <span lang="en">Returns the instance which implements the IExDisplayObject interface with same specified id value.</span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en"></span>
		 */
		function getInstanceById( id:String ):DisplayObject;
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface with same specified group value.</span>
		 * 
		 * @param group
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en">The string to become a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance which match to the condition.</span>
		 */
		function getInstancesByGroup( group:String, sort:Boolean = false ):Array;
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface which the specified fieldName matches to the condition.</span>
		 * 
		 * @param fieldName
		 * <span lang="ja">調査するフィールド名です。</span>
		 * <span lang="en">The field name to check.</span>
		 * @param pattern
		 * <span lang="ja">条件となる正規表現です。</span>
		 * <span lang="en">The regular expression to become a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance which match to the condition.</span>
		 */
		function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array;
		
		/**
		 * <span lang="ja">インスタンスに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en">Setup the several instance properties.</span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en">The object that contains the property to setup.</span>
		 * @return
		 * <span lang="ja">設定対象の DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to setup.</span>
		 */
		function setProperties( props:Object ):DisplayObject;
	}
}
