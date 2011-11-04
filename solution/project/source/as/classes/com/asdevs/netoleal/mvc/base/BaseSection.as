package com.asdevs.netoleal.mvc.base
{
	import asf.core.elements.Section;
	import asf.core.viewcontrollers.TransitionableViewController;
	import asf.interfaces.ISectionView;
	import asf.interfaces.ISequence;
	
	import flash.display.Sprite;
	
	public class BaseSection extends Sprite implements ISectionView
	{
		protected var controller:TransitionableViewController;
		
		public function BaseSection( )
		{
			super();
		}
		
		public function init(p_section:Section, ...parameters):void
		{
			//Será implementado pelas classes filhas
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			if( controller.view != this ) addChild( controller.view );
			return controller.open( p_delay );
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return controller.close( p_delay );
		}
		
		public function dispose():void
		{
			if( controller.view != this ) removeChild( controller.view );
			controller.dispose( );
			controller = null;
		}
	}
}