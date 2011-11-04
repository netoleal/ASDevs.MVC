package com.asdevs.netoleal.mvc.viewcontroller.main.assets
{
	import asf.core.util.Sequence;
	import asf.core.viewcontrollers.InOutViewController;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	
	import flash.display.MovieClip;
	
	public class MainLoadingViewController extends InOutViewController implements ITransitionable
	{
		public function MainLoadingViewController(p_view:MovieClip)
		{
			super(p_view);
			view.$bar.alpha = 0;
			setProgress( 0 );
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			return this.animateIn( ).queue( fadeIn, view.$bar );
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return fadeOut( view.$bar ).queue( this.animateOut );
		}
		
		public function setProgress( value:Number ):void
		{
			view.$bar.scaleX = value;
		}
	}
}