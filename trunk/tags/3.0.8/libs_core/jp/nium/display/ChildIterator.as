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
package jp.nium.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import jp.nium.core.display.IExDisplayObjectContainer;
	
	/*======================================================================*//**
	 * <p>ChildIterator クラスは、IExDisplayObjectContainer インターフェイスを実装しているクラスと実装していないクラスを同じ構文で走査するためのイテレータクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ChildIterator {
		
		/*======================================================================*//**
		 * インデックスを整理する対象コンテナを取得します。
		 */
		private var _container:DisplayObjectContainer;
		
		/*======================================================================*//**
		 * 現在のインデックス位置を取得します。
		 */
		private var _index:int = 0;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ChildIterator インスタンスを作成します。</p>
		 * <p>Creates a new ChildIterator object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param container
		 * 	<p>関連付けたい DisplayObjectContainer インスタンスです。</p>
		 * 	<p></p>
		 */
		public function ChildIterator( container:DisplayObjectContainer ) {
			// 引数を保存する
			_container = container;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>現在の対象を返して、次の対象にインデックスを進めます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>現在の対象である DisplayObject インスタンスです。</p>
		 * 	<p></p>
		 */
		public function next():DisplayObject {
			var index:int = _index++;
			
			// IExDisplayObjectContainer を実装していれば
			if ( _container is IExDisplayObjectContainer ) {
				return IExDisplayObjectContainer( _container ).children[index] as DisplayObject;
			}
			
			return ( index < _container.numChildren ) ? _container.getChildAt( index ) : null;
		}
		
		/*======================================================================*//**
		 * <p>現在のインデックス位置に対象が存在するかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>対象が存在すれば true を、存在しなければ false です。</p>
		 * 	<p></p>
		 */
		public function hasNext():Boolean {
			return ( _index < _container.numChildren );
		}
		
		/*======================================================================*//**
		 * <p>現在のインデックス位置をリセットします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function reset():void {
			_index = 0;
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
			return "[object ChildIterator]";
		}
	}
}









