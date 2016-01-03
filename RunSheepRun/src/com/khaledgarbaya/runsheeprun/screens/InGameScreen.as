/**
 *
 * Created by kgar on 02/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.screens
{
import acheGesture.GestureManager;
import acheGesture.data.Gesture;
import acheGesture.data.GestureVars;
import acheGesture.data.SwipeGesture;
import acheGesture.events.AcheGestureEvent;

import com.khaledgarbaya.runsheeprun.objects.ScrollBackground;
import com.khaledgarbaya.runsheeprun.objects.HeroAnimation;

import starling.display.Sprite;
import starling.events.Event;

public class InGameScreen extends Sprite
{
    private var sheep:HeroAnimation;
    private var scrollBG:ScrollBackground;

    public function InGameScreen()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize)
    }

    private function initialize(event:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, initialize);

        scrollBG = new ScrollBackground();
        addChild(scrollBG);

        sheep = new HeroAnimation();
        sheep.scaleX = sheep.scaleY = 0.25;
        sheep.x = 150;
        sheep.y = stage.stageHeight/2;
        addChild(sheep);

    }
}
}
