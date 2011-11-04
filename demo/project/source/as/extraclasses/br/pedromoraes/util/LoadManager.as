package br.pedromoraes.util
{

	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Dispatched when all content is loaded
	 *
	 * @eventType br.pedromoraes.util.LoadEvent
	 */
	[Event(name="complete", type="br.pedromoraes.util.LoadEvent")]

	/**
	 * Dispatched on each load progress event
	 *
	 * @eventType br.pedromoraes.util.LoadEvent
	 */
	[Event(name="update", type="br.pedromoraes.util.LoadEvent")]

	/**
	 * Dispatched when an error occur
	 *
	 * @eventType br.pedromoraes.util.LoadEvent
	 */
	[Event(name="error", type="br.pedromoraes.util.LoadEvent")]

	public class LoadManager extends EventDispatcher
	{

		public static var TYPE_URL:String = "url";
		public static var TYPE_DISPLAYOBJECT:String = "displayobject";

		public var type:String;
		public var url:String;
		public var noCache:Boolean;
		
		private var loader:Loader;
		private var urlLoader:URLLoader;

		public function LoadManager(pbNoCache:Boolean = false)
		{
			noCache = pbNoCache;
		}

		public function load(psUrl:String, psType:String = null):void
		{
			type = psType || type || TYPE_DISPLAYOBJECT; 

			if (type == TYPE_URL)
			{
				loadUrl(psUrl);
			}
			else
			{
				loadDisplayObject(psUrl);
			}
		}

		public function loadUrl(psUrl:String):void
		{
			type = TYPE_URL;
			url = psUrl;
			if (noCache) url += (url.indexOf('?') == -1 ? '?' : '&') + Math.random();
			urlLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			urlLoader.load(new URLRequest(url));
		}
		
		public function loadDisplayObject(psUrl:String):void
		{
			type = TYPE_DISPLAYOBJECT;
			url = psUrl;
			if (noCache) url += (url.indexOf('?') == -1 ? '?' : '&') + Math.random();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadComplete);
			loader.load(new URLRequest(url));
		}
		
		public override function dispatchEvent(pEvt:Event):Boolean
		{
			(pEvt as LoadEvent).url = url;
			return super.dispatchEvent(pEvt);
		}

		private function onLoadError(pEvt:IOErrorEvent):void
		{
			var evt:LoadEvent = new LoadEvent(LoadEvent.ERROR);
			evt.error = pEvt;
			dispatchEvent(evt);
		}

		private function onLoadProgress(pEvt:ProgressEvent):void
		{
			var evt:LoadEvent = new LoadEvent(LoadEvent.PROGRESS);
			if (type == TYPE_URL)
			{
				evt.bytesLoaded = urlLoader.bytesLoaded;
				evt.bytesTotal = urlLoader.bytesTotal;
			}
			else
			{
				evt.bytesLoaded = loader.contentLoaderInfo.bytesLoaded;
				evt.bytesTotal = loader.contentLoaderInfo.bytesTotal;
			}
			dispatchEvent(evt);
		}

		private function onLoadComplete(pEvt:Event):void
		{
			var evt:LoadEvent = new LoadEvent(LoadEvent.COMPLETE);
			if (type == TYPE_URL)
			{
				evt.bytesLoaded = evt.bytesTotal = urlLoader.bytesTotal;
				evt.data = urlLoader.data;
				evt.contentType = urlLoader.dataFormat;
			}
			else
			{
				evt.bytesLoaded = evt.bytesTotal = loader.contentLoaderInfo.bytesLoaded;
				evt.data = loader.content;
				evt.contentType = loader.contentLoaderInfo.contentType;
			}
			dispatchEvent(evt);
		}

	}
}