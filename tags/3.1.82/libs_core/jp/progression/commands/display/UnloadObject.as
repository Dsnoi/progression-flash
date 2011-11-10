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
package jp.progression.commands.display {
	import flash.display.Loader;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">UnlLoadObject クラスは、対象の Loader インスタンスが読み込んでいるコンテンツを破棄するコマンドクラスです。
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * // 表示コンテナとなる CastSprite インスタンスを作成します。
	 * var container:CastSprite = new CastSprite();
	 * 
	 * // 外部ファイルを読み込む CastLoader インスタンスを作成します。
	 * var loader:CastLoader = new CastLoader();
	 * 
	 * // 複数のコマンドを連続で実行するコマンドリストを作成します。
	 * var com:SerialList = new SerialList( null,
	 * 	// 外部ファイルの読み込みを制御します。
	 * 	new LoadObject( loader, new URLRequest( "external.swf" ), {
	 * 		// 読み込み処理が開始された際に実行したい関数を指定します。
	 * 		onCastLoadStart:function():void {
	 * 			this.addCommand(
	 * 				new Trace( "start" )
	 * 			);
	 * 		},
	 * 		// 読み込み処理中に実行したい関数を指定します。
	 * 		onProgress:function():void {
	 * 			trace( this.bytesLoaded / this.bytesTotal );
	 * 		},
	 * 		// 読み込み処理が完了した際に実行したい関数を指定します。
	 * 		onCastLoadComplete:function():void {
	 * 			this.addCommand(
	 * 				new Trace( "complete" )
	 * 			);
	 * 		}
	 * 	} ),
	 * 	// 画面に表示します。
	 * 	new AddChild( prog.container, loader ),
	 * 	// 画面から削除します。
	 * 	new RemoveChild( prog.container, loader ),
	 * 	// 読み込みを破棄します。
	 * 	new UnloadObject( loader )
	 * );
	 * 
	 * // コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class UnloadObject extends Command {
		
		/**
		 * <span lang="ja">読み込み処理を監視したい Loader インスタンスを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get loader():Loader { return _loader; }
		public function set loader( value:Loader ):void { _loader = value; }
		private var _loader:Loader;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい UnloadObject インスタンスを作成します。</span>
		 * <span lang="en">Creates a new UnloadObject object.</span>
		 * 
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function UnloadObject( loader:Loader, initObject:Object = null ) {
			// 引数を設定する
			_loader = loader;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 破棄する
			_loader.unload();
			_loader = null;
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// 破棄する
			_loader.unload();
			_loader = null;
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">UnloadObject インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an UnloadObject subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい UnloadObject インスタンスです。</span>
		 * <span lang="en">A new UnloadObject object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new UnloadObject( _loader, this );
		}
	}
}
