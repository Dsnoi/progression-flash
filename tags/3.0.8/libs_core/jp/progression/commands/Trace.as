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
package jp.progression.commands {
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Trace クラスは、trace() メソッドを実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * // Trace コマンドを作成します。
	 * var com:Trace = new Trace( "設定されたストリングを出力します。" );
	 * 
	 * // Trace コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class Trace extends Command {
		
		/*======================================================================*//**
		 * <p>出力したい内容を取得または設定します。
		 * この値に関数を設定した場合、実行結果を出力します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get message():* { return _message; }
		public function set message( value:* ):void { _message = value; }
		private var _message:*;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Trace インスタンスを作成します。</p>
		 * <p>Creates a new Trace object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param message
		 * 	<p>出力したい内容です。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Trace( message:* = null, initObject:Object = null ) {
			// 引数を設定する
			this.message = message;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 出力する
			switch ( true ) {
				case _message is Function								: { trace( _message.apply( this ) ); break; }
				case _message is Array									: { trace( ArrayUtil.toString( _message as Array ) ); }
				case ClassUtil.getClassName( _message ) == "Object"		: { trace( ObjectUtil.toString( _message as Object ) ); }
				default													: { trace( _message ); }
			}
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 出力する
			switch ( true ) {
				case _message is Function								: { trace( _message.apply( this ) ); break; }
				case _message is Array									: { trace( ArrayUtil.toString( _message as Array ) ); }
				case ClassUtil.getClassName( _message ) == "Object"		: { trace( ObjectUtil.toString( _message as Object ) ); }
				default													: { trace( _message ); }
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>Trace インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Trace subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Trace インスタンスです。</p>
		 * 	<p>A new Trace object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Trace( _message, this );
		}
	}
}









