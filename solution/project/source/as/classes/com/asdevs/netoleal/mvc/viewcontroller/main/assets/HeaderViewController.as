package com.asdevs.netoleal.mvc.viewcontroller.main.assets
{
	import asf.core.app.ASF;
	import asf.core.viewcontrollers.ButtonViewController;
	import asf.core.viewcontrollers.InOutViewController;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	import asf.utils.Delay;
	
	import flash.display.MovieClip;
	
	public class HeaderViewController extends InOutViewController implements ITransitionable
	{
		private var app:ASF;
		private var youtube:ButtonViewController;
		private var flickr:ButtonViewController;
		
		public function HeaderViewController( p_view:MovieClip, p_app:ASF )
		{
			super(p_view);
			
			app = p_app;
			
			youtube = new ButtonViewController( view.$youtube.$bt );
			flickr = new ButtonViewController( view.$flickr.$bt );
		}
		
		public function open( delay:uint = 0 ):ISequence
		{
			return Delay.start( delay ).queue( this.animateIn );
		}
		
		public function close( delay:uint = 0 ):ISequence
		{
			return Delay.start( delay ).queue( this.animateOut );
		}
	}
}