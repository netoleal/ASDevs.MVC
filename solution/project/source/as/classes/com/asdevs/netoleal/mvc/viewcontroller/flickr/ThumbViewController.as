package com.asdevs.netoleal.mvc.viewcontroller.flickr
{
	import asf.core.elements.Section;
	import asf.core.viewcontrollers.AbstractViewController;
	import asf.core.viewcontrollers.ApplicationViewController;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	
	import com.asdevs.netoleal.mvc.model.flickr.FlickrPhotoData;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	import flash.geom.Rectangle;
	
	import utils.align.alignCenter;
	import utils.align.alignToRectangleCenterMiddle;
	import utils.draw.drawRoundRect;
	
	public class ThumbViewController extends AbstractViewController implements ITransitionable
	{
		private var model:FlickrPhotoData;
		private var loader:ImageLoader;
		private var style:Object;
		
		public function ThumbViewController(p_view:*, p_model:FlickrPhotoData )
		{
			super( p_view );
			
			model = p_model;
			style = Section.getByID( "flickr" ).styles.getStyle( "thumbs" );
			
			viewAsSprite.alpha = 0;
			viewAsSprite.graphics.beginFill( 0xFFFFFF );
			
			drawRoundRect( view.graphics, 0, 0, parseInt( style.width ), parseInt( style.height ), 0, 0 );
			
			loader = new ImageLoader( model.imageURL );
			loader.addEventListener( LoaderEvent.COMPLETE, onLoadComplete );
			
			loader.load( );
		}
		
		private function onLoadComplete(event:LoaderEvent):void
		{
			loader.content.alpha = 0;
			alignToRectangleCenterMiddle( loader.content, new Rectangle( 0, 0, view.width, view.height ) );
			
			view.addChild( loader.content );
			
			fadeIn( loader.content );
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			return fadeIn( view, 333, p_delay );
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return fadeOut( view, 333, p_delay );
		}
	}
}