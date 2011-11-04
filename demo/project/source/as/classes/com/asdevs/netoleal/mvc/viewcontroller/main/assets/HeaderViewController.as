package com.asdevs.netoleal.mvc.viewcontroller.main.assets
{
	import asf.core.viewcontrollers.ButtonViewController;
	import asf.core.viewcontrollers.InOutViewController;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	
	import flash.display.MovieClip;
	
	public class HeaderViewController extends InOutViewController implements ITransitionable
	{
		private var btYoutube:ButtonViewController;
		private var btFlickr:ButtonViewController;
		
		public function HeaderViewController(p_view:MovieClip)
		{
			super(p_view);
			
			btYoutube = new ButtonViewController( view.$youtube.$bt );
			btFlickr = new ButtonViewController( view.$flickr.$bt );
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			return this.animateIn( );
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return this.animateOut( );
		}
	}
}