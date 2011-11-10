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
	import jp.nium.api.tweener.TweenerEvent;
	import jp.nium.api.tweener.TweenerHelper;
	import jp.progression.core.commands.Command;
	
	/*======================================================================*//**
	 * <p>Tween 処理が開始された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.tweener.TweenerEvent.START
	 */
	[Event( name="start", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/*======================================================================*//**
	 * <p>Tween 処理が完了した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.tweener.TweenerEvent.COMPLETE
	 */
	[Event( name="complete", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/*======================================================================*//**
	 * <p>Tween 処理が上書きされた場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.tweener.TweenerEvent.OVERWRITE
	 */
	[Event( name="overwrite", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/*======================================================================*//**
	 * <p>Tween 処理でプロパティ値が変更された場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.tweener.TweenerEvent.UPDATE
	 */
	[Event( name="update", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/*======================================================================*//**
	 * <p>Tween 処理中にエラーが発生した場合に送出されます。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * @eventType jp.nium.api.tweener.TweenerEvent.ERROR
	 */
	[Event( name="error", type="jp.nium.api.tweener.TweenerEvent" )]
	
	/*======================================================================*//**
	 * <p>DoTweener クラスは、caurina.transitions.Tweener パッケージのイージング機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * @see http://code.google.com/p/tweener/
	 * @see http://code.google.com/p/tweener/wiki/License
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
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
		
		/*======================================================================*//**
		 * <p></p>
		 * <p>Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get target():Object { return _target; }
		public function set target( value:Object ):void { _target = value; }
		private var _target:Object;
		
		/*======================================================================*//**
		 * <p></p>
		 * <p>An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get parameters():Object { return _parameters; }
		public function set parameters( value:Object ):void { _parameters = value; }
		private var _parameters:Object;
		
		/*======================================================================*//**
		 * TweenerHelper インスタンスを取得します。
		 */
		private var _tweenerHelper:TweenerHelper;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい DoTweener インスタンスを作成します。</p>
		 * <p>Creates a new DoTweener object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param target
		 * 	<p></p>
		 * 	<p>Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</p>
		 * @param tweeningParameters
		 * 	<p></p>
		 * 	<p>An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</p>
		 * @param initObject
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 */
		public function DoTweener( target:Object = null, parameters:Object = null, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_parameters = parameters;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/*======================================================================*//**
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
		
		/*======================================================================*//**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			// Tween を停止する
			_tweenerHelper.removeTweens();
			
			// 処理を終了する
			interruptComplete();
		}
		/*======================================================================*//**
		 * <p>DoTweener インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTweener subclass.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @return
		 * 	<p>元のオブジェクトと同じプロパティ値を含む新しい DoTweener インスタンスです。</p>
		 * 	<p>A new DoTweener object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTweener( _target, _parameters, this );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * 
		 */
		private function _complete( e:TweenerEvent ):void {
			// イベントリスナーを解除する
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.COMPLETE, _complete );
			_tweenerHelper.addExclusivelyEventListener( TweenerEvent.ERROR, _error );
			
			// 処理を終了する
			executeComplete();
		}
		
		/*======================================================================*//**
		 * 
		 */
		private function _error( e:TweenerEvent ):void {
			// イベントリスナーを解除する
			_tweenerHelper.completelyRemoveEventListener( TweenerEvent.COMPLETE, _complete );
			_tweenerHelper.addExclusivelyEventListener( TweenerEvent.ERROR, _error );
			
			// 処理を実行する
			_catchError( this, e.metaError );
		}
		
	}
}









