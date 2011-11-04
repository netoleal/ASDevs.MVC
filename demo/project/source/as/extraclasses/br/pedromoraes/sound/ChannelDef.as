package br.pedromoraes.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class ChannelDef
	{
		public var id : String;
		public var sound : Sound;
		public var soundChannel : SoundChannel;
		public var volume : Number;
		public var pan : Number;
		public var isMute : Boolean;
		public var active : Boolean;
		
		public function ChannelDef( sound : Sound, id : String, volume : Number = 1, pan : Number = 0 ) : void
		{
			this.id = id;
			this.sound = sound;
			this.volume = volume;
			this.pan = pan;
		}
		
		public function play( pos : Number = 0 ) : Boolean
		{
			stop();
			if ( !isMute && pos < sound.length ) 
			{
				soundChannel = sound.play( pos, 0, getTransform() );
				soundChannel.addEventListener( Event.SOUND_COMPLETE, onSoundComplete );
				active = true;
				return true;
			}
			return false;
		}
		
		public function stop() : void
		{
			if ( soundChannel )
			{
				soundChannel.stop();
			}
			active = false;
		}
		
		public function mute() : void
		{
			isMute = true;
		}
		
		public function unmute() : void
		{
			isMute = false;
		}
		
		public function getTransform() : SoundTransform
		{
			return ( volume == 1 && pan == 0 ) ? null : new SoundTransform( volume, pan );
		}
		
		public function dispose() : void
		{
			if ( soundChannel )
			{
				soundChannel.stop();
				soundChannel = null;
			}
			sound = null;
		}
		
		private function onSoundComplete( event : Event ) : void
		{
			active = false;
		}
	}
}