package com.asdevs.netoleal.mvc.viewcontroller.main.assets
{
	import asf.core.app.ASF;
	import asf.core.viewcontrollers.AbstractViewController;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	
	public class MainViewController extends AbstractViewController implements ITransitionable
	{
		private var app:ASF;
		private var header:HeaderViewController;
		
		public function MainViewController(p_view:*, p_app:ASF )
		{
			super(p_view);
			app = p_app;
			
			header = new HeaderViewController( view.$header );
			header.open( );
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			return null;
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return null;
		}
	}
}