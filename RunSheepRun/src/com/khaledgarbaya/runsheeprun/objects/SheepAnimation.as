/**
 * ...
 * @author kgarbaya
 * @copyright (c) Khaled Garbaya
 */
package com.khaledgarbaya.runsheeprun.objects {
import com.khaledgarbaya.runsheeprun.Game;
import com.khaledgarbaya.utils.Logger;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;

import flash.display.Loader;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.events.TransformGestureEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;

public class SheepAnimation extends Sprite
{
    private  var loader: URLLoader;
    private var factory:StarlingFactory;
    private var armature:Armature;
    private var sheepDisplay:Sprite;
    private var isJumping:Boolean = false;

    //Jump params
    private static const DEFAULT_DIRECTION: int = -1;
    private static const DEFAULT_VELOCITY: int = 70;
    private var tempY:Number;
    private var friction :Number = .75; //how fast to slow down / speed up - the lower the number the quicker (must be less than 1, and more than 0 to work properly)
    private var velocity :Number = DEFAULT_VELOCITY;  //how much to move every increment, reset every jump to default value
    private var direction   :int = DEFAULT_DIRECTION;  //reset this to -1 every time the jump starts

    public function SheepAnimation()
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

        armature.animation.gotoAndPlay("run");
        addEventListener(starling.events.Event.ENTER_FRAME, tick);
    }


    private function tick(event:starling.events.Event):void
    {
        if(!isJumping && armature.animation.lastAnimationName == "bounce")
        {
            armature.animation.gotoAndPlay("run",0.1);
        }else if(isJumping)
        {
            jumpLoop();
        }
        WorldClock.clock.advanceTime(-1);
    }

    public function jump(): void
    {
        if(!isJumping)
        {
            tempY = sheepDisplay.y;
            isJumping = true;
        }

        armature.animation.gotoAndPlay("bounce");
    }

    function jumpLoop(){ //lets assume this is running every frame while jumping
        sheepDisplay.y += velocity * direction; //take the current velocity, and apply it in the current direction
        if(direction < 0){
            velocity *= friction; //reduce velocity as player ascends
        }else{
            velocity *= 1 + (1 - friction); //increase velocity now that player is falling
        }

        if(velocity < 1) direction = 1; //if player is moving less than 1 pixel now, change direction
        if(sheepDisplay.y > tempY){  //stage.stageheight being wherever your floor is
            sheepDisplay.y = tempY; //put player on the floor exactly
            //jump is over, stop the jumpLoop
            isJumping = false;
            direction = DEFAULT_DIRECTION;
            velocity = DEFAULT_VELOCITY;
        }
    }
}
}
