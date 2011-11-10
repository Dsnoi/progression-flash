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
package jp.progression.commands {
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Break クラスは、実行中の処理を強制的に中断するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // SerialList インスタンスを作成します。
	 * var list:SerialList = new SerialList();
	 * 
	 * // コマンドを追加します。
	 * list.addCommand(
	 * 	// 出力パネルにストリングを送出します。
	 * 	new Trace( "最初に実行されるコマンドです。" ),
	 * 	// その場で処理を強制中断します。
	 * 	new Break(),
	 * 	// 出力パネルにストリングを送出します。
	 * 	new Trace( "このコマンドは実行されません。" )
	 * );
	 * 
	 * // SerialList コマンドを実行します。
	 * list.execute();
	 * </listing>
	 */
	public class Break extends Command {
		
		/**
		 * <span lang="ja">新しい Break インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Break object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Break( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 処理を強制中断する
			interrupt( true, extra );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">Break インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Break subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Break インスタンスです。</span>
		 * <span lang="en">A new Break object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Break( this );
		}
	}
}
