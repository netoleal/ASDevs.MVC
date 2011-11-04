package com.asdevs.netoleal.mvc.model.flickr
{
	import asf.core.util.Sequence;
	import asf.interfaces.ISequence;
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.asdevs.netoleal.mvc.app.Services;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class FlickrRecentPhotosData extends EventDispatcher
	{
		private var loader:URLLoader;
		private var _collection:FlickrPhotosCollection;
		
		private var loadSeq:Sequence;
		
		public function FlickrRecentPhotosData( )
		{
			super( null );
			
			loader = new URLLoader( );
			loadSeq = new Sequence( );
			
			loader.addEventListener( Event.COMPLETE, onComplete );
		}
		
		public function loadRecentPhotos( ):ISequence
		{
			var req:URLRequest = new URLRequest( Services.FLICKR_URL );
			
			loadSeq.notifyStart( );
			loader.load( req );
			
			log( req.url );
			
			return loadSeq;
		}
		
		private function onComplete( evt:Event ):void
		{
			var rawData:Object = new JSONDecoder( loader.data ).getValue( );
			var itemRaw:Object;
			
			log( );
			
			_collection = new FlickrPhotosCollection( );
			
			for each( itemRaw in rawData.photos.photo )
			{
				_collection.addElement( new FlickrPhotoData( itemRaw ) );
			}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			loadSeq.notifyComplete( );
		}
		
		public function get photos( ):FlickrPhotosCollection
		{
			return _collection;
		}
	}
}