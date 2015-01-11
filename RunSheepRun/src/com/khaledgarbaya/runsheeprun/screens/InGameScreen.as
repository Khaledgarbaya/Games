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
import com.khaledgarbaya.runsheeprun.objects.SheepAnimation;

import starling.display.Sprite;
import starling.events.Event;

public class InGameScreen extends Sprite
{
    private var sheep:SheepAnimation;
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

        sheep = new SheepAnimation();
        sheep.scaleX = sheep.scaleY = 0.25;
        sheep.x = 150;
        sheep.y = stage.stageHeight - stage.stageHeight / 4;
        addChild(sheep);

        //Add Gesture recognition
        var gesture:Gesture = new SwipeGesture(onSwipeRec);
        GestureManager.add(this, new GestureVars().onSwipe(gesture).vars);
    }

    private function onSwipeRec(e:AcheGestureEvent):void
    {
        if(e.dy < 0)
        {
            sheep.jump();
        }
    }
}
}
