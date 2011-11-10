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
package jp.progression.loader {
	import flash.display.Stage;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import jp.nium.net.ExURLLoader;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.XMLUtil;
	import jp.progression.core.debug.Verbose;
	import jp.progression.core.debug.VerboseMessageConstants;
	import jp.progression.core.namespaces.progression_internal;
	import jp.progression.core.parser.PRMLParser;
	import jp.progression.Progression;
	import jp.progression.scenes.SceneObject;
	
	use namespace progression_internal;
	
	/*======================================================================*//**
	 * <p>PRMLLoader クラスは、読み込んだ PRML 形式の XML ファイルから自動的に、Progression インスタンスを作成するローダークラスです。</p>
	 * <p></p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0.45.0
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public class PRMLLoader extends ExURLLoader {
		
		/*======================================================================*//**
		 * <p>読み込んだ XML データの情報を元に作成された Progression インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get progression():Progression { return _progression; }
		private var _progression:Progression;
		
		/*======================================================================*//**
		 * <p>関連付けられている Stage インスタンスを取得します。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get stage():Stage { return _stage; }
		private var _stage:Stage;
		
		/*======================================================================*//**
		 * <p>ブラウザ上でコンテンツを実行している場合に、URL と Progression インスタンスのシーンを同期させるかどうかを取得または設定します。
		 * 同一コンテンツ上で有効化できる Progression インスタンスは 1 つのみであり、複数に対して有効化を試みた場合、最後に有効化された Progression インスタンス以外の sync プロパティは自動的に false に設定されます。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get sync():Boolean { return _sync; }
		public function set sync( value:Boolean ):void {
			_sync = value;
			
			// Progression が存在していれば
			if ( _progression ) {
				_progression.sync = value;
			}
		}
		private var _sync:Boolean = true;
		
		/*======================================================================*//**
		 * <p>コマンド処理を実行中に lock プロパティの値を自動的に有効化するかどうかを設定または取得します。
		 * この設定が有効である場合には、コマンド処理が開始されると lock プロパティが true に、処理完了後に false となります。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 */
		public function get autoLock():Boolean { return _autoLock; }
		public function set autoLock( value:Boolean ):void {
			_autoLock = value;
			
			// Progression が存在していれば
			if ( _progression ) {
				_progression.autoLock = value;
			}
		}
		private var _autoLock:Boolean = true;
		
		
		
		
		
		/*======================================================================*//**
		 * <p>新しい PRMLLoader インスタンスを作成します。</p>
		 * <p>Creates a new PRMLLoader object.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param stage
		 * 	<p>関連付けたい Stage インスタンスです。</p>
		 * 	<p></p>
		 * @param request
		 * 	<p>ダウンロードする URL を指定する URLRequest オブジェクトです。このパラメータを省略すると、ロード操作は開始されません。指定すると、直ちにロード操作が開始されます。詳細については、load を参照してください。</p>
		 * 	<p></p>
		 */
		public function PRMLLoader( stage:Stage, request:URLRequest = null ) {
			// 引数を設定する
			_stage = stage;
			
			// スーパークラスを初期化する
			super( request );
			
			// クラスをコンパイルに含める
			SceneObject;
		}
		
		
		
		
		
		/*======================================================================*//**
		 * <p>データをパースします。</p>
		 * <p></p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.45.0
		 * 
		 * @param data
		 * 	<p>パースしたいデータです。</p>
		 * 	<p></p>
		 * @return
		 * 	<p>パース後のデータです。</p>
		 * 	<p></p>
		 */
		public override function parse( data:* ):* {
			// パースする
			var parser:PRMLParser = new PRMLParser( new XML( data ) );
			var scenes:XMLList = parser.scenes;
			
			// ルートシーンの情報を取得する
			var root:XML = XML( scenes[0] );
			var rootName:String = String( root.attribute( "name" ) );
			var rootCls:Class = getDefinitionByName( String( root.attribute( "cls" ) ) ) as Class;
			
			// Progression を作成する
			_progression = new Progression( rootName, _stage, rootCls );
			_progression.sync = _sync;
			_progression.autoLock = _autoLock;
			
			// ルートシーンを初期化する
			var o:Object = XMLUtil.xmlToObject( root.attributes() );
			_progression.root.setProperties( root.attributes().( name() != "name" ) );
			_progression.root.sceneInfo.progression_internal::__data = root.children().( name() != "scene" );
			
			// ルートシーン以下を作成する
			_progression.root.addSceneFromXML( parser.toPRMLString( root.child( "scene" ) ) );
			
			// ログを出力する
			Verbose.log( this, VerboseMessageConstants.getMessage( "VERBOSE_0015", url, _progression.root.toXMLString() ), true );
			
			// 初期シーンに移動する
			_progression.goto( _progression.firstSceneId );
			
			return data;
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
			return "[object PRMLLoader]";
		}
	}
}









