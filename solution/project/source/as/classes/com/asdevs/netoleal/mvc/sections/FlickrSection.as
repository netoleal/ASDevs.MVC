package com.asdevs.netoleal.mvc.sections
{
	import asf.core.elements.Section;
	import asf.interfaces.ISectionView;
	import asf.interfaces.ISequence;
	
	import com.asdevs.netoleal.mvc.base.BaseSection;
	import com.asdevs.netoleal.mvc.viewcontroller.sections.FlickrSectionViewController;
	
	import flash.display.Sprite;
	
	public class FlickrSection extends BaseSection
	{
		public function FlickrSection()
		{
			super( );
		}
		
		public override function init(p_section:Section, ...parameters):void
		{
			controller = new FlickrSectionViewController( this, p_section );
		}
	}
}