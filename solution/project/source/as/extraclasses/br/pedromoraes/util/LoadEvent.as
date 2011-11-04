package br.pedromoraes.util
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class LoadEvent extends Event
	{

		public static var COMPLETE:String = "complete";
		public static var PROGRESS:String = "progress";
		public static var ERROR:String = "error";
		
		public var jobProgress:Number = 0;
		public var bytesTotal:int;
		public var bytesLoaded:int;
		public var error:IOErrorEvent;
		public var data:Object;
		public var contentType:Object;
		public var url:String;

		public function LoadEvent(psType:String, pbBubbles:Boolean=false, pbCancelable:Boolean=false)
		{
			super(psType, pbBubbles, pbCancelable);
		}
		
		public override function clone():Event
		{
			var evt:LoadEvent = new LoadEvent(type, bubbles, cancelable);
			evt.jobProgress = jobProgress;
			evt.bytesTotal = bytesTotal;
			evt.bytesLoaded = bytesLoaded;
			evt.error = error;
			evt.data = data;
			evt.contentType = contentType;
			evt.url = url;
			return evt;
		}

	}
}