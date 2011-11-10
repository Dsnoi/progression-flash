/**
 * HIGEWheel - remove dependencies of mouse wheel on each browser.
 *
 * Copyright (c) 2008 Takanobu Izukawa (humming.via-kitchen.com) and
 *                    Spark project    (www.libspark.org)
 *
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */
package org.libspark.utils.ui
{
    import flash.display.InteractiveObject;
    import flash.display.Stage;
    import flash.external.ExternalInterface;
    import flash.events.MouseEvent;
    import flash.system.Capabilities;   

    public class HIGEWheel
    {
        /* CONSTANTS */
        public static const DEFINE_LIBRARY_FUNCTION:String = "function(){if(window.HIGEWheel)return;var win=window,doc=document,nav=navigator;var HIGEWheel=window.HIGEWheel=function(id){this.setUp(id);if(HIGEWheel.browser.msie)this.bind4msie();else this.bind();};HIGEWheel.prototype={setUp:function(id){var el=doc.getElementById(id);if(HIGEWheel.browser.safari||HIGEWheel.browser.msie)el=el.parentNode;this.target=el;this.eventType=HIGEWheel.browser.mozilla?'DOMMouseScroll':'mousewheel';},bind:function(){this.target.addEventListener(this.eventType,function(evt){var target=evt.constructor?evt.target:doc.getElementById(evt.target.id),delta=0,n=target.nodeName.toLowerCase();if(n!='object'&&n!='embed')return;evt.preventDefault();evt.returnValue=false;if(!target.externalMouseEvent)return;switch(true){case HIGEWheel.browser.mozilla:delta=-evt.detail;break;case HIGEWheel.browser.safari:case HIGEWheel.browser.opera:delta=evt.wheelDelta/80;break;default:break;}target.externalMouseEvent(delta);},false);},bind4msie:function(){this.target.attachEvent('onmousewheel',function(){var evt=win.event;var n=evt.srcElement.nodeName.toLowerCase();if(n!='object'&&n!='embed')return;evt.returnValue=false;});}};HIGEWheel.browser=(function(ua){return{safari:/webkit/.test(ua),opera:/opera/.test(ua),msie:/msie/.test(ua)&&!/opera/.test(ua),mozilla:/mozilla/.test(ua)&&!/(compatible|webkit)/.test(ua)}})(nav.userAgent.toLowerCase());HIGEWheel.join=function(id){var t=setInterval(function(){if(doc.getElementById(id)){clearInterval(t);new HIGEWheel(id);}},0);}}";
        public static const EXECUTE_LIBRARY_FUNCTION:String = "HIGEWheel.join";
        public static const CHECK_SAFARI_EXTERNAL_FUNCTION:String = "function(){return /webkit/.test(navigator.userAgent.toLowerCase());}";

        /* PROPERTIES */
        private static var _instance:HIGEWheel;
        private var _stage:Stage;
        private var _currItem:InteractiveObject;
        private var _clonedEvent:MouseEvent;

        public static function get instance():HIGEWheel
        {
            if (_instance == null)
            {
                _instance = new HIGEWheel(new HIGEWheelConfigure());
            }
            return _instance;
        }

        public function HIGEWheel(configure:HIGEWheelConfigure)
        {
            if (configure == null)
            {
                var msg:String = "first argument must be configure object.";
                throw new ArgumentError(msg);
            }
        }
        
        public static function initialize(stage:Stage):void
        {
            // if external is disabled, nothing to do...
            if (!ExternalInterface.available) return;
            // define as javascript library.
            ExternalInterface.call(DEFINE_LIBRARY_FUNCTION);
            ExternalInterface.call(EXECUTE_LIBRARY_FUNCTION, ExternalInterface.objectID);
            // check the environment.
            var isMac:Boolean = Boolean(Capabilities.os.toLowerCase().indexOf("mac") != -1);
            var isSafari:Boolean = Boolean(ExternalInterface.call(CHECK_SAFARI_EXTERNAL_FUNCTION));
            // ignore no mac, no safari.
            if(!isMac && !isSafari) return;
            // initialize self and start logic.
            instance._initialize(stage);
        }

        private function _initialize(stage:Stage):void
        {
            _stage = stage;
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, _getItemUnderCursor);
            
            if(ExternalInterface.available)
            {
                ExternalInterface.addCallback('externalMouseEvent', _externalMouseEvent);
            }
        }

        private function _getItemUnderCursor(evt:MouseEvent):void
        {
            _currItem = InteractiveObject(evt.target);
            _clonedEvent = MouseEvent(evt);
        }

        private function _externalMouseEvent(delta:Number):void
        {
            var wheelEvent:MouseEvent = new MouseEvent( 
                    MouseEvent.MOUSE_WHEEL, 
                    true, 
                    false, 
                    _clonedEvent.localX, 
                    _clonedEvent.localY, 
                    _clonedEvent.relatedObject, 
                    _clonedEvent.ctrlKey, 
                    _clonedEvent.altKey, 
                    _clonedEvent.shiftKey, 
                    _clonedEvent.buttonDown, 
                    int( delta )
                );
            _currItem.dispatchEvent(wheelEvent);
        }
    }
}

internal class HIGEWheelConfigure {}
