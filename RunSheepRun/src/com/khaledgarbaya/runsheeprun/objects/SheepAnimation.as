/**
 * ...
 * @author kgarbaya
 * @copyright (c) Khaled Garbaya
 */
package com.khaledgarbaya.runsheeprun.objects {
import com.khaledgarbaya.runsheeprun.Game;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;

import flash.display.Loader;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import starling.display.Sprite;
import starling.events.Event;

public class SheepAnimation extends Sprite
{
    private  var loader: URLLoader;
    private var factory:StarlingFactory;
    private var armature:Armature;
    [Embed(source = "../../../../assets/animation/sheep_animation.png", mimeType = "application/octet-stream")]
    private static const ResourcesData:Class;
    public function SheepAnimation()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:Event):void
    {
        // load dragonBones Animation
//        loader = new URLLoader();
//        loader.dataFormat = URLLoaderDataFormat.BINARY;
//        loader.addEventListener(Event.COMPLETE, loadComplete);
//        loader.load(new URLRequest("./assets/"))

        loadComplete(null)
    }

    private function loadComplete(event:Event):void
    {
        factory = new StarlingFactory();
        factory.addEventListener(Event.COMPLETE, textureCompleteHandler);
        factory.parseData(new ResourcesData());
    }

    private function textureCompleteHandler(event:Event):void
    {
        armature = factory.buildArmature("sheep_animation");
        addChild(armature.display as Sprite);
        WorldClock.clock.add(armature);
        armature.animation.gotoAndPlay("run");
        addEventListener(Event.ENTER_FRAME, tick);
    }

    private function tick(event:Event):void
    {
        WorldClock.clock.advanceTime(-1);
    }
}
}
