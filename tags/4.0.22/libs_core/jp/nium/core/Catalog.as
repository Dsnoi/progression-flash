/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 4.0.22
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.core {
	import jp.nium.collections.IdGroupCollection;
	import jp.nium.collections.IIdGroup;
	import jp.nium.collections.UniqueList;
	import jp.nium.core.debug.Log;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.I18N.Locale;
	import jp.nium.core.impls.IExDisplayObject;
	import jp.nium.core.impls.IExDisplayObjectContainer;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.primitives.NumberObject;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.display.BitmapFill;
	import jp.nium.display.ChildIndexer;
	import jp.nium.display.ChildIterator;
	import jp.nium.display.ExBitmap;
	import jp.nium.display.ExDocument;
	import jp.nium.display.ExImageLoader;
	import jp.nium.display.ExImageLoaderAlign;
	import jp.nium.display.ExImageLoaderRatio;
	import jp.nium.display.ExLoader;
	import jp.nium.display.ExMovieClip;
	import jp.nium.display.ExSprite;
	import jp.nium.display.getInstanceById;
	import jp.nium.display.getInstancesByGroup;
	import jp.nium.events.CollectionEvent;
	import jp.nium.events.DynamicEvent;
	import jp.nium.events.EventAggregater;
	import jp.nium.events.EventIntegrator;
	import jp.nium.events.ExEvent;
	import jp.nium.events.ModelEvent;
	import jp.nium.external.COREX;
	import jp.nium.external.JavaScript;
	import jp.nium.external.JSFL;
	import jp.nium.external.JSFLBrowseType;
	import jp.nium.impls.IDisplayObject;
	import jp.nium.impls.IDisplayObjectContainer;
	import jp.nium.impls.IInteractiveObject;
	import jp.nium.impls.ITextField;
	import jp.nium.models.Model;
	import jp.nium.net.Query;
	import jp.nium.Nium;
	import jp.nium.text.ExTextField;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.DateUtil;
	import jp.nium.utils.GraphicUtil;
	import jp.nium.utils.MathUtil;
	import jp.nium.utils.MovieClipUtil;
	import jp.nium.utils.NumberUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StageUtil;
	import jp.nium.utils.StringUtil;
	import jp.nium.utils.TextFieldUtil;
	import jp.nium.utils.URLUtil;
	import jp.nium.utils.Version;
	import jp.nium.utils.XMLUtil;
	
	/**
	 * @private
	 */
	public final class Catalog {
		
		/**
		 * @private
		 */
		public function Catalog() {
			Nium;
			IdGroupCollection, IIdGroup, UniqueList;
			Log, Logger;
			IExDisplayObject, IExDisplayObjectContainer;
			Locale;
			L10NNiumMsg;
			NumberObject, StringObject;
			BitmapFill, ChildIndexer, ChildIterator, ExBitmap, ExDocument, ExImageLoader, ExImageLoaderAlign, ExImageLoaderRatio, ExLoader, ExMovieClip, ExSprite, getInstanceById, getInstancesByGroup;
			CollectionEvent, DynamicEvent, EventAggregater, EventIntegrator, ExEvent, ModelEvent;
			COREX, JavaScript, JSFL, JSFLBrowseType;
			IDisplayObject, IDisplayObjectContainer, IInteractiveObject, ITextField;
			Model;
			Query;
			ExTextField;
			ArrayUtil, ClassUtil, DateUtil, GraphicUtil, MathUtil, MovieClipUtil, NumberUtil, ObjectUtil, StageUtil, StringUtil, TextFieldUtil, URLUtil, Version, XMLUtil;
			
			
			throw new Error( Logger.getLog( L10NNiumMsg.getInstance().ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
