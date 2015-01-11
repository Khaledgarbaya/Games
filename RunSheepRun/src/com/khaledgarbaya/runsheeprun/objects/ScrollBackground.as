/**
 *
 * Created by kgar on 10/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
import com.khaledgarbaya.runsheeprun.Game;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

public class ScrollBackground extends Sprite
{
    private var cloud:Clouds;
    private var grass:Image;
    public var route:Route;
    private var grass1:Image;

    public function ScrollBackground()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize);
    }

    private function initialize(event:Event):void
    {
        var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight);
        bg.alpha = 0;
        addChild(bg);
        //Game.gameAsset.playSound("music_game_intro", 0, 9999, new SoundTransform(0.2));
        grass = new Image(Game.gameAsset.getTexture("grass"));
        grass.y = stage.stageHeight - grass.texture.height;
        addChild(grass);

        grass1 = new Image(Game.gameAsset.getTexture("grass"));
        grass1.y = stage.stageHeight - grass1.texture.height;
        grass1.scaleX = -1;
        grass1.x = grass.texture.width * 2;
        addChild(grass1);

        route = new Route();
        addChild(route);
        cloud = new Clouds();
        addChild(cloud);
        addEventListener(Event.ENTER_FRAME, scrollBG);
    }

    private function scrollBG(event:Event):void
    {
        route.scroll();
        cloud.scroll();
        grass.x -= 2;
        grass1.x -= 2;
        if(grass1.x < grass.width)
        {
            grass.x = 0;
            grass1.x = grass.width * 2;
        }
    }
}
}
