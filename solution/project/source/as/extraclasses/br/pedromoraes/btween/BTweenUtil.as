package br.pedromoraes.btween
{

	public class BTweenUtil
	{
		
		public static function stopTweens(... paFilters:Array):void
		{
			if (paFilters.length)
			{
				for each (var filter:Object in paFilters)
				{
					getTweens(filter).every(stop);
				}
			}
			else
			{
				BTween.instances.every(stop);
			}
		}

		public static function stopTweensByName(... paNames:Array):void
		{
			var instances : Array = BTween.instances.slice();
			for each ( var instance:BTween in instances )
			{
				if ( paNames.indexOf( instance.name ) > -1 )
				{
					instance.stop();
				}
			}
		}

		public static function getTweens(pFilter:Object):Array
		{
			var laResults:Array = BTween.instances.slice();
			for each (var instance:BTween in BTween.instances)
			{
				var match : Boolean;
				for each ( var tween:* in instance.tweens )
				{
					for ( var prop : String in pFilter )
					{
						if ( tween.hasOwnProperty( prop ) )
						{
							if ( tween[ prop ] === pFilter[ prop ] )
							{
								match = true;
								continue;
							}
						}
						break;
					}
				}
				if ( !match ) laResults.splice(laResults.indexOf(instance), 1);
			}
			return laResults;
		}

		public static function stop(pInstance:BTween, ... paRest:Array):void
		{
			pInstance.stop();
		}

	}
}
