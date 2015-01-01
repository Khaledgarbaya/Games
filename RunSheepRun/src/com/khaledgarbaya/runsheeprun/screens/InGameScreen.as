/**
 * ...
 * @author kgarbaya
 * @copyright (c) Khaled Garbaya
 */
package com.khaledgarbaya.runsheeprun.screens
{
import com.khaledgarbaya.runsheeprun.Game;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class InGameScreen extends Sprite
    {
        private var cloud: Image;
        private var grasse: Image;
        private var route: Image;
        private var routes: Vector.<Image>;
        public function InGameScreen()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, initialize)
        }

        private function initialize(event:Event): void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, initialize);

            grasse = new Image(Game.gameAsset.getTexture("grass"));
            grasse.y = stage.stageHeight - grasse.texture.height;
            addChild(grasse);

            routes = new Vector.<Image>();
            for(var i: uint = 0; i<4; ++i)
            {
                route = new Image(Game.gameAsset.getTexture("route"));
                route.y = (stage.stageHeight - route.texture.height ) - route.texture.height/3;
                route.x += i == 0 ? 0 : routes[i-1].x+routes[i-1].texture.width;
                addChild(route);
                routes.push(route);
            }

            cloud = new Image(Game.gameAsset.getTexture("cloud"));
            addChild(cloud);
        }
    }
}
