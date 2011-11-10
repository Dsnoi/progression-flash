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
package jp.progression.scenes {
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import jp.nium.core.errors.ErrorMessageConstants;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.XMLUtil;
	import jp.progression.commands.AddChild;
	import jp.progression.commands.AddChildAt;
	import jp.progression.commands.ParallelList;
	import jp.progression.commands.RemoveChild;
	import jp.progression.commands.SerialList;
	import jp.progression.events.SceneEvent;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * <span lang="ja">EasyCastingScene クラスは、拡張された PRML 形式の XML データを使用して ActionScript を使用しないコンポーネントベースの開発スタイルを提供するクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class EasyCastingScene extends SceneObject {
		
		/**
		 * EasyCastingScene が管理しているキャストオブジェクトを格納した Dictionary インスタンスを取得します。
		 */
		private static var _registeringList:Dictionary = new Dictionary();
		
		/**
		 */
		private static var _displayingList:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * <span lang="ja">新しい EasyCastingScene インスタンスを作成します。</span>
		 * <span lang="en">Creates a new EasyCastingScene object.</span>
		 * 
		 * @param name
		 * <span lang="ja">シーンの名前です。</span>
		 * <span lang="en"></span>
		 * @param initObject
		 * <span lang="ja">設定したいプロパティを含んだオブジェクトです。</span>
		 * <span lang="en"></span>
		 */
		public function EasyCastingScene( name:String = null, initObject:Object = null ) {
			// スーパークラスを初期化する
			super( name, initObject );
			
			// 自身がルートであれば
			if ( this == root ) {
				// イベントリスナーを登録する
				addExclusivelyEventListener( SceneEvent.LOAD, _load, false, int.MAX_VALUE, true );
			}
			
			// イベントリスナーを登録する
			addExclusivelyEventListener( SceneEvent.INIT, _init, false, int.MAX_VALUE, true );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">この SceneObject インスタンスに子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @return
		 * <span lang="ja">scene パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public override function addScene( scene:SceneObject ):SceneObject {
			// EasyCastingScene を継承していなければエラーを送出する
			if ( !( scene is EasyCastingScene ) ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9005", "EasyCastingScene" ) ); }
			return super.addScene( scene );
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</span>
		 * @return
		 * <span lang="ja">scene パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public override function addSceneAt( scene:SceneObject, index:int ):SceneObject {
			// EasyCastingScene を継承していなければエラーを送出する
			if ( !( scene is EasyCastingScene ) ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9005", "EasyCastingScene" ) ); }
			return super.addSceneAt( scene, index );
		}
		
		/**
		 * <span lang="ja">この SceneObject インスタンスの指定されたインデックス位置に子 SceneObject インスタンスを追加します。</span>
		 * <span lang="en">Adds a scene SceneObject instance to this SceneObject instance.</span>
		 * 
		 * @param scene
		 * <span lang="ja">対象の SceneObject インスタンスの子として追加する SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance to add as a scene of this SceneObject instance.</span>
		 * @param index
		 * <span lang="ja">子を追加するインデックス位置です。</span>
		 * <span lang="en">The index position to which the scene is added. If you specify a currently occupied index position, the scene object that exists at that position and all higher positions are moved up one position in the scene list.</span>
		 * @return
		 * <span lang="ja">scene パラメータで渡す SceneObject インスタンスです。</span>
		 * <span lang="en">The SceneObject instance that you pass in the scene parameter.</span>
		 */
		public override function addSceneAtAbove( scene:SceneObject, index:int ):SceneObject {
			// EasyCastingScene を継承していなければエラーを送出する
			if ( !( scene is EasyCastingScene ) ) { throw new IllegalOperationError( ErrorMessageConstants.getMessage( "ERROR_9005", "EasyCastingScene" ) ); }
			return super.addSceneAtAbove( scene, index );
		}
		
		
		
		
		
		/**
		 * 表示オブジェクトの登録情報を更新する
		 */
		private function _load( e:SceneEvent ):void {
			// ルート以下の XML 構造を取得する
			var xml:XML = new XML( toXMLString() );
			
			// 表示オブジェクトの登録情報を更新する
			for each ( var cast:XML in xml..cast ) {
				// クラスパスを取得する
				var cls:String = String( cast.attribute( "cls" ) );
				
				// すでに表示オブジェクトが存在していれば次へ
				if ( _registeringList[cls] ) { continue; }
				
				// cls をクラスに変換する
				var classRef:Class = getDefinitionByName( cls ) as Class;
				
				// インスタンス化する
				var instance:Sprite = new classRef() as Sprite;
				
				// Sprite を継承していなければエラーを送出する
				if ( !instance ) { throw new IllegalOperationError( cls + " は Sprite クラスを継承している必要があります。" ); }
				
				// 表示オブジェクトを登録する
				_registeringList[cls] = instance;
			}
		}
		
		
		
		
		
		/**
		 * シーンオブジェクトが目的地だった場合に、到達した瞬間に送出されます。
		 */
		private function _init( e:SceneEvent ):void {
			// 自身に関連付けられている表示オブジェクトリストを作成する
			var casts:Dictionary = new Dictionary();
			for each ( var cast:XML in sceneInfo.data ) {
				// ノード名が違っていれば次へ
				if ( cast.name() != "cast" ) { continue; }
				
				// クラスパスを取得する
				var cls:String = String( cast.attribute( "cls" ) );
				
				// リストに登録する
				casts[cls] = cast;
			}
			
			// コマンドリストを作成する
			var addChildList:ParallelList = new ParallelList();
			var removeChildList:ParallelList = new ParallelList();
			
			// すでに表示中のオブジェクトで、関連付けられていないものが存在すれば削除する
			for ( var cls2:String in _displayingList ) {
				// 存在すれば次へ
				if ( casts[cls2] ) { continue; }
				
				// コマンドを追加する
				removeChildList.addCommand( new RemoveChild( progression.container, _displayingList[cls2] ) );
				
				// 登録から削除する
				delete _displayingList[cls2];
			}
			
			// すでに表示中のオブジェクトで、関連付けられていないものが存在すれば削除する
			for ( var cls3:String in casts ) {
				// インスタンスを取得する
				var instance:Sprite = _registeringList[cls3];
				cast = casts[cls3];
				
				// プロパティを設定する
				ObjectUtil.setProperties( instance, XMLUtil.xmlToObject( cast.attributes() ) );
				
				// インデックスを取得する
				var index:String = String( cast.attribute( "index" ) );
				
				// コマンドを追加する
				if ( index ) {
					addChildList.addCommand( new AddChildAt( progression.container, instance, parseInt( index ) ) );
				}
				else {
					addChildList.addCommand( new AddChild( progression.container, instance ) );
				}
				
				// リストに登録する
				_displayingList[cls3] = instance;
			}
			
			// コマンドを追加する
			addCommand(
				new SerialList( null,
					removeChildList,
					addChildList
				)
			);
		}
	}
}
