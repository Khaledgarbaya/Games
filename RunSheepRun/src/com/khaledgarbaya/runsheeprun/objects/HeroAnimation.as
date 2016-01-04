/**
 *
 * Created by kgar on 03/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
import com.khaledgarbaya.runsheeprun.Game;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;

import flash.events.Event;
import flash.net.URLLoader;

import starling.display.Sprite;
import starling.events.Event;

public class HeroAnimation extends Sprite
{
    private var loader:URLLoader;
    private var factory:StarlingFactory;
    private var armature:Armature;
    private var sheepDisplay:Sprite;
    private var isJumping:Boolean = false;
    private var _currentDate;

    //Jump params
    private static const DEFAULT_DIRECTION:int = -1;
    private static const DEFAULT_VELOCITY:int = 70;
    private var tempY:Number;
    private var friction:Number = .75; //how fast to slow down / speed up - the lower the number the quicker (must be less than 1, and more than 0 to work properly)
    private var velocity:Number = DEFAULT_VELOCITY;  //how much to move every increment, reset every jump to default value
    private var direction:int = DEFAULT_DIRECTION;  //reset this to -1 every time the jump starts

    public function HeroAnimation()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:starling.events.Event):void
    {
        loadComplete();
    }

    private function loadComplete():void
    {
        factory = new StarlingFactory();
        factory.addEventListener(flash.events.Event.COMPLETE, textureCompleteHandler);
        factory.parseData(Game.gameAsset.getByteArray("sheep_animation"));
    }

    private function textureCompleteHandler(event:flash.events.Event):void
    {
        armature = factory.buildArmature("sheep_animation");
        sheepDisplay = armature.display as Sprite;
        addChild(sheepDisplay);
        WorldClock.clock.add(armature);

        armature.animation.gotoAndPlay("bounce");
    }


    public function tick():void
    {
        // advance animation ticker
        WorldClock.clock.advanceTime(-1);
    }

}
}
