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
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Prop クラスは、指定された対象の複数のプロパティを一括で設定するコマンドクラスです。</span>
	 * <span lang="en"></span>
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
		
		/**
		 * <span lang="ja">プロパティを設定したい対象のオブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/**
		 * <span lang="ja">対象に設定したいプロパティを含んだオブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get props():Object { return _props; }
		public function set props( value:Object ):void { _props = value; }
		private var _props:Object;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Prop インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Prop object.</span>
		 * 
		 * @param target
		 * <span lang="ja">プロパティを設定したい対象のオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param props
		 * <span lang="ja">対象に設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function Prop( target:*, props:Object, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_props = props;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// プロパティを設定する
			ObjectUtil.setProperties( _target, _props );
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// プロパティを設定する
			ObjectUtil.setProperties( _target, _props );
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">Prop インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Prop subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Prop インスタンスです。</span>
		 * <span lang="en">A new Prop object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new Prop( _target, _props, this );
		}
	}
}
