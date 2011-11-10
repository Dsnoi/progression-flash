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
package jp.progression.commands {
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Trace クラスは、trace() メソッドを実行するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // Trace コマンドを作成します。
	 * var com:Trace = new Trace( "設定されたストリングを出力します。" );
	 * 
	 * // Trace コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class Trace extends Command {
		
		/**
		 * <span lang="ja">出力したい内容を取得または設定します。
		 * この値に関数を設定した場合、実行結果を出力します。</span>
		 * <span lang="en"></span>
		 */
		public function get message():* { return _message; }
		public function set message( value:* ):void { _message = value; }
		private var _message:*;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Trace インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Trace object.</span>
		 * 
		 * @param message
		 * <span lang="ja">出力したい内容です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Trace( message:*, initObject:Object = null ) {
			// 引数を設定する
			this.message = message;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 出力する
			_trace();
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 */
		private function _trace():void {
			// 出力する
			switch ( true ) {
				case _message is Function								: { trace( _message.apply( this ) ); break; }
				case _message is Array									: { trace( ArrayUtil.toString( _message as Array ) ); break; }
				case ClassUtil.getClassName( _message ) == "Object"		: { trace( ObjectUtil.toString( _message as Object ) ); break; }
				default													: { trace( _message ); }
			}
		}
		
		/**
		 * <span lang="ja">Trace インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Trace subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Trace インスタンスです。</span>
		 * <span lang="en">A new Trace object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Trace( _message, this );
		}
	}
}
