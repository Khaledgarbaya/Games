/**
 *
 * Created by kgar on 03/01/16.
 * Copyright (c) 2016 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
    import com.khaledgarbaya.runsheeprun.Game;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    public class Baloon extends Sprite
    {
        private var baloonImage: Image;
        public function Baloon()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, initialize);
        }

        private function initialize(event:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
            baloonImage = new Image(Game.gameAsset.getTexture("balloon"));
            baloonImage.scaleX =  baloonImage.scaleY = 0.5;
            baloonImage.pivotY = baloonImage.height*2;
            baloonImage.pivotX = baloonImage.width * 0.5;

            this.addChild(baloonImage);
        }
    }
}
