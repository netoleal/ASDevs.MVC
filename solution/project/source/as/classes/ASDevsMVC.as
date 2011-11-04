package
{
	import asf.events.ApplicationEvent;
	import asf.events.DependenciesProgressEvent;
	import asf.plugins.loadermax.LoaderMaxFactoryPlugin;
	import asf.utils.Align;
	import asf.view.BaseLoaderApplication;
	
	import com.asdevs.mvc.assets.MainLoading;
	import com.asdevs.netoleal.mvc.viewcontroller.main.assets.MainLoadingViewController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class ASDevsMVC extends BaseLoaderApplication
	{
		private var loading:MainLoadingViewController;
		
		public function ASDevsMVC( )
		{
			super( new LoaderMaxFactoryPlugin( ) );
			
			log( );
			
			loading = new MainLoadingViewController( new MainLoading( ) );
			
			addChild( loading.view );
			
			Align.add( loading.view, Align.CENTER + Align.MIDDLE, { width: 0, height: 0 } );
			
			loading.open( ).queue( loadApplication );
		}
		
		private function loadApplication( ):void
		{
			loadApplicationConfigFile( new URLRequest( app.params.config ) );
		}
		
		protected override function appLoadProgress(event:DependenciesProgressEvent):void
		{
			loading.setProgress( event.bytesLoaded / event.bytesTotal );
		}
		
		protected override function appWillDispatchLoadComplete(event:Event):void
		{
			app.pauseLoading( );
			app.removeEventListener( ApplicationEvent.WILL_DISPATCH_LOAD_COMPLETE, appWillDispatchLoadComplete );
			
			loading.close( ).queue( app.resumeLoading );
		}
		
		protected override function appLoadComplete(event:DependenciesProgressEvent):void
		{
			log( );
			
			addChild( app.view );
			removeChild( loading.view );
			
			loading.dispose( );
			loading = null;
		}
	}
}
