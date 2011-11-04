package br.pedromoraes.util
{
	import flash.events.EventDispatcher;

	/**
	 * Dispatched when all jobs are done
	 *
	 * @eventType br.pedromoraes.util.LoadEvent
	 */
	[Event(name="complete", type="br.pedromoraes.util.LoadEvent")]

	/**
	 * Dispatched on each job progress event
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

	public class LoadBatch extends EventDispatcher
	{
		
		public var ignoreErrors:Boolean;
		public var noCache:Boolean;
		public var loadedJobs:int;
		public var maxConnections:int;
		public var basePath:String;

		private var jobs:Array;
		
		private var slot:int;
		private var size:int;

		public function LoadBatch(piMaxConnections:int = 1, pbNoCache:Boolean = false):void
		{
			noCache = pbNoCache;
			maxConnections = piMaxConnections;
			jobs = new Array();
		}

		public function get progress():Number
		{
			var lnRes:Number = 0;
			for each (var job:Job in jobs) lnRes += job.progress;
			return lnRes/size;
		}

		public function get loadedContent():Object
		{
			var data:Object = new Object();
			for each (var job:Job in jobs)
			{
				data[job.key] = job.data;
			}
			return data;
		}

		public function add(psKey:String, psUrl:String, psType:String):void
		{
			var job:Job = new Job(psKey, psUrl.replace('%basePath%', basePath), psType, noCache);
			job.addEventListener(LoadEvent.PROGRESS, onJobProgress);
			job.addEventListener(LoadEvent.COMPLETE, onJobComplete);
			job.addEventListener(LoadEvent.ERROR, onJobError);
			jobs.push(job);
			size ++;
		}
		
		public function addUrl(psKey:String, psUrl:String):void
		{
			add(psKey, psUrl, LoadManager.TYPE_URL);
		}
		
		public function addDisplayObject(psKey:String, psUrl:String):void
		{
			add(psKey, psUrl, LoadManager.TYPE_DISPLAYOBJECT);
		}
		
		public function start():void
		{
			for (var liJob:int = loadedJobs; liJob < jobs.length; liJob ++)
			{
				var job:Job = jobs[liJob];
				if (!job.started)
				{
					slot ++;
					job.start();
				}
				if (slot + 1 > maxConnections) return;
			}
		}

		public function loadFileList(psUrl:String):void
		{
			var listJob:LoadManager = new LoadManager();
			listJob.loadUrl(psUrl.replace('%basePath%',basePath));
			listJob.addEventListener(LoadEvent.COMPLETE, onFileListLoadComplete);
			listJob.addEventListener(LoadEvent.ERROR, 
			function(e:*):void{trace("#error loading list",e,listJob.url);});
		}
		
		private function onJobProgress(pEvt:LoadEvent):void
		{
			var evt:LoadEvent = new LoadEvent(LoadEvent.PROGRESS);
			evt.jobProgress = pEvt.bytesLoaded / pEvt.bytesTotal;
			dispatchEvent(evt);
		}

		private function onJobError(pEvt:LoadEvent):void
		{
			var evt:LoadEvent = new LoadEvent(LoadEvent.ERROR);
			evt.url = pEvt.url;			
			evt.error = pEvt.error;
			dispatchEvent(evt);
			if (ignoreErrors)
			{
				for each (var j:Job in jobs)
				{
					if (j.url == pEvt.url)
					{
						j.progress = 1; j.done = true;
						onJobComplete(new LoadEvent(LoadEvent.COMPLETE));
						break;
					}
				}
			}
		}

		private function onJobComplete(pEvt:LoadEvent):void
		{
			loadedJobs ++;
			if (loadedJobs == jobs.length)
			{
				var evt:LoadEvent = new LoadEvent(LoadEvent.COMPLETE);
				var data:Object = new Object();
				for each (var job:Job in jobs) data[job.key] = job.data;
				evt.data = data;
				dispatchEvent(evt);
			}
			else
			{
				slot --;
				start();
			}
		}

		private function onFileListLoadComplete(pEvt:LoadEvent):void
		{
			var list:XML = XML(pEvt.data);
			var lsKey:String;
			for each (var file:XML in list.file)
			{
				lsKey = file.@key.toString();
				lsKey = lsKey.length ? lsKey : file.@url.toString().substring(file.@url.toString().lastIndexOf('/')+1, file.@url.toString().lastIndexOf('.'));  
				add(lsKey, file.@url, file.@type);
			}
			start();
		}
	}
	
}

import flash.events.EventDispatcher;
import br.pedromoraes.util.LoadEvent;
import br.pedromoraes.util.LoadManager;

internal class Job extends EventDispatcher
{

	public var key:String;
	public var type:String;
	public var url:String;
	public var done:Boolean;
	public var started:Boolean;
	public var data:Object;
	public var progress:Number = 0;
	private var loadManager:LoadManager;

	public function Job(psKey:String, psUrl:String, psType:String, pbNoCache:Boolean = false):void
	{
		key = psKey;
		type = psType;
		url = psUrl;
		loadManager = new LoadManager(pbNoCache);
		loadManager.addEventListener(LoadEvent.COMPLETE, onLoadComplete);
		loadManager.addEventListener(LoadEvent.ERROR, onLoadError);
		loadManager.addEventListener(LoadEvent.PROGRESS, onLoadProgress);
	}

	public function start():void
	{
		loadManager.load(url, type);
		started = true;
	}
	
	private function onLoadComplete(pEvt:LoadEvent):void
	{
		progress = 1;
		done = true;
		data = pEvt.data;
		dispatchEvent(pEvt.clone());
	}

	private function onLoadProgress(pEvt:LoadEvent):void
	{
		progress = pEvt.bytesLoaded / pEvt.bytesTotal;
		dispatchEvent(pEvt.clone());
	}

	private function onLoadError(pEvt:LoadEvent):void
	{
		trace('error',key,url);
		dispatchEvent(pEvt.clone());
	}

}