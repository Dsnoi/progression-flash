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
package jp.nium.core.display {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import jp.nium.events.IEventIntegrator;
	
	/*======================================================================*//**
	 * <p>IExDisplayObject インターフェイスは IEventIntegrator を拡張し、DisplayObject の基本機能を強化する機能を実装します。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface IExDisplayObject extends IEventIntegrator {
		
		/*======================================================================*//**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function get className():String;
		
		/*======================================================================*//**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function get id():String;
		function set id( value:String ):void;
		
		/*======================================================================*//**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		function get group():String;
		function set group( value:String ):void;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		function getInstanceById( id:String ):DisplayObject;
		
		/*======================================================================*//**
		 * <p>指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param group
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		function getInstancesByGroup( group:String, sort:Boolean = false ):Array;
		
		/*======================================================================*//**
		 * <p>指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param fieldName
		 * 	<p>調査するフィールド名です。</p>
		 * 	<p></p>
		 * @param pattern
		 * 	<p>条件となる正規表現です。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array;
		
		/*======================================================================*//**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param props
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>設定対象の DisplayObject インスタンスです。</p>
		 * 	<p></p>
		 */
		function setProperties( props:Object ):DisplayObject;
	}
}









