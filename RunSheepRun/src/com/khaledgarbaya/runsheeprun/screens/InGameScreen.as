/**
 * ...
 * @author kgarbaya
 * @copyright (c) Khaled Garbaya
 */
package com.khaledgarbaya.runsheeprun.screens {
import acheGesture.GestureManager;
import acheGesture.data.Gesture;
import acheGesture.data.GestureVars;
import acheGesture.data.SwipeGesture;
import acheGesture.events.AcheGestureEvent;

import com.khaledgarbaya.runsheeprun.Game;
import com.khaledgarbaya.runsheeprun.objects.SheepAnimation;

import flash.media.SoundTransform;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class InGameScreen extends Sprite {
    private var cloud:Image;
    private var grasse:Image;
    private var route:Image;
    private var routes:Vector.<Image>;
    private var sheep:SheepAnimation;

    public function InGameScreen() {
        this.addEventListener(Event.ADDED_TO_STAGE, initialize)
    }

    private function initialize(event:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
        //Game.gameAsset.playSound("music_game_intro", 0, 9999, new SoundTransform(0.2));
        grasse = new Image(Game.gameAsset.getTexture("grass"));
        grasse.y = stage.stageHeight - grasse.texture.height;
        addChild(grasse);

        routes = new Vector.<Image>();
        for (var i:uint = 0; i < 4; ++i) {
            route = new Image(Game.gameAsset.getTexture("route"));
            route.y = (stage.stageHeight - route.texture.height ) - route.texture.height / 3;
            route.x += i == 0 ? -3 : routes[i - 1].x + routes[i - 1].texture.width - 3;
            addChild(route);
            routes.push(route);
        }

        cloud = new Image(Game.gameAsset.getTexture("cloud"));
        addChild(cloud);

        sheep = new SheepAnimation();
        sheep.scaleX = sheep.scaleY = 0.5;
        sheep.x = 150;
        sheep.y = routes[0].y + routes[0].texture.height / 4;
        addChild(sheep);

        //Add Gesture recognition
        var gesture:Gesture = new SwipeGesture(onSwipeRec);
        GestureManager.add(this, new GestureVars().onSwipe(gesture).vars);
    }

    private function onSwipeRec(e:AcheGestureEvent):void {
        trace("onSwipe",e.dx);
        trace("onSwipe",e.dy);
        sheep.jump();
    }
}
}
