package com.asdevs.netoleal.mvc.viewcontroller.main.assets
{
	import asf.core.app.ASF;
	import asf.core.viewcontrollers.TransitionableViewController;
	import asf.interfaces.ISequence;
	
	
	public class MainViewController extends TransitionableViewController
	{
		private var app:ASF;
		private var header:HeaderViewController;
		
		public function MainViewController(p_view:*, p_app:ASF)
		{
			super(p_view);
			
			app = p_app;
			header = new HeaderViewController( view.$header, app );
			
			view.alpha = 0;
		}
		
		public override function open(p_delay:uint=0):ISequence
		{
			log( );
			header.open( 300 );
			return fadeIn( view, 333, p_delay );
		}
		
		public override function close(p_delay:uint=0):ISequence
		{
			return fadeOut( view, 333, p_delay );
		}
	}
}