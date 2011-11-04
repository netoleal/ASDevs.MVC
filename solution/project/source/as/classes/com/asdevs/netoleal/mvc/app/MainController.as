package com.asdevs.netoleal.mvc.app
{
	import asf.core.app.ASF;
	import asf.interfaces.IMainController;
	
	import com.asdevs.netoleal.mvc.viewcontroller.main.assets.MainViewController;
	
	public class MainController implements IMainController
	{
		private var main:MainViewController;
		private var app:ASF;
		
		public function MainController( )
		{
			log( );
		}
		
		public function init( p_app:ASF ):void
		{
			app = p_app;
			
			main = new MainViewController( app.dependencies.getSWF( "mainCanvas" )[ "$main" ], app );
			
			app.layers.main.addChild( main.view );
			
			log( );
			main.open( ).queue( openFirstSection );
		}
		
		private function openFirstSection():void
		{
			app.navigation.openSection( "flickr" );
		}
		
		public function dispose( ):void
		{
			
		}
	}
}