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
	import jp.nium.api.tweener.TweenerEvent;
	import jp.nium.api.tweener.TweenerHelper;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">Tween 処理が開始された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.api.tweener.TweenerEvent.START
	 */
	[Event( name="start", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/**
	 * <span lang="ja">Tween 処理が完了した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.api.tweener.TweenerEvent.COMPLETE
	 */
	[Event( name="complete", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/**
	 * <span lang="ja">Tween 処理が上書きされた場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.api.tweener.TweenerEvent.OVERWRITE
	 */
	[Event( name="overwrite", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/**
	 * <span lang="ja">Tween 処理でプロパティ値が変更された場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.api.tweener.TweenerEvent.UPDATE
	 */
	[Event( name="update", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/**
	 * <span lang="ja">Tween 処理中にエラーが発生した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.api.tweener.TweenerEvent.ERROR
	 */
	[Event( name="error", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/**
	 * <span lang="ja">DoTweener クラスは、caurina.transitions.Tweener パッケージのイージング機能を実行するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * @see http://code.google.com/p/tweener/
	 * @see http://code.google.com/p/tweener/wiki/License
	 * 
	 * @example <listing version="3.0">
	 * // MovieClip インスタンスを作成する
	 * var mc:MovieClip = new MovieClip();
	 * 
	 * // DoTweener コマンドを作成します。
	 * var com:DoTweener = new DoTweener( mc, {
	 * 	// ( 100, 100 ) の座標に移動します。
	 * 	x			:100,
	 * 	y			:100
	 * } );
	 * 
	 * // DoTweener コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class DoTweener extends Command {
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en">Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</span>
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en">An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</span>
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object;
		
		/**
		 * TweenerHelper インスタンスを取得します。
		 */
		private var _tweenerHelper:TweenerHelper;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DoTweener インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DoTweener object.</span>
		 * 
		 * @param target
		 * <span lang="ja"></span>
		 * <span lang="en">Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</span>
		 * @param tweeningParameters
		 * <span lang="ja"></span>
		 * <span lang="en">An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function DoTweener( target:Object, parameters:Object, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_parameters = parameters;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// タイムアウトを再設定する
			timeOut = Math.max( timeOut, _parameters.time + 5000 );
			
			// TweenerHelper を作成する
			_tweenerHelper = new TweenerHelper( _target, _parameters );
			_tweenerHelper.addExclusivelyEventListener( TweenerEvent.COMPLETE, _complete, false, int.MAX_VALUE, true );
			_tweenerHelper.addExclusivelyEventListener( TweenerEvent.ERROR, _error, false, int.MAX_VALUE, true );
			
			// アニメーションを開始する
			if ( _tweenerHelper.doTween() ) { return; }
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// Tween を停止する
			_tweenerHelper.removeTweens();
			
			// 処理を終了する
			interruptComplete();
		}
		/**
		 * <span lang="ja">DoTweener インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DoTweener subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DoTweener インスタンスです。</span>
		 * <span lang="en">A new DoTweener object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new DoTweener( _target, _parameters, this );
		}
		
		
		
		
		
		/**
		 */
		private function _complete( e:TweenerEvent ):void {
			// イベントリスナーを解除する
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.COMPLETE, _complete );
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.ERROR, _error );
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 */
		private function _error( e:TweenerEvent ):void {
			// イベントリスナーを解除する
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.COMPLETE, _complete );
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.ERROR, _error );
			
			// 処理を実行する
			_catchError( this, e.metaError );
		}
		
	}
}
