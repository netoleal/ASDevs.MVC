package com.asdevs.netoleal.mvc.viewcontroller.base
{
	import asf.core.elements.Section;
	import asf.core.viewcontrollers.TransitionableViewController;
	import asf.interfaces.ISequence;
	
	public class SectionViewController extends TransitionableViewController
	{
		protected var section:Section;
		
		public function SectionViewController(p_view:*, p_section:Section)
		{
			super(p_view);
			
			view.alpha = 0;
			section = p_section;
		}
		
		public override function open(p_delay:uint=0):ISequence
		{
			return fadeIn( view );
		}
		
		public override function close(p_delay:uint=0):ISequence
		{
			return fadeOut( view );
		}
		
		public override function dispose( ):void
		{
			section = null;
			super.dispose( );
		}
	}
}