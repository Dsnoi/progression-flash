/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 4.0.22
 * @see http://progression.jp/
 * 
 * Progression Libraries is dual licensed under the "Progression Library License" and "GPL".
 * http://progression.jp/license
 */
package jp.progression.core {
	import jp.nium.core.Catalog;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.progression.ActivatedLicenseType;
	import jp.progression.casts.animation.InOutMovie;
	import jp.progression.casts.buttons.AnchorButton;
	import jp.progression.casts.buttons.NextButton;
	import jp.progression.casts.buttons.ParentButton;
	import jp.progression.casts.buttons.PreviousButton;
	import jp.progression.casts.buttons.RollOverButton;
	import jp.progression.casts.buttons.RootButton;
	import jp.progression.casts.CastBitmap;
	import jp.progression.casts.CastButton;
	import jp.progression.casts.CastButtonState;
	import jp.progression.casts.CastButtonWindowTarget;
	import jp.progression.casts.CastDocument;
	import jp.progression.casts.CastImageLoader;
	import jp.progression.casts.CastImageLoaderAlign;
	import jp.progression.casts.CastImageLoaderRatio;
	import jp.progression.casts.CastLoader;
	import jp.progression.casts.CastMovieClip;
	import jp.progression.casts.CastObject;
	import jp.progression.casts.CastPreloader;
	import jp.progression.casts.CastSprite;
	import jp.progression.casts.CastTextField;
	import jp.progression.casts.CastTimeline;
	import jp.progression.casts.effects.BlindsEffect;
	import jp.progression.casts.effects.EffectDimensionType;
	import jp.progression.casts.effects.EffectDirectionType;
	import jp.progression.casts.effects.EffectStartPointType;
	import jp.progression.casts.effects.FadeEffect;
	import jp.progression.casts.effects.FlyEffect;
	import jp.progression.casts.effects.IrisEffect;
	import jp.progression.casts.effects.PhotoEffect;
	import jp.progression.casts.effects.PixelDissolveEffect;
	import jp.progression.casts.effects.RotateEffect;
	import jp.progression.casts.effects.SqueezeEffect;
	import jp.progression.casts.effects.WipeEffect;
	import jp.progression.casts.effects.ZoomEffect;
	import jp.progression.casts.getInstanceById;
	import jp.progression.casts.getInstancesByGroup;
	import jp.progression.commands.Break;
	import jp.progression.commands.Command;
	import jp.progression.commands.CommandInterruptType;
	import jp.progression.commands.CommandList;
	import jp.progression.commands.display.AddChild;
	import jp.progression.commands.display.AddChildAt;
	import jp.progression.commands.display.AddChildAtAbove;
	import jp.progression.commands.display.RemoveChild;
	import jp.progression.commands.display.RemoveChildAt;
	import jp.progression.commands.display.RemoveChildByName;
	import jp.progression.commands.display.RemoveChildFromParent;
	import jp.progression.commands.DoExecutor;
	import jp.progression.commands.Func;
	import jp.progression.commands.getCommandById;
	import jp.progression.commands.getCommandsByGroup;
	import jp.progression.commands.Listen;
	import jp.progression.commands.lists.IRepeatable;
	import jp.progression.commands.lists.LoaderList;
	import jp.progression.commands.lists.LoopList;
	import jp.progression.commands.lists.ParallelList;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.commands.lists.ShuttleList;
	import jp.progression.commands.lists.TweenList;
	import jp.progression.commands.managers.Goto;
	import jp.progression.commands.managers.Jumpto;
	import jp.progression.commands.media.DoSound;
	import jp.progression.commands.net.DownloadFileRef;
	import jp.progression.commands.net.ILoadable;
	import jp.progression.commands.net.LoadBitmapData;
	import jp.progression.commands.net.LoadCommand;
	import jp.progression.commands.net.LoadScene;
	import jp.progression.commands.net.LoadSound;
	import jp.progression.commands.net.LoadSWF;
	import jp.progression.commands.net.NavigateToURL;
	import jp.progression.commands.net.PreloadSWF;
	import jp.progression.commands.net.SendToURL;
	import jp.progression.commands.net.UploadFileRef;
	import jp.progression.commands.Prop;
	import jp.progression.commands.Return;
	import jp.progression.commands.Stop;
	import jp.progression.commands.Trace;
	import jp.progression.commands.tweens.DoTransition;
	import jp.progression.commands.tweens.DoTween;
	import jp.progression.commands.tweens.DoTweener;
	import jp.progression.commands.tweens.DoTweenFrame;
	import jp.progression.commands.Var;
	import jp.progression.commands.Wait;
	import jp.progression.core.components.actions.IActionComp;
	import jp.progression.core.components.animation.IAnimationComp;
	import jp.progression.core.components.buttons.IButtonComp;
	import jp.progression.core.components.config.IConfigComp;
	import jp.progression.core.components.effects.IEffectComp;
	import jp.progression.core.components.ICoreComp;
	import jp.progression.core.components.loader.ILoaderComp;
	import jp.progression.core.display.AnimationBase;
	import jp.progression.core.display.Background;
	import jp.progression.core.display.ButtonBase;
	import jp.progression.core.display.EasyCastingContainer;
	import jp.progression.core.display.EffectBase;
	import jp.progression.core.events.ComponentEvent;
	import jp.progression.core.impls.ICastButton;
	import jp.progression.core.impls.ICastObject;
	import jp.progression.core.impls.IDisposable;
	import jp.progression.core.impls.IExecutable;
	import jp.progression.core.impls.IManageable;
	import jp.progression.core.impls.IWebConfig;
	import jp.progression.core.L10N.L10NCommandMsg;
	import jp.progression.core.L10N.L10NComponentMsg;
	import jp.progression.core.L10N.L10NDebugMsg;
	import jp.progression.core.L10N.L10NExecuteMsg;
	import jp.progression.core.L10N.L10NProgressionMsg;
	import jp.progression.core.L10N.L10NSlideLocalMsg;
	import jp.progression.core.L10N.L10NWebLocalMsg;
	import jp.progression.core.managers.HistoryManager;
	import jp.progression.core.managers.IInitializer;
	import jp.progression.core.managers.ISynchronizer;
	import jp.progression.core.managers.SceneManager;
	import jp.progression.core.managers.WebInitializer;
	import jp.progression.core.managers.WebSynchronizer;
	import jp.progression.core.proto.Configuration;
	import jp.progression.data.DataHolder;
	import jp.progression.data.getResourceById;
	import jp.progression.data.getResourcesByGroup;
	import jp.progression.data.Resource;
	import jp.progression.data.ResourcePrefetcher;
	import jp.progression.data.WebDataHolder;
	import jp.progression.debug.Debugger;
	import jp.progression.events.CastEvent;
	import jp.progression.events.CastMouseEvent;
	import jp.progression.events.DataProvideEvent;
	import jp.progression.events.ExecuteErrorEvent;
	import jp.progression.events.ExecuteEvent;
	import jp.progression.events.ManagerEvent;
	import jp.progression.events.ProcessEvent;
	import jp.progression.events.SceneEvent;
	import jp.progression.executors.CommandExecutor;
	import jp.progression.executors.ExecutorObject;
	import jp.progression.executors.ExecutorObjectState;
	import jp.progression.executors.ResumeExecutor;
	import jp.progression.getManagerById;
	import jp.progression.getManagersByGroup;
	import jp.progression.loader.EasyCastingLoader;
	import jp.progression.loader.PRMLLoader;
	import jp.progression.Progression;
	import jp.progression.scenes.EasyCastingScene;
	import jp.progression.scenes.getSceneById;
	import jp.progression.scenes.getSceneBySceneId;
	import jp.progression.scenes.getScenesByGroup;
	import jp.progression.scenes.PRMLContentType;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneInfo;
	import jp.progression.scenes.SceneLoader;
	import jp.progression.scenes.SceneObject;
	import jp.progression.ui.ContextMenuBuilder;
	import jp.progression.ui.IContextMenuBuilder;
	import jp.progression.ui.IKeyboardMapper;
	import jp.progression.ui.IToolTip;
	import jp.progression.ui.SlideContextMenuBuilder;
	import jp.progression.ui.SlideKeyboardMapper;
	import jp.progression.ui.ToolTip;
	import jp.progression.ui.WebContextMenuBuilder;
	import jp.progression.ui.WebKeyboardMapper;
	
	/**
	 * @private
	 */
	public final class Catalog {
		
		/**
		 * @private
		 */
		public function Catalog() {
			jp.nium.core.Catalog;
			
			ActivatedLicenseType, Progression, getManagerById, getManagersByGroup;
			InOutMovie;
			AnchorButton, NextButton, ParentButton, PreviousButton, RollOverButton, RootButton;
			BlindsEffect, EffectDimensionType, EffectDirectionType, EffectStartPointType, FadeEffect, FlyEffect, IrisEffect, PhotoEffect, PixelDissolveEffect, RotateEffect, SqueezeEffect, WipeEffect, ZoomEffect;
			CastBitmap, CastButton, CastButtonState, CastButtonWindowTarget, CastDocument, CastImageLoader, CastImageLoaderAlign, CastImageLoaderRatio, CastLoader, CastMovieClip, CastObject, CastPreloader, CastSprite, CastTextField, CastTimeline, getInstanceById, getInstancesByGroup;
			AddChild, AddChildAt, AddChildAtAbove, RemoveChild, RemoveChildAt, RemoveChildByName, RemoveChildFromParent;
			IRepeatable, LoaderList, LoopList, ParallelList, SerialList, ShuttleList, TweenList;
			Goto, Jumpto;
			DoSound;
			DownloadFileRef, ILoadable, LoadBitmapData, LoadCommand, LoadScene, LoadSound, LoadSWF, NavigateToURL, PreloadSWF, SendToURL, UploadFileRef;
			DoTransition, DoTween, DoTweener, DoTweenFrame;
			Break, Command, CommandInterruptType, CommandList, DoExecutor, Func, getCommandById, getCommandsByGroup, Listen, Prop, Return, Stop, Trace, Var, Wait;
			PackageInfo;
			IActionComp;
			IAnimationComp;
			IButtonComp;
			IConfigComp;
			IEffectComp;
			ILoaderComp;
			ICoreComp;
			AnimationBase, Background, ButtonBase, EasyCastingContainer, EffectBase;
			ComponentEvent;
			ICastButton, ICastObject, IDisposable, IExecutable, IManageable, IWebConfig;
			L10NCommandMsg, L10NComponentMsg, L10NDebugMsg, L10NExecuteMsg, L10NProgressionMsg, L10NSlideLocalMsg, L10NWebLocalMsg;
			HistoryManager, IInitializer, ISynchronizer, SceneManager, WebInitializer, WebSynchronizer;
			Configuration;
			DataHolder, getResourceById, getResourcesByGroup, Resource, ResourcePrefetcher, WebDataHolder;
			Debugger;
			CastEvent, CastMouseEvent, DataProvideEvent, ExecuteErrorEvent, ExecuteEvent, ManagerEvent, ProcessEvent, SceneEvent;
			CommandExecutor, ExecutorObject, ExecutorObjectState, ResumeExecutor;
			EasyCastingLoader, PRMLLoader;
			EasyCastingScene, getSceneById, getSceneBySceneId, getScenesByGroup, PRMLContentType, SceneId, SceneInfo, SceneLoader, SceneObject;
			ContextMenuBuilder, IContextMenuBuilder, IKeyboardMapper, IToolTip, SlideContextMenuBuilder, SlideKeyboardMapper, ToolTip, WebContextMenuBuilder, WebKeyboardMapper;
			
			throw new Error( Logger.getLog( L10NNiumMsg.getInstance().ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
	}
}
