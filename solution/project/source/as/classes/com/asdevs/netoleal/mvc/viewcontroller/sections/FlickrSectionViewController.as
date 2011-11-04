package com.asdevs.netoleal.mvc.viewcontroller.sections
{
	import asf.core.elements.Section;
	import asf.core.util.Sequence;
	import asf.interfaces.ISequence;
	
	import br.com.netoleal.interfaces.IIterator;
	
	import com.asdevs.netoleal.mvc.model.flickr.FlickrPhotoData;
	import com.asdevs.netoleal.mvc.model.flickr.FlickrRecentPhotosData;
	import com.asdevs.netoleal.mvc.viewcontroller.base.SectionViewController;
	import com.asdevs.netoleal.mvc.viewcontroller.flickr.ThumbViewController;
	
	import flash.display.Sprite;
	
	import hype.extended.layout.GridLayout;
	
	public class FlickrSectionViewController extends SectionViewController
	{
		private var photosModel:FlickrRecentPhotosData;
		private var items:Array;
		
		public function FlickrSectionViewController(p_view:*, p_section:Section)
		{
			super( p_view, p_section );
			
			photosModel = new FlickrRecentPhotosData( );
		}
		
		public override function open(p_delay:uint=0):ISequence
		{
			return super.open( p_delay ).queue( photosModel.loadRecentPhotos ).queue( performOpen );
		}
		
		private function performOpen( ):ISequence
		{
			var it:IIterator = photosModel.photos.iterator( );
			var seq:ISequence;
			var n:uint = 0;
			var item:ThumbViewController;
			var style:Object = section.styles.getStyle( "thumbs" );
			var layout:GridLayout = new GridLayout( 0, 0, parseInt( style.spacement ), parseInt( style.spacement ), 10 );
			var max:uint = parseInt( section.params.maxImages );
			
			log( );
			
			items = new Array( );
			
			while( it.hasNext( ) && n < max )
			{
				item = new ThumbViewController( new Sprite( ), it.next( ) );
				
				layout.applyLayout( item.view );
				section.layers.photos.addChild( item.view );
				
				seq = item.open( n * 60 );
				
				n++;
			}
			
			return seq;
		}
	}
}