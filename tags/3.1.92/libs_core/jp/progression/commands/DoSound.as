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
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import jp.progression.core.commands.Command;
	
	/**
	 * <span lang="ja">ロード操作が開始したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.OPEN
	 */
	[Event( name="open", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">データが正常にロードされたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event( name="complete", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">MP3 サウンドで ID3 データを使用できる場合に、Sound オブジェクトによって送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.ID3
	 */
	[Event( name="id3", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">ダウンロード処理を実行中にデータを受信したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event( name="progress", type="flash.events.ProgressEvent" )]
	
	/**
	 * <span lang="ja">入出力エラーが発生してロード処理が失敗したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event( name="ioError", type="flash.events.IOErrorEvent" )]
	
	/**
	 * <span lang="ja">サウンドの再生が終了したときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType flash.events.Event.SOUND_COMPLETE
	 */
	[Event( name="soundComplete", type="flash.events.Event" )]
	
	/**
	 * <span lang="ja">DoSound クラスは、Sound の再生を制御するコマンドクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * // DoSound コマンドを作成します。
	 * var com:DoSound = new DoSound( new Sound(), false );
	 * 
	 * // DoSound コマンドを実行します。
	 * com.execute();
	 * </listing>
	 */
	public class DoSound extends Command {
		
		/**
		 * <span lang="ja">再生する Sound オブジェクトを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get sound():Sound { return _sound; }
		public function set sound( value:Sound ):void { _sound = value; }
		private var _sound:Sound;
		
		/**
		 * <span lang="ja">サウンドの再生完了を待って、コマンド処理の完了とするかどうかを取得または設定します。</span>
		 * <span lang="en"></span>
		 */
		public function get waitForComplete():Boolean { return _waitForComplete; }
		public function set waitForComplete( value:Boolean ):void { _waitForComplete = value; }
		private var _waitForComplete:Boolean = false;
		
		/**
		 * SoundChannel インスタンスを取得します。
		 */
		private var _soundChannel:SoundChannel;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい DoSound インスタンスを作成します。</span>
		 * <span lang="en">Creates a new DoSound object.</span>
		 * 
		 * @param sound
		 * <span lang="ja">再生する Sound オブジェクトです。</span>
		 * <span lang="en"></span>
		 * @param waitForComplete
		 * <span lang="ja">サウンドの再生完了を待って、コマンド処理の完了とするかどうかです。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function DoSound( sound:Sound, waitForComplete:Boolean = false, initObject:Object = null ) {
			// 引数を設定する
			_sound = sound;
			_waitForComplete = waitForComplete;
			
			// スーパークラスを初期化する
			super( _execute, _interrupt, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// イベントを登録する
			sound.addEventListener( Event.OPEN, _open, false, int.MAX_VALUE, true );
			sound.addEventListener( Event.COMPLETE, _complete, false, int.MAX_VALUE, true );
			sound.addEventListener( Event.ID3, _id3, false, int.MAX_VALUE, true );
			sound.addEventListener( ProgressEvent.PROGRESS, _progress, false, int.MAX_VALUE, true );
			sound.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, int.MAX_VALUE, true );
			
			// 再生する
			_soundChannel = sound.play();
			
			// 再生終了を待つのであれば
			if ( _waitForComplete ) {
				// イベントリスナーを登録する
				_soundChannel.addEventListener( Event.SOUND_COMPLETE, _soundComplete, false, int.MAX_VALUE, true );
				return;
			}
			
			// 処理を終了する
			executeComplete();
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interrupt():void {
			if ( _soundChannel ) {
				// イベントリスナーを解除する
				_soundChannel.removeEventListener( Event.SOUND_COMPLETE, _soundComplete );
				
				// 再生を停止する
				_soundChannel.stop();
				
				// 破棄する
				_soundChannel = null;
			}
			
			// 処理を終了する
			interruptComplete();
		}
		
		/**
		 * <span lang="ja">DoSound インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an DoSound subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい DoSound インスタンスです。</span>
		 * <span lang="en">A new DoSound object that is identical to the original.</span>
		 */
		public override function clone():Command {
			return new DoSound( _sound, _waitForComplete, this );
		}
		
		
		
		
		
		/**
		 * ロード操作が開始したときに送出されます。
		 */
		private function _open( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * データが正常にロードされたときに送出されます。
		 */
		private function _complete( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * MP3 サウンドで ID3 データを使用できる場合に、Sound オブジェクトによって送出されます。
		 */
		private function _id3( e:Event ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * ロード処理を実行中にデータを受信したときに送出されます。
		 */
		private function _progress( e:ProgressEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * 入出力エラーが発生してロード操作が失敗したときに送出されます。
		 */
		private function _ioError( e:IOErrorEvent ):void {
			// イベントを送出する
			dispatchEvent( e );
		}
		
		/**
		 * サウンドの再生が終了したときに送出されます。
		 */
		private function _soundComplete( e:Event ):void {
			// イベントリスナーを解除する
			_soundChannel.removeEventListener( Event.SOUND_COMPLETE, _soundComplete );
			
			// 破棄する
			_soundChannel = null;
			
			// イベントを送出する
			dispatchEvent( e );
			
			// 処理を終了する
			executeComplete();
		}
	}
}
