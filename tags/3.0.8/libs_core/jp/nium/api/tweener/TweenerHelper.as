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
package jp.nium.api.tweener {
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	import jp.nium.api.tweener.TweenerEvent;
	import jp.nium.events.EventIntegrator;
	import jp.nium.utils.MovieClipUtil;
	
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
	 * <p>TweenerHelper クラスは、Tweener クラスの機能を拡張し、インスタンスとして扱えるようにするためのアダプタクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 */
	public class TweenerHelper extends EventIntegrator {
		
		/*======================================================================*//**
		 * Tweener を実行する対象を取得します。
		 */
		private var _scopes:Object;
		
		/*======================================================================*//**
		 * Tweener を実行する対象の変化値を取得します。
		 */
		private var _parameters:Object;
		
		/*======================================================================*//**
		 * Tweener に設定されているプロパティを取得します。
		 */
		private var _onCompleteFunction:Function;
		private var _onCompleteParams:Array;
		private var _onErrorFunction:Function;
		private var _onErrorScope:Object;
		private var _onOverwriteFunction:Function;
		private var _onOverwriteParams:Array;
		private var _onOverwriteScope:Object;
		private var _onStartFunction:Function;
		private var _onStartParams:Array;
		private var _onStartScope:Object;
		private var _onUpdateFunction:Function;
		private var _onUpdateParams:Array;
		private var _onUpdateScope:Object;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい TransitionHelper インスタンスを作成します。</p>
		 * <p>Creates a new TransitionHelper object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param scopes
		 * 	<p></p>
		 * 	<p>Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</p>
		 * @param parameters
		 * 	<p></p>
		 * 	<p>An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</p>
		 */
		public function TweenerHelper( scopes:Object = null, parameters:Object = null ) {
			// 引数を設定する
			_scopes = scopes;
			_parameters = parameters;
			
			// 特定のパラメータが存在すれば
			switch ( true ) {
				case "_frame" in _parameters	: {
					// frame の値を取得する
					var frame:* = _parameters._frame;
					
					// 数値であればそのままにする
					if ( frame is int ) { break; }
					
					// MovieClip でなければ終了する
					if ( !( _scopes is MovieClip ) ) { break; }
					
					// ラベルをフレームに変換する
					_parameters._frame = MovieClipUtil.labelToFrames( MovieClip( _scopes ), frame )[0];
					break;
				}
			}
			
			// 既存のプロパティを保存する
			_onCompleteFunction = _parameters.onComplete;
			_onCompleteParams = _parameters.onCompleteParams;
			_onErrorFunction = _parameters.onError;
			_onErrorScope = _parameters.onErrorScope;
			_onOverwriteFunction = _parameters.onOverwrite;
			_onOverwriteParams = _parameters.onOverwriteParams;
			_onOverwriteScope = _parameters.onOverwriteScope;
			_onStartFunction = _parameters.onStart;
			_onStartParams = _parameters.onStartParams;
			_onStartScope = _parameters.onStartScope;
			_onUpdateFunction = _parameters.onUpdate;
			_onUpdateParams = _parameters.onUpdateParams;
			_onUpdateScope = _parameters.onUpdateScope;
			
			// イベントハンドラメソッドを登録する
			_parameters.onComplete = _onComplete;
			_parameters.onError = _onError;
			_parameters.onOverwrite = _onOverwrite;
			_parameters.onStart = _onStart;
			_parameters.onUpdate = _onUpdate;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>Tweener を実行します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function doTween():Boolean {
			return Tweener.addTween( _scopes, _parameters );
		}
		
		/*======================================================================*//**
		 * <p>実行中の Tweener を停止します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param properties
		 * 	<p></p>
		 * 	<p>The name of the property or properties currently being tweened that you want to pause. This is a string containing the name of the property, and any number of strings can be specified as parameters. If no property name is specified, all tweenings for this specific target target are paused.</p>
		 */
		public function pauseTweens( ... properties:Array ):Boolean {
			return Tweener.pauseTweens.apply( null, [ _scopes ].concat( properties ) );
		}
		
		/*======================================================================*//**
		 * <p>停止中の Tweener を再開します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param properties
		 * 	<p></p>
		 * 	<p>The name of the property or properties that have paused tweenings that you want to resume. This is a string containing the name of the property, and any number of strings can be specified as parameters. If no property name is specified, all paused tweenings for this specific target target are resumed.</p>
		 */
		public function resumeTweens( ... properties:Array ):Boolean {
			return Tweener.pauseTweens.apply( null, [ _scopes ].concat( properties ) );
		}
		
		/*======================================================================*//**
		 * <p>実行中の Tweener を削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param properties
		 * 	<p></p>
		 * 	<p>The name of the property or properties currently being tweened that you want to remove. This is a string containing the name of the property, and any number of strings can be specified as parameters. If no property name is specified, all tweenings for this specific target are removed.</p>
		 */
		public function removeTweens( ... properties:Array ):Boolean {
			return Tweener.removeTweens.apply( null, [ _scopes ].concat( properties ) );
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
		public override function toString():String {
			return "[object TweenerHelper]";
		}
		
		/*======================================================================*//**
		 * Tweeener.onComplete() のイベントハンドラメソッドを中継します。
		 */
		private function _onComplete():void {
			// Tweener に設定されていた onComplete() メソッドを実行する
			if ( _onCompleteFunction is Function ) {
				_onCompleteFunction.apply( _scopes, _onCompleteParams );
			}
			
			// イベントを送出する
			dispatchEvent( new TweenerEvent( TweenerEvent.COMPLETE ) );
		}
		
		/*======================================================================*//**
		 * Tweeener.onError() のイベントハンドラメソッドを中継します。
		 */
		private function _onError( errorScope:Object, metaError:Error ):void {
			// Tweener に設定されていた onError() メソッドを実行する
			if ( _onErrorFunction is Function ) {
				_onErrorFunction.apply( _onErrorScope, [ errorScope, metaError ] );
			}
			
			// イベントを送出する
			dispatchEvent( new TweenerEvent( TweenerEvent.ERROR, false, false, metaError ) );
		}
		
		/*======================================================================*//**
		 * Tweeener.onOverwrite() のイベントハンドラメソッドを中継します。
		 */
		private function _onOverwrite():void {
			// Tweener に設定されていた onOverwrite() メソッドを実行する
			if ( _onOverwriteFunction is Function ) {
				_onOverwriteFunction.apply( _onOverwriteScope, _onOverwriteParams );
			}
			
			// イベントを送出する
			dispatchEvent( new TweenerEvent( TweenerEvent.OVERWRITE ) );
		}
		
		/*======================================================================*//**
		 * Tweeener.onStart() のイベントハンドラメソッドを中継します。
		 */
		private function _onStart():void {
			// Tweener に設定されていた onStart() メソッドを実行する
			if ( _onStartFunction is Function ) {
				_onStartFunction.apply( _onStartScope, _onStartParams );
			}
			
			// イベントを送出する
			dispatchEvent( new TweenerEvent( TweenerEvent.START ) );
		}
		
		/*======================================================================*//**
		 * Tweeener.onUpdate() のイベントハンドラメソッドを中継します。
		 */
		private function _onUpdate():void {
			// Tweener に設定されていた onUpdate() メソッドを実行する
			if ( _onUpdateFunction is Function ) {
				_onUpdateFunction.apply( _onUpdateScope, _onUpdateParams );
			}
			
			// イベントを送出する
			dispatchEvent( new TweenerEvent( TweenerEvent.UPDATE ) );
		}
	}
}









