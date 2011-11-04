package com.asdevs.netoleal.mvc.app
{
	import asf.core.app.ASF;
	import asf.interfaces.IMainController;
	
	import com.asdevs.netoleal.mvc.viewcontroller.main.assets.MainViewController;
	
	public class MainController implements IMainController
	{
		private var main:MainViewController;
		
		public function MainController()
		{
		}
		
		public function init(p_app:ASF):void
		{
			log( p_app.model.id );
			
			main = new MainViewController( p_app.dependencies.getSWF( "mainCanvas" )[ "$main" ], p_app );
			
			p_app.layers.main.addChild( main.view );
		}
		
		public function dispose():void
		{
		}
	}
}