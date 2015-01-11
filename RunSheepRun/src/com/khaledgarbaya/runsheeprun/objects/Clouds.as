/**
 *
 * Created by kgar on 10/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
import com.khaledgarbaya.runsheeprun.Game;
import com.khaledgarbaya.runsheeprun.objects.impl.IScrollable;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class Clouds extends Sprite implements IScrollable
{
    private var clouds:Vector.<Image>;
    private var cloud:Image;

    public function Clouds()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, intiialize);
    }

    private function intiialize(event:Event):void
    {
        this.removeEventListeners(Event.ADDED_TO_STAGE);
        clouds = new Vector.<Image>();
        for(var i:uint = 0; i < 6; ++i)
        {
            cloud = new Image(Game.gameAsset.getTexture("cloud"));
            cloud.x = i * cloud.texture.width + 40;
            cloud.y = 20 + Math.random() * 50;
            addChild(cloud);
            clouds.push(cloud);
        }
    }

    public function scroll():void
    {
        var len:int = clouds.length;
        var cloud:Image;
        for(var i:uint = 0; i < len; i++)
        {
            cloud = clouds[i];
            cloud.x--;
            if(cloud.x <= -cloud.width)
            {
                cloud.x = stage.stageWidth + 20;
            }
        }
    }
}
}
