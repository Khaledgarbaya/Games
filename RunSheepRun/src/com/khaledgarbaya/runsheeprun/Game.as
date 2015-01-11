/**
 *
 * Created by kgar on 01/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun
{
import com.khaledgarbaya.runsheeprun.screens.InGameScreen;
import com.khaledgarbaya.utils.Logger;

import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class Game extends Sprite
{
    public static var gameAsset:AssetManager;

    public function Game()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
        Logger.info("Game::initialize");
    }

    public function start(assets:AssetManager):void
    {
        gameAsset = assets;
        addChild(new InGameScreen());
    }
}

}