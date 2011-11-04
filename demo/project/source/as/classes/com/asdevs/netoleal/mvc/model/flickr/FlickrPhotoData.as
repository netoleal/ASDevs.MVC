package com.asdevs.netoleal.mvc.model.flickr
{
	public class FlickrPhotoData
	{
		private var raw:Object;
		
		public function FlickrPhotoData( p_raw:Object )
		{
			raw = p_raw;
		}
		
		public function get imageURL( ):String
		{
			return getImageURL( "s" );
		}
		
		public function getImageURL( size:String ):String
		{
			return "http://farm" + farm + ".static.flickr.com/" + server + "/" + id + "_" + secret + "_" + size + ".jpg"
		}
		
		public function get farm( ):String
		{
			return raw.farm;
		}
		
		public function get id( ):String
		{
			return raw.id;
		}
		
		public function get owner( ):String
		{
			return raw.owner;
		}
		
		public function get server( ):String
		{
			return raw.server;
		}
		
		public function get title( ):String
		{
			return raw.title;
		}
		
		public function get secret( ):String
		{
			return raw.secret;
		}
	}
}