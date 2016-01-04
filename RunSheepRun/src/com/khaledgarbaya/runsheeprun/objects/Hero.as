/**
 *
 * Created by kgar on 03/01/16.
 * Copyright (c) 2016 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.objects
{
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.deg2rad;

    public class Hero extends Sprite
    {
        private var heroAnimation;
        private var baloons: Vector.<Baloon>;
        private var _currentDate:Date;
        public function Hero()
        {
            baloons = new Vector.<Baloon>();
            heroAnimation = new HeroAnimation();
            this.addEventListener(Event.ADDED_TO_STAGE, initialize)
        }

        private function initialize(event:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
            this.addEventListener(starling.events.Event.ENTER_FRAME, tick);

            addChild(heroAnimation);
            addBaloon();
            addBaloon();
            addBaloon();
            addBaloon();
            addBaloon();
            addBaloon();
        }

        public function addBaloon():void
        {
            var b: Baloon = new Baloon();
            b.rotation = deg2rad(random(-20,20));
            addChild(b);
            addChild(heroAnimation);
            baloons.push(b);
        }

        public function removeBaloon():void
        {
            var b: Baloon = baloons.shift();
            removeChild(b);
        }

        public function tick(e:Event):void
        {
            // cos movement
            _currentDate = new Date();
            this.y = 140 + (Math.cos(_currentDate.getTime() * 0.002)) * 5;
            heroAnimation.tick()
        }
        private function random(min:Number, max:Number):Number
        {
            return min + Math.random() * (max - min);
        }
    }
}
