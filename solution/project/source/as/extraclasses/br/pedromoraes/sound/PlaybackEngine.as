package br.pedromoraes.sound
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	
	
	public class PlaybackEngine extends EventDispatcher
	{
		
		public var channels : Array = []; 
		public var _position : Number = 0;
		public var loop : Boolean;
		public var pausedPosition : Number;
		
		public function PlaybackEngine()
		{
		}

		public function get activeChannels() : int
		{
			var res : int = 0;
			for each ( var channel : ChannelDef in channels )
			{
				if ( channel.active )
				{
					res ++;
				}
			}
			return res;
		}

		public function get position() : Number
		{
			for each ( var channel : ChannelDef in channels )
			{
				if ( channel.active )
				{
					_position = channel.soundChannel.position;
				}
			}
			return _position;
		}
		
		public function addSound( sound : Sound, id : String, volume : Number = 1, pan : Number = 0 ) : void
		{
			removeSound( id );
			channels.push( new ChannelDef( sound, id, volume, pan ) );
		}
		
		public function removeSound( id : String ) : void
		{
			var channel : ChannelDef = getChannelDef( id );
			if ( channel )
			{
				channels.splice( channels.indexOf( channel ), 1 );
				channel.dispose();
			}
		}
		
		public function play() : void
		{
			var pos : Number = position;
			for each ( var channel : ChannelDef in channels )
			{
				if ( channel.play( pos ) )
				{
					channel.soundChannel.addEventListener( Event.SOUND_COMPLETE, onSoundComplete );
				}
			}
		}
		
		public function stop() : void
		{
			for each ( var channel : ChannelDef in channels )
			{
				channel.stop();
			}
			_position = 0;
		}
		
		public function pause() : void
		{
			pausedPosition = position;
			for each ( var channel : ChannelDef in channels )
			{
				channel.stop();
			}
		}

		public function unpause() : void
		{
			play();
		}

		public function seek( pos : Number ) : void
		{
			var active : int = activeChannels;
			stop();
			_position = pos;
			
			if ( active )
			{
				play();
			}
		}
		
		public function muteAll() : void
		{
			for each ( var channel : ChannelDef in channels )
			{
				channel.mute();
			}
		}
		
		public function unmuteAll() : void
		{
			for each ( var channel : ChannelDef in channels )
			{
				channel.unmute();
			}
		}
		
		public function getSound( id : String ) : Sound
		{
			var channel : ChannelDef = getChannelDef( id );
			if ( channel )
			{
				return channel.sound;
			}
			return null;
		}

		public function getActive() : Array
		{
			var res : Array = new Array();
			for each ( var channel : ChannelDef in channels )
			{
				if ( channel.active )
				{
					res.push( channel );
				}
			}
			return res;
		}
		
		public function getChannelDef( id : String ) : ChannelDef
		{
			for each ( var channel : ChannelDef in channels )
			{
				if ( channel.id == id )
				{
					return channel;
				}
			}
			return null;
		}
		
		public function dispose() : void
		{
			stop();
			for each ( var channel : ChannelDef in channels )
			{
				channel.dispose();
			}
			channels = [];
		}
		
		private function onSoundComplete( event : Event ) : void
		{
			if ( getActive().length == 0 )
			{
				_position = 0;
				dispatchEvent( new Event( Event.SOUND_COMPLETE ) );
				if ( loop )
				{
					play();
				}
			}
		}

	}
}
