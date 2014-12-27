package com.khaledgarbaya.runsheeprun 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import com.khaledgarbaya.utils.Logger;
	/**
	 * ...
	 * @author kgarbaya
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		private function initialize(event: Event): void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			Logger.info("Game::initialize");
		}
		
	}

}