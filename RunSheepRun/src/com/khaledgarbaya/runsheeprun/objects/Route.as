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

public class Route extends Sprite implements IScrollable
{
    private var routes:Vector.<Image>;
    private var route:Image;

    public function Route()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:Event):void
    {
        routes = new Vector.<Image>();
        for(var i:uint = 0; i < 4; ++i)
        {
            route = new Image(Game.gameAsset.getTexture("route"));
            route.y = (stage.stageHeight - route.texture.height ) - route.texture.height / 3;
            route.x += i == 0 ? -3 : routes[i - 1].x + routes[i - 1].texture.width - 3;
            addChild(route);
            routes.push(route);
        }
    }

    public function scroll():void
    {
        this.x -= 4;
        if(this.x <= -(this.width - stage.stageWidth))
        {
            this.x = 0;
        }
    }
}
}
