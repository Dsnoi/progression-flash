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
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Prop クラスは、指定された対象の複数のプロパティを一括で設定するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * var o:Object = {
	 * 	aaa		:"aaa",
	 * 	bbb		:"bbb"
	 * };
	 * 
	 * // Prop コマンドを作成します。
	 * var com:Prop = new Prop( o, {
	 * 	aaa		:"AAA",
	 * 	bbb		:"BBB",
	 * 	ccc		:"CCC"
	 * } );
	 * 
	 * // Prop コマンドでルートシーンに移動します。
	 * com.execute();
	 * 
	 * // 結果を出力します。
	 * trace( o.aaa ); // AAA
	 * trace( o.bbb ); // BBB
	 * trace( o.ccc ); // undefined
	 * </listing>
	 */
	public class Prop extends Command {
		
		/*======================================================================*//**
		 * <p>プロパティを設定したい対象のオブジェクトを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/*======================================================================*//**
		 * <p>対象に設定したいプロパティを含んだオブジェクトを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get props():Object { return _props; }
		public function set props( value:Object ):void { _props = value; }
		private var _props:Object;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい Prop インスタンスを作成します。</p>
		 * <p>Creates a new Prop object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p>プロパティを設定したい対象のオブジェクトです。</p>
		 * 	<p></p>
		 * @param props
		 * 	<p>対象に設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function Prop( target:* = null, props:Object = null, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_props = props;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// プロパティを設定する
			ObjectUtil.setProperties( _target, _props );
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// プロパティを設定する
			ObjectUtil.setProperties( _target, _props );
			
			// 処理を終了する
			interruptComplete();
		}
		
		/*======================================================================*//**
		 * <p>Prop インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an Prop subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい Prop インスタンスです。</p>
		 * 	<p>A new Prop object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new Prop( _target, _props, this );
		}
	}
}









