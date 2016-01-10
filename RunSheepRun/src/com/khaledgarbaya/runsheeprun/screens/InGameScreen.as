/**
 *
 * Created by kgar on 02/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.screens
{

import com.khaledgarbaya.runsheeprun.objects.Hero;
import com.khaledgarbaya.runsheeprun.objects.ScrollBackground;

    import flash.events.MouseEvent;

    import starling.core.Starling;

    import starling.display.Sprite;
import starling.events.Event;

public class InGameScreen extends Sprite
{
    private var _hero:Hero;
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

        _hero = new Hero();
        _hero.scaleX = _hero.scaleY = 0.25;
        _hero.x = 150;
        _hero.y = stage.stageHeight/2;
        addChild(_hero);
        Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, onHeroTriggered);
    }

    private function onHeroTriggered(event:MouseEvent):void
    {
        _hero.removeBaloon();
    }
}
}
