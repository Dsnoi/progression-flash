/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.82
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2010 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
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
	
	/**
	 * <span lang="ja">ExMovieClip クラスは、MovieClip クラスの基本機能を拡張した jp.nium パッケージで使用される基本的な表示オブジェクトクラスです。</span>
	 * <span lang="en">ExMovieClip class is a basic display object class used at jp.nium package which extends the basic function of MovieClip class.</span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class ExMovieClip extends MovieClip implements IExDisplayObjectContainer, IEventIntegrator {
		
		/**
		 * <span lang="ja">インスタンスのクラス名を取得します。</span>
		 * <span lang="en">Indicates the instance className of the IExDisplayObject.</span>
		 */
		public function get className():String { return _exDisplayObject.className; }
		
		/**
		 * <span lang="ja">インスタンスの識別子を取得または設定します。</span>
		 * <span lang="en">Indicates the instance id of the IExDisplayObject.</span>
		 */
		public function get id():String { return _exDisplayObject.id; }
		public function set id( value:String ):void { _exDisplayObject.id = value; }
		
		/**
		 * <span lang="ja">インスタンスのグループ名を取得または設定します。</span>
		 * <span lang="en">Indicates the instance group of the IExDisplayObject.</span>
		 */
		public function get group():String { return _exDisplayObject.group; }
		public function set group( value:String ):void { _exDisplayObject.group = value; }
		
		/**
		 * <span lang="ja">子ディスプレイオブジェクトが保存されている配列です。
		 * インデックス値が断続的に指定可能である為、getChildAt() ではなくこのプロパティを使用して子ディスプレイオブジェクト走査を行います。
		 * この配列を操作することで元の配列を変更することはできません。</span>
		 * <span lang="en">The array that saves child display objects.
		 * Because the index value can specify intermittently, it scans the child display object by not using getChildAt() but using this property.
		 * It can not change the original array by operating this array.</span>
		 */
		public function get children():Array { return _exDisplayObject.children; }
		
		/**
		 * <span lang="ja">startDrag() メソッドを使用したドラッグ処理を行っている最中かどうかを取得します。</span>
		 * <span lang="en">Returns if the drag process which uses startDrag() method is executing.</span>
		 */
		public function get isDragging():Boolean { return _isDragging; }
		private var _isDragging:Boolean = false;
		
		/**
		 * <span lang="ja">ムービークリップのタイムライン内で再生ヘッドの移動処理が行われているかどうかを取得します。</span>
		 * <span lang="en">Returns if the movement processing of the playback head is executing in the timeline of the MovieClip.</span>
		 */
		public function get isPlaying():Boolean { return _isPlaying; }
		private var _isPlaying:Boolean = false;
		
		/**
		 * <span lang="ja">ムービークリップの再生ヘッドが最後のフレームに移動された後に、最初のフレームに戻って再生を続けるかどうかを取得または設定します。</span>
		 * <span lang="en">Get or set if it returns to the first frame and continue playback when the playback head reach to the last frame.</span>
		 */
		public function get repeat():Boolean { return _repeat; }
		public function set repeat( value:Boolean ):void { _repeat = value; }
		private var _repeat:Boolean = false;
		
		/**
		 * ExDisplayObjectContainer インスタンスを取得します。
		 */
		private var _exDisplayObject:ExDisplayObjectContainer;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい ExMovieClip インスタンスを作成します。</span>
		 * <span lang="en">Creates a new ExMovieClip object.</span>
		 */
		public function ExMovieClip() {
			// 初期化する
			_isPlaying = Boolean( totalFrames > 1 );
			
			// フレームアクションを挿入する
			if ( totalFrames != 1 ) {
				addFrameScript( totalFrames - 1, _complete );
			}
			
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
				setChildIndex			:super.setChildIndex,
				swapChildren			:super.swapChildren,
				swapChildrenAt			:super.swapChildrenAt,
				addEventListener		:super.addEventListener,
				removeEventListener		:super.removeEventListener,
				hasEventListener		:super.hasEventListener,
				willTrigger				:super.willTrigger,
				dispatchEvent			:super.dispatchEvent
			} );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">ムービークリップのタイムライン内で再生ヘッドを移動します。</span>
		 * <span lang="en">Moves the playback head in the timeline of the MovieClip.</span>
		 */
		public override function play():void {
			_isPlaying = Boolean( totalFrames > 1 );
			super.play();
		}
		
		/**
		 * <span lang="ja">ムービークリップ内の再生ヘッドを停止します。</span>
		 * <span lang="en">Stops the playback head in the MovieClip.</span>
		 */
		public override function stop():void {
			_isPlaying = false;
			super.stop();
		}
		
		/**
		 * <span lang="ja">ムービークリップの再生状態に応じて、再生もしくは停止します。</span>
		 * <span lang="en">Playback or stops according to the playback state of the MovieClip.</span>
		 */
		public function switchAtPlaying():void {
			if ( _isPlaying ) {
				stop();
			}
			else {
				play();
			}
		}
		
		/**
		 * <span lang="ja">指定したフレームが存在しているかどうかを返します。</span>
		 * <span lang="en">Returns if the specified frame exists.</span>
		 * 
		 * @param labelName
		 * <span lang="ja">存在を確認するフレームです。</span>
		 * <span lang="en">The frame to check.</span>
		 * @return
		 * <span lang="ja">存在していれば true 、なければ false です。</span>
		 * <span lang="en">If exists return true, otherwise return false.</span>
		 */
		public function hasFrame( frame:* ):Boolean {
			return Boolean( MovieClipUtil.hasFrame( this, frame ) );
		}
		
		/**
		 * <span lang="ja">指定されたフレームで SWF ファイルの再生を開始します。</span>
		 * <span lang="en">Start the playback of the SWF file with the specified frame.</span>
		 * 
		 * @param frame
		 * <span lang="ja">再生ヘッドの送り先となるフレーム番号を表す数値、または再生ヘッドの送り先となるフレームのラベルを表すストリングです。数値を指定する場合は、指定するシーンに対する相対数で指定します。シーンを指定しない場合は、再生するグローバルフレーム番号を決定するのに現在のシーンが関連付けられます。シーンを指定した場合、再生ヘッドは指定されたシーン内のフレーム番号にジャンプします。</span>
		 * <span lang="en">The frame number or the frame name to move the playback head. When specify by frame count, specify the relative number to the specified scene. When do not specify the scene, the current scene will relate to decide the grobal frame number to playback. When specify the scene, the plyback head will jump to the frame number in specified scene.</span>
		 * @param scenes
		 * <span lang="ja">再生するシーンの名前です。このパラメータはオプションです。</span>
		 * <span lang="en">The name of the scene to playback. This parameter is optinal.</span>
		 */
		public override function gotoAndPlay( frame:Object, scenes:String = null ):void {
			_isPlaying = Boolean( totalFrames > 1 );
			super.gotoAndPlay( frame, scenes );
		}
		
		/**
		 * <span lang="ja">このムービークリップの指定されたフレームに再生ヘッドを送り、そこで停止させます。</span>
		 * <span lang="en">Set the palyback head to the specified frame of the MovieClip and stop at that point.</span>
		 * 
		 * @param frame
		 * <span lang="ja">再生ヘッドの送り先となるフレーム番号を表す数値、または再生ヘッドの送り先となるフレームのラベルを表すストリングです。数値を指定する場合は、指定するシーンに対する相対数で指定します。シーンを指定しない場合は、送り先のグローバルフレーム番号を決定するのに現在のシーンが関連付けられます。シーンを指定した場合、再生ヘッドは指定されたシーン内のフレーム番号に送られて停止します。</span>
		 * <span lang="en">The frame number or the frame name to move the playback head. When specify by frame count, specify the relative number to the specified scene. When do not specify the scene, the current scene will relate to decide the grobal frame number to playback. When specify the scene, the plyback head will jump to the frame number in specified scene.</span>
		 * @param scenes
		 * <span lang="ja">シーン名です。このパラメータはオプションです。</span>
		 * <span lang="en">The name of the scene to playback. This parameter is optinal.</span>
		 */
		public override function gotoAndStop( frame:Object, scenes:String = null ):void {
			_isPlaying = false;
			super.gotoAndStop( frame, scenes );
		}
		
		/**
		 * <span lang="ja">次のフレームに再生ヘッドを送り、停止します。</span>
		 * <span lang="en">Move the playback head to the next frame and stop at that point.</span>
		 */
		public override function nextFrame():void {
			_isPlaying = false;
			super.nextFrame();
		}
		
		/**
		 * <span lang="ja">直前のフレームに再生ヘッドを戻し、停止します。</span>
		 * <span lang="en">Move the playback head to the previous frame and stop at that point.</span>
		 */
		public override function prevFrame():void {
			_isPlaying = false;
			super.prevFrame();
		}
		
		/**
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
		
		/**
		 * <span lang="ja">指定されたスプライトをユーザーがドラッグできるようにします。</span>
		 * <span lang="en">Allow the user to drag the specified sprite.</span>
		 * 
		 * @param lockCenter
		 * <span lang="ja">ドラッグ可能なスプライトが、マウス位置の中心にロックされるか (true)、ユーザーがスプライト上で最初にクリックした点にロックされるか (false) を指定します。</span>
		 * <span lang="en">Specify the sprite which will be able to drag locks at the center of the mouse position(true) or the first point that the user clicked on the sprite(false).</span>
		 * @param bounds
		 * <span lang="ja">Sprite の制限矩形を指定する Sprite の親の座標を基準にした相対値です。</span>
		 * <span lang="en">Specify the limitation rectangle of the sprite. It is a relative value based on parents' coordinates of the sprite.</span>
		 */
		public override function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void {
			_isDragging = true;
			super.startDrag( lockCenter, bounds );
		}
		
		/**
		 * <span lang="ja">startDrag() メソッドを終了します。</span>
		 * <span lang="en">Ends the startDrag() method.</span>
		 */
		public override function stopDrag():void {
			_isDragging = false;
			super.stopDrag();
		}
		
		/**
		 * <span lang="ja">指定された id と同じ値が設定されている IExDisplayObject インターフェイスを実装したインスタンスを返します。</span>
		 * <span lang="en">Returns the instance implements the IExDisplayObject interface which is set the same value of the specified id.</span>
		 * 
		 * @param id
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en">The string that becomes a condition.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstanceById( id:String ):DisplayObject {
			return DisplayObject( _exDisplayObject.getInstanceById( id ) );
		}
		
		/**
		 * <span lang="ja">指定された group と同じ値を持つ IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that has the same value of the specified group.</span>
		 * 
		 * @param group
		 * <span lang="ja">条件となるストリングです。</span>
		 * <span lang="en">The string that becomes a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstancesByGroup( group:String, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByGroup( group, sort );
		}
		
		/**
		 * <span lang="ja">指定された fieldName が条件と一致する IExDisplayObject インターフェイスを実装したインスタンスを含む配列を返します。</span>
		 * <span lang="en">Returns the array contains the instance which implements the IExDisplayObject interface that match the condition to the specified fieldName.</span>
		 * 
		 * @param fieldName
		 * <span lang="ja">調査するフィールド名です。</span>
		 * <span lang="en">The field name to check.</span>
		 * @param pattern
		 * <span lang="ja">条件となる正規表現です。</span>
		 * <span lang="en">The regular expression to become a condition.</span>
		 * @param sort
		 * <span lang="ja">配列をソートするかどうかを指定します。</span>
		 * <span lang="en">Specify if it sorts the array.</span>
		 * @return
		 * <span lang="ja">条件と一致するインスタンスです。</span>
		 * <span lang="en">The instance match to the condition.</span>
		 */
		public function getInstancesByRegExp( fieldName:String, pattern:RegExp, sort:Boolean = false ):Array {
			return _exDisplayObject.getInstancesByRegExp( fieldName, pattern, sort );
		}
		
		/**
		 * <span lang="ja">インスタンスに対して、複数のプロパティを一括設定します。</span>
		 * <span lang="en">Setup the several instance properties.</span>
		 * 
		 * @param props
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en">The object that contains the property to setup.</span>
		 * @return
		 * <span lang="ja">設定対象の DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to setup.</span>
		 */
		public function setProperties( props:Object ):DisplayObject {
			return _exDisplayObject.setProperties( props );
		}
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスに子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		public override function addChild( child:DisplayObject ):DisplayObject {
			return _exDisplayObject.addChild( child );
		}
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		public override function addChildAt( child:DisplayObject, index:int ):DisplayObject {
			return _exDisplayObject.addChildAt( child, index );
		}
		
		/**
		 * <span lang="ja">この DisplayObjectContainer インスタンスの指定されたインデックス位置に子 DisplayObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a child DisplayObject instance to this DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子として追加する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to add as a child of this DisplayObjectContainer instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		public function addChildAtAbove( child:DisplayObject, index:int ):DisplayObject {
			return _exDisplayObject.addChildAtAbove( child, index );
		}
		
		/**
		 * <span lang="ja">DisplayObjectContainer インスタンスの子リストから指定の DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">対象の DisplayObjectContainer インスタンスの子から削除する DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to remove.</span>
		 * @return
		 * <span lang="ja">child パラメータで渡す DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that you pass in the child parameter.</span>
		 */
		public override function removeChild( child:DisplayObject ):DisplayObject {
			return _exDisplayObject.removeChild( child );
		}
		
		/**
		 * <span lang="ja">DisplayObjectContainer の子リストの指定されたインデックス位置から子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.</span>
		 * 
		 * @param index
		 * <span lang="ja">削除する DisplayObject の子インデックスです。</span>
		 * <span lang="en">The child index of the DisplayObject to remove.</span>
		 * @return
		 * <span lang="ja">削除された DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance that was removed.</span>
		 */
		public override function removeChildAt( index:int ):DisplayObject {
			return _exDisplayObject.removeChildAt( index );
		}
		
		/**
		 * <span lang="ja">DisplayObjectContainer に追加されている全ての子 DisplayObject インスタンスを削除します。</span>
		 * <span lang="en">Removes the whole child DisplayObject instance added to the DisplayObjectContainer.</span>
		 */
		public function removeAllChildren():void {
			_exDisplayObject.removeAllChildren();
		}
		
		/**
		 * <span lang="ja">指定された表示オブジェクトが DisplayObjectContainer インスタンスの子であるか、オブジェクト自体であるかを指定します。</span>
		 * <span lang="en">Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.</span>
		 * 
		 * @param child
		 * <span lang="ja">テストする子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child object to test.</span>
		 * @return
		 * <span lang="ja">child インスタンスが DisplayObjectContainer の子であるか、コンテナ自体である場合は true となります。そうでない場合は false となります。</span>
		 * <span lang="en">true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false.</span>
		 */
		public override function contains( child:DisplayObject ):Boolean {
			return _exDisplayObject.contains( child );
		}
		
		/**
		 * <span lang="ja">指定のインデックス位置にある子表示オブジェクトオブジェクトを返します。</span>
		 * <span lang="en">Returns the child display object instance that exists at the specified index.</span>
		 * 
		 * @param index
		 * <span lang="ja">子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the child object.</span>
		 * @return
		 * <span lang="ja">指定されたインデックス位置にある子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child display object at the specified index position.</span>
		 */
		public override function getChildAt( index:int ):DisplayObject {
			return _exDisplayObject.getChildAt( index );
		}
		
		/**
		 * <span lang="ja">指定された名前に一致する子表示オブジェクトを返します。</span>
		 * <span lang="en">Returns the child display object that exists with the specified name.</span>
		 * 
		 * @param name
		 * <span lang="ja">返される子 DisplayObject インスタンスの名前です。</span>
		 * <span lang="en">The name of the child to return.</span>
		 * @return
		 * <span lang="ja">指定された名前を持つ子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child display object with the specified name.</span>
		 */
		public override function getChildByName( name:String ):DisplayObject {
			return _exDisplayObject.getChildByName( name );
		}
		
		/**
		 * <span lang="ja">子 DisplayObject インスタンスのインデックス位置を返します。</span>
		 * <span lang="en">Returns the index position of a child DisplayObject instance.</span>
		 * 
		 * @param child
		 * <span lang="ja">特定する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The DisplayObject instance to identify.</span>
		 * @return
		 * <span lang="ja">特定する子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the child display object to identify.</span>
		 */
		public override function getChildIndex( child:DisplayObject ):int {
			return _exDisplayObject.getChildIndex( child );
		}
		
		/**
		 * <span lang="ja">表示オブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing child in the display object container.</span>
		 * 
		 * @param child
		 * <span lang="ja">インデックス番号を変更する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child DisplayObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the child display object.</span>
		 */
		public override function setChildIndex( child:DisplayObject, index:int ):void {
			_exDisplayObject.setChildIndex( child, index );
		}
		
		/**
		 * <span lang="ja">表示オブジェクトコンテナの既存の子の位置を変更します。</span>
		 * <span lang="en">Changes the position of an existing child in the display object container.</span>
		 * 
		 * @param child
		 * <span lang="ja">インデックス番号を変更する子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The child DisplayObject instance for which you want to change the index number.</span>
		 * @param index
		 * <span lang="ja">child インスタンスの結果のインデックス番号です。</span>
		 * <span lang="en">The resulting index number for the child display object.</span>
		 */
		public function setChildIndexAbove( child:DisplayObject, index:int ):void {
			_exDisplayObject.setChildIndexAbove( child, index );
		}
		
		/**
		 * <span lang="ja">指定された 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the two specified child objects.</span>
		 * 
		 * @param child1
		 * <span lang="ja">先頭の子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The first child object.</span>
		 * @param child2
		 * <span lang="ja">2 番目の子 DisplayObject インスタンスです。</span>
		 * <span lang="en">The second child object.</span>
		 */
		public override function swapChildren( child1:DisplayObject, child2:DisplayObject ):void {
			_exDisplayObject.swapChildren( child1, child2 );
		}
		
		/**
		 * <span lang="ja">子リスト内の指定されたインデックス位置に該当する 2 つの子オブジェクトの z 順序（重ね順）を入れ替えます。</span>
		 * <span lang="en">Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.</span>
		 * 
		 * @param index1
		 * <span lang="ja">最初の子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the first child object.</span>
		 * @param index2
		 * <span lang="ja">2 番目の子 DisplayObject インスタンスのインデックス位置です。</span>
		 * <span lang="en">The index position of the second child object.</span>
		 */
		public override function swapChildrenAt( index1:int, index2:int ):void {
			_exDisplayObject.swapChildrenAt( index1, index2 );
		}
		
		/**
		 * <span lang="ja">イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Register the event listener object into the EventIntegrator instance to get the event notification.
		 * If the registered listener by this method removed by using removeEventListener() method, it can re-register using restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en">The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en">Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en">The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</span>
		 * @param useWeakReference
		 * <span lang="ja">リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</span>
		 * <span lang="en">Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</span>
		 */
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_exDisplayObject.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <span lang="ja">イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーは、IEventIntegrator インスタンスの管理外となるため、removeEventListener() メソッドで削除した場合にも、restoreRemovedListeners() メソッドで再登録させることができません。</span>
		 * <span lang="en">Register the event listener object into the EventIntegrator instance to get the event notification.
		 * The listener registered by this method can not re-registered by using restoreRemovedListeners() method in case it is removed by using removeEventListener() method, because it is not managed by IEventIntegrator instance</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en">The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en">Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en">The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</span>
		 * @param useWeakReference
		 * <span lang="ja">リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</span>
		 * <span lang="en">Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</span>
		 */
		public function addExclusivelyEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_exDisplayObject.addExclusivelyEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can re-register by restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 */
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_exDisplayObject.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができません。</span>
		 * <span lang="en">Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can not re-register by restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 */
		public function completelyRemoveEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_exDisplayObject.completelyRemoveEventListener( type, listener, useCapture );
		}
		
		/**
		 * <span lang="ja">イベントをイベントフローに送出します。</span>
		 * <span lang="en">Dispatches an event into the event flow.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</span>
		 * <span lang="en">The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</span>
		 * @return
		 * <span lang="ja">値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</span>
		 * <span lang="en">A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</span>
		 */
		public override function dispatchEvent( event:Event ):Boolean {
			return _exDisplayObject.dispatchEvent( event );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</span>
		 * <span lang="en">Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type is registered; false otherwise.</span>
		 */
		public override function hasEventListener( type:String ):Boolean {
			return _exDisplayObject.hasEventListener( type );
		}
		
		/**
		 * <span lang="ja">指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</span>
		 * <span lang="en">Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type will be triggered; false otherwise.</span>
		 */
		public override function willTrigger( type:String ):Boolean {
			return _exDisplayObject.willTrigger( type );
		}
		
		/**
		 * <span lang="ja">addEventListener() メソッド経由で登録された全てのイベントリスナー登録を削除します。
		 * 完全に登録を削除しなかった場合には、削除されたイベントリスナーを restoreRemovedListeners() メソッドで復帰させることができます。</span>
		 * <span lang="en">Remove the whole event listener registered via addEventListener() method.
		 * If do not remove completely, removed event listener can restore by restoreRemovedListeners() method.</span>
		 * 
		 * @param completely
		 * <span lang="ja">情報を完全に削除するかどうかです。</span>
		 * <span lang="en">If it removes the information completely.</span>
		 */
		public function removeAllListeners( completely:Boolean = false ):void {
			_exDisplayObject.removeAllListeners( completely );
		}
		
		/**
		 * <span lang="ja">removeEventListener() メソッド、または removeAllListeners() メソッド経由で削除された全てイベントリスナーを再登録します。</span>
		 * <span lang="en">Re-register the whole event listener removed via removeEventListener() or removeAllListeners() method.</span>
		 */
		public function restoreRemovedListeners():void {
			_exDisplayObject.restoreRemovedListeners();
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの BitmapData 表現を返します。</span>
		 * <span lang="en">Returns the BitmapData representation of the specified object.</span>
		 * 
		 * @param transparent
		 * <span lang="ja">ビットマップイメージがピクセル単位の透明度をサポートするかどうかを指定します。デフォルト値は true です (透明)。完全に透明なビットマップを作成するには、transparent パラメータの値を true に、fillColor パラメータの値を 0x00000000 (または 0) に設定します。transparent プロパティを false に設定すると、レンダリングのパフォーマンスが若干向上することがあります。</span>
		 * <span lang="en">Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.</span>
		 * @param fillColor
		 * <span lang="ja">ビットマップイメージ領域を塗りつぶすのに使用する 32 ビット ARGB カラー値です。デフォルト値は 0xFFFFFFFF (白) です。</span>
		 * <span lang="en">A 32-bit ARGB color value that you use to fill the bitmap image area.</span>
		 * @return
		 * <span lang="ja">オブジェクトの BitmapData 表現です。</span>
		 * <span lang="en">A BitmapData representation of the object.</span>
		 */
		public function toBitmapData( transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF ):BitmapData {
			return _exDisplayObject.toBitmapData( transparent, fillColor );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public override function toString():String {
			return _exDisplayObject.toString();
		}
	}
}
