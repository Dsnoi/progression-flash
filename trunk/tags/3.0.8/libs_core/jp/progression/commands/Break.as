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
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Break クラスは、実行中の処理を強制的に中断するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
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
		
		/*======================================================================*//**
		 * <p>新しい Break インスタンスを作成します。</p>
		 * <p>Creates a new Break object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Break( initObject:Object = null ) {
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 処理を強制中断する
			interrupt( true, extra );
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>Break インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Break subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Break インスタンスです。</p>
		 * 	<p>A new Break object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Break( this );
		}
	}
}









