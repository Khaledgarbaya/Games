package com.khaledgarbaya.runsheeprun 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import com.khaledgarbaya.utils.Logger;

import starling.utils.AssetManager;

	/**
	 * ...
	 * @author kgarbaya
	 * @copyright (c) Khaled Garbaya
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

		public function start(assets:AssetManager): void
		{

		}
	}

}