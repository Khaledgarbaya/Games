/**
 *
 * Created by kgar on 03/01/16.
 * Copyright (c) 2016 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
    import starling.display.Sprite;
    import starling.events.Event;

    public class Hero extends Sprite
    {
        private var heroAnimation;
        private var baloons: Vector.<Baloon>;
        public function Hero()
        {
            baloons = new Vector.<Baloon>();
            this.addEventListener(Event.ADDED_TO_STAGE, initialize)
        }

        private function initialize(event:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, initialize);

            addChild(heroAnimation);
        }

        public function addBaloon():void
        {
            baloons.push(new Baloon());
        }

        public function removeBaloon():void
        {
            baloons.pop();
        }
    }
}
