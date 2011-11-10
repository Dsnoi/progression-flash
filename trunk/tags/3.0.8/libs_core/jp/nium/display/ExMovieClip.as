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
package jp.nium.display {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import jp.nium.core.display.ExDisplayObjectContainer;
	import jp.nium.core.display.IExDisplayObjectContainer;
	import jp.nium.core.namespaces.nium_internal;
	import jp.nium.events.IEventIntegrator;
	import jp.nium.utils.MovieClipUtil;
	
	use namespace nium_internal;
	
	/*======================================================================*//**
	 * <p>ExMovieClip クラスは、MovieClip クラスの基本機能を拡張した jp.nium パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExMovieClip extends MovieClip implements IExDisplayObjectContainer, IEventIntegrator {
		
		/*======================================================================*//**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get className():String { return _exDisplayObject.className; }
		
		/*======================================================================*//**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get id():String { return _exDisplayObject.id; }
		public function set id( value:String ):void { _exDisplayObject.id = value; }
		
		/*======================================================================*//**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the IExDisplayObject.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get group():String { return _exDisplayObject.group; }
		public function set group( value:String ):void { _exDisplayObject.group = value; }
		
		/*======================================================================*//**
		 * <p>子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能である為、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get children():Array { return _exDisplayObject.children; }
		
		/*======================================================================*//**
		 * <p>startDrag() メソッドを使用したドラッグ処理を行っている最中かどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get isDragging():Boolean { return _isDragging; }
		private var _isDragging:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ムービークリップのタイムライン内で再生ヘッドの移動処理が行われているかどうかを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get isPlaying():Boolean { return _isPlaying; }
		private var _isPlaying:Boolean = false;
		
		/*======================================================================*//**
		 * <p>ムービークリップの再生ヘッドが最後のフレームに移動された後に、最初のフレームに戻って再生を続けるかどうかを取得または設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get repeat():Boolean { return _repeat; }
		public function set repeat( value:Boolean ):void { _repeat = value; }
		private var _repeat:Boolean = false;
		
		/*======================================================================*//**
		 * ExDisplayObjectContainer インスタンスを取得します。
		 */
		private var _exDisplayObject:ExDisplayObjectContainer;
		
		/*======================================================================*//**
		 * 1 つ前のフレーム番号を取得します。
		 */
		private var _previousFrameNum:Number = 1;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい ExMovieClip インスタンスを作成します。</p>
		 * <p>Creates a new ExMovieClip object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function ExMovieClip() {
			// 初期化する
			_isPlaying = ( totalFrames > 1 );
			
			// フレームアクションを挿入する
			addFrameScript( totalFrames - 1, _complete );
			
			// ExDisplayObjectContainer を作成する
			_exDisplayObject = new ExDisplayObjectContainer( this );
			
			// スーパークラスを初期化する
			super();
			
			// ExDisplayObject を初期化する
			_exDisplayObject.nium_internal::initialize( {
				addChild				:super.addChild,
				addChildAt				:super.addChildAt,
				removeChild				:super.removeChild,
				removeChildAt			:super.removeChildAt,
				contains				:super.contains,
				getChildAt				:super.getChildAt,
				getChildByName			:super.getChildByName,
				getChildIndex			:super.getChildIndex,
				swapChildren			:super.swapChildren,
				swapChildrenAt			:super.swapChildrenAt,
				addEventListener		:super.addEventListener,
				removeEventListener		:super.removeEventListener,
				hasEventListener		:super.hasEventListener,
				willTrigger				:super.willTrigger,
				dispatchEvent			:super.dispatchEvent
			} );
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>ムービークリップのタイムライン内で再生ヘッドを移動します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function play():void {
			_isPlaying = ( totalFrames > 1 );
			super.play();
		}
		
		/*======================================================================*//**
		 * <p>ムービークリップ内の再生ヘッドを停止します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function stop():void {
			_isPlaying = false;
			super.stop();
		}
		
		/*======================================================================*//**
		 * <p>ムービークリップの再生状態に応じて、再生もしくは停止します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function switchAtPlaying():void {
			if ( _isPlaying ) {
				stop();
			}
			else {
				play();
			}
		}
		
		/*======================================================================*//**
		 * <p>指定したフレームが存在しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param labelName
		 * 	<p>存在を確認するフレームです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>存在していれば true 、なければ false です。</p>
		 * 	<p></p>
		 */
		public function hasFrame( frame:* ):Boolean {
			return MovieClipUtil.hasFrame( this, frame );
		}
		
		/*======================================================================*//**
		 * <p>指定されたフレームで SWF ファイルの再生を開始します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param frame
		 * 	<p>再生ヘッドの送り先となるフレーム番号を表す数値、または再生ヘッドの送り先となるフレームのラベルを表すストリングです。数値を指定する場合は、指定するシーンに対する相対数で指定します。シーンを指定しない場合は、再生するグローバルフレーム番号を決定するのに現在のシーンが関連付けられます。シーンを指定した場合、再生ヘッドは指定されたシーン内のフレーム番号にジャンプします。</p>
		 * 	<p></p>
		 * @param scenes
		 * 	<p>再生するシーンの名前です。このパラメータはオプションです。</p>
		 * 	<p></p>
		 */
		public override function gotoAndPlay( frame:Object, scenes:String = null ):void {
			_isPlaying = ( totalFrames > 1 );
			super.gotoAndPlay( frame, scenes );
		}
		
		/*======================================================================*//**
		 * <p>このムービークリップの指定されたフレームに再生ヘッドを送り、そこで停止させます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param frame
		 * 	<p>再生ヘッドの送り先となるフレーム番号を表す数値、または再生ヘッドの送り先となるフレームのラベルを表すストリングです。数値を指定する場合は、指定するシーンに対する相対数で指定します。シーンを指定しない場合は、送り先のグローバルフレーム番号を決定するのに現在のシーンが関連付けられます。シーンを指定した場合、再生ヘッドは指定されたシーン内のフレーム番号に送られて停止します。</p>
		 * 	<p></p>
		 * @param scenes
		 * 	<p>シーン名です。このパラメータはオプションです。</p>
		 * 	<p></p>
		 */
		public override function gotoAndStop( frame:Object, scenes:String = null ):void {
			_isPlaying = false;
			super.gotoAndStop( frame, scenes );
		}
		
		/*======================================================================*//**
		 * <p>次のフレームに再生ヘッドを送り、停止します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function nextFrame():void {
			_isPlaying = false;
			super.nextFrame();
		}
		
		/*======================================================================*//**
		 * <p>直前のフレームに再生ヘッドを戻し、停止します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function prevFrame():void {
			_isPlaying = false;
			super.prevFrame();
		}
		
		/*======================================================================*//**
		 * 最終フレームに到達した際に実行されます。
		 */
		private function _complete():void {
			if ( _repeat ) {
				gotoAndPlay( 1 );
			}
			else {
				gotoAndStop( totalFrames );
			}
		}
		
		/*======================================================================*//**
		 * <p>指定されたスプライトをユーザーがドラッグできるようにします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param lockCenter
		 * 	<p>ドラッグ可能なスプライトが、マウス位置の中心にロックされるか (true)、ユーザーがスプライト上で最初にクリックした点にロックされるか (false) を指定します。</p>
		 * 	<p></p>
		 * @param bounds
		 * 	<p>Sprite の制限矩形を指定する Sprite の親の座標を基準にした相対値です。</p>
		 * 	<p></p>
		 */
		public override function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void {
			_isDragging = true;
			super.startDrag( lockCenter, bounds );
		}
		
		/*======================================================================*//**
		 * <p>startDrag() メソッドを終了します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public override function stopDrag():void {
			_isDragging = false;
			super.stopDrag();
		}
		
		/*======================================================================*//**
		 * <p>指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param id
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getInstanceById( id:String ):DisplayObject {
			return DisplayObject( _exDisplayObject.getInstanceById( id ) );
		}
		
		/*======================================================================*//**
		 * <p>指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param group
		 * 	<p>条件となるストリングです。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByGroup( group, sort );
		}
		
		/*======================================================================*//**
		 * <p>指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param fieldName
		 * 	<p>調査するフィールド名です。</p>
		 * 	<p></p>
		 * @param pattern
		 * 	<p>条件となる正規表現です。</p>
		 * 	<p></p>
		 * @param sort
		 * 	<p>配列をソートするかどうかを指定します。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>条件と一致するインスタンスです。</p>
		 * 	<p></p>
		 */
		public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/*======================================================================*//**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param props
		 * 	<p>設定したいプロパティを含んだオブジェクトです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>設定対象の DisplayObject インスタンスです。</p>
		 * 	<p></p>
		 */
		public function setProperties( props:Object ):DisplayObject {
			return _exDisplayObject.setProperties( props );
		}
		
		/*======================================================================*//**
		 * <p>この DisplayObjectContainer インスタンスに子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @return
		 * 	<p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function addChild( child:DisplayObject ):DisplayObject {
			return _exDisplayObject.addChild( child );
		}
		
		/*======================================================================*//**
		 * <p>この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @param index
		 * 	<p>子を追加するインデックス位置です。</p>
		 * 	<p>The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</p>
		 * @return
		 * 	<p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			return _exDisplayObject.addChildAt( child, index );
		}
		
		/*======================================================================*//**
		 * <p>この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</p>
		 * <p>Adds a child DisplayObject instance to this DisplayObjectContainer instance.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</p>
		 * @param index
		 * 	<p>子を追加するインデックス位置です。</p>
		 * 	<p>The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</p>
		 * @return
		 * 	<p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			return _exDisplayObject.addChildAtAbove( child, index );
		}
		
		/*======================================================================*//**
		 * <p>DisplayObjectContainer インスタンスの子リストから指定の DisplayObject インスタンスを削除します。</p>
		 * <p>Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>対象の DisplayObjectContainer インスタンスの子から削除する DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance to remove.</p>
		 * @return
		 * 	<p>child パラメータで渡す DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance that you pass in the child parameter.</p>
		 */
		public override function removeChild( child:DisplayObject ):DisplayObject {
			return _exDisplayObject.removeChild( child );
		}
		
		/*======================================================================*//**
		 * <p>DisplayObjectContainer の子リストの指定されたインデックス位置から子 DisplayObject インスタンスを削除します。</p>
		 * <p>Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param index
		 * 	<p>削除する DisplayObject の子インデックスです。</p>
		 * 	<p>The child index of the DisplayObject to remove.</p>
		 * @return
		 * 	<p>削除された DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance that was removed.</p>
		 */
		public override function removeChildAt( index:int ):DisplayObject {
			return _exDisplayObject.removeChildAt( index );
		}
		
		/*======================================================================*//**
		 * <p>DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function removeAllChildren():void {
			_exDisplayObject.removeAllChildren();
		}
		
		/*======================================================================*//**
		 * <p>指定された表示オブジェクトが DisplayObjectContainer インスタンスの子であるか、オブジェクト自体であるかを指定します。</p>
		 * <p>Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>テストする子 DisplayObject インスタンスです。</p>
		 * 	<p>The child object to test.</p>
		 * @return
		 * 	<p>child インスタンスが DisplayObjectContainer の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</p>
		 * 	<p>true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false.</p>
		 */
		public override function contains( child:DisplayObject ):Boolean {
			return _exDisplayObject.contains( child );
		}
		
		/*======================================================================*//**
		 * <p>指定のインデックス位置にある子表示オブジェクトオブジェクトを返します。</p>
		 * <p>Returns the child display object instance that exists at the specified index.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param index
		 * 	<p>子 DisplayObject インスタンスのインデックス位置です。</p>
		 * 	<p>The index position of the child object.</p>
		 * @return
		 * 	<p>指定されたインデックス位置にある子 DisplayObject インスタンスです。</p>
		 * 	<p>The child display object at the specified index position.</p>
		 */
		public override function getChildAt( index:int ):DisplayObject {
			return _exDisplayObject.getChildAt( index );
		}
		
		/*======================================================================*//**
		 * <p>指定された名前に一致する子表示オブジェクトを返します。</p>
		 * <p>Returns the child display object that exists with the specified name.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param name
		 * 	<p>返される子 DisplayObject インスタンスの名前です。</p>
		 * 	<p>The name of the child to return.</p>
		 * @return
		 * 	<p>指定された名前を持つ子 DisplayObject インスタンスです。</p>
		 * 	<p>The child display object with the specified name.</p>
		 */
		public override function getChildByName( name:String ):DisplayObject {
			return _exDisplayObject.getChildByName( name );
		}
		
		/*======================================================================*//**
		 * <p>子 DisplayObject インスタンスのインデックス位置を返します。</p>
		 * <p>Returns the index position of a child DisplayObject instance.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>特定する子 DisplayObject インスタンスです。</p>
		 * 	<p>The DisplayObject instance to identify.</p>
		 * @return
		 * 	<p>特定する子 DisplayObject インスタンスのインデックス位置です。</p>
		 * 	<p>The index position of the child display object to identify.</p>
		 */
		public override function getChildIndex( child:DisplayObject ):int {
			return _exDisplayObject.getChildIndex( child );
		}
		
		/*======================================================================*//**
		 * <p>表示オブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing child in the display object container.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>インデックス番号を変更する子 DisplayObject インスタンスです。</p>
		 * 	<p>The child DisplayObject instance for which you want to change the index number.</p>
		 * @param index
		 * 	<p>child インスタンスの結果のインデックス番号です。</p>
		 * 	<p>The resulting index number for the child display object.</p>
		 */
		public override function setChildIndex( child:DisplayObject, index:int ):void {
			_exDisplayObject.setChildIndex( child, index );
		}
		
		/*======================================================================*//**
		 * <p>表示オブジェクトコンテナの既存の子の位置を変更します。</p>
		 * <p>Changes the position of an existing child in the display object container.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child
		 * 	<p>インデックス番号を変更する子 DisplayObject インスタンスです。</p>
		 * 	<p>The child DisplayObject instance for which you want to change the index number.</p>
		 * @param index
		 * 	<p>child インスタンスの結果のインデックス番号です。</p>
		 * 	<p>The resulting index number for the child display object.</p>
		 */
		public function setChildIndexAbove( child:DisplayObject, index:int ):void {
			_exDisplayObject.setChildIndexAbove( child, index );
		}
		
		/*======================================================================*//**
		 * <p>指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the two specified child objects.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param child1
		 * 	<p>先頭の子 DisplayObject インスタンスです。</p>
		 * 	<p>The first child object.</p>
		 * @param child2
		 * 	<p>2 番目の子 DisplayObject インスタンスです。</p>
		 * 	<p>The second child object.</p>
		 */
		public override function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			_exDisplayObject.swapChildren( child1, child2 );
		}
		
		/*======================================================================*//**
		 * <p>子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</p>
		 * <p>Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param index1
		 * 	<p>最初の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * 	<p>The index position of the first child object.</p>
		 * @param index2
		 * 	<p>2 番目の子 DisplayObject インスタンスのインデックス位置です。</p>
		 * 	<p>The index position of the second child object.</p>
		 */
		public override function swapChildrenAt( index1:int, index2:int ):void {
			_exDisplayObject.swapChildrenAt( index1, index2 );
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_exDisplayObject.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーは、IEventIntegrator インスタンスの管理外となるため、removeEventListener() メソッドで削除した場合にも、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * 	<p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * 	<p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * 	<p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * 	<p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * 	<p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * 	<p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_exDisplayObject.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_exDisplayObject.removeEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができません。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param type
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @param listener
		 * 	<p>削除するリスナーオブジェクトです。</p>
		 * 	<p>The listener object to remove.</p>
		 * @param useCapture
		 * 	<p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * 	<p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_exDisplayObject.completelyRemoveEventListener( type, listener, useCapture );
		}
		
		/*======================================================================*//**
		 * <p>イベントをイベントフローに送出します。</p>
		 * <p>Dispatches an event into the event flow.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</p>
		 * 	<p>The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</p>
		 * @return
		 * 	<p>値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</p>
		 * 	<p>A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</p>
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			return _exDisplayObject.dispatchEvent( event );
		}
		
		/*======================================================================*//**
		 * <p>EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</p>
		 * <p>Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type is registered; false otherwise.</p>
		 */
		public override function hasEventListener( type:String ):Boolean {
			return _exDisplayObject.hasEventListener( type );
		}
		
		/*======================================================================*//**
		 * <p>指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</p>
		 * <p>Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param event
		 * 	<p>イベントのタイプです。</p>
		 * 	<p>The type of event.</p>
		 * @return
		 * 	<p>指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</p>
		 * 	<p>A value of true if a listener of the specified type will be triggered; false otherwise.</p>
		 */
		public override function willTrigger( type:String ):Boolean {
			return _exDisplayObject.willTrigger( type );
		}
		
		/*======================================================================*//**
		 * <p>addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param completely
		 * 	<p>情報を完全に削除するかどうかです。</p>
		 * 	<p></p>
		 */
		public function removeAllListeners( completely:Boolean = false ):void {
			_exDisplayObject.removeAllListeners( completely );
		}
		
		/*======================================================================*//**
		 * <p>removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function restoreRemovedListeners():void {
			_exDisplayObject.restoreRemovedListeners();
		}
		
		/*======================================================================*//**
		 * <p>指定されたオブジェクトの BitmapData 表現を返します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param transparent
		 * 	<p>ビットマップイメージがピクセル単位の透明度をサポートするかどうかを指定します。デフォルト値は true です (透明)。完全に透明なビットマップを作成するには、transparent パラメータの値を true に、fillColor パラメータの値を 0x00000000 (または 0) に設定します。transparent プロパティを false に設定すると、レンダリングのパフォーマンスが若干向上することがあります。</p>
		 * 	<p>Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.</p>
		 * @param fillColor
		 * 	<p>ビットマップイメージ領域を塗りつぶすのに使用する 32 ビット ARGB カラー値です。デフォルト値は 0xFFFFFFFF (白) です。</p>
		 * 	<p>A 32-bit ARGB color value that you use to fill the bitmap image area.</p>
		 * @return
		 * 	<p>オブジェクトの BitmapData 表現です。</p>
		 * 	<p>A BitmapData representation of the object.</p>
		 */
		public function toBitmapData( transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF ):BitmapData {
			return _exDisplayObject.toBitmapData( transparent, fillColor );
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
			return _exDisplayObject.toString();
		}
	}
}









