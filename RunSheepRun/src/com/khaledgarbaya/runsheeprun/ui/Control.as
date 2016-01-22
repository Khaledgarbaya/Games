/**
 *
 * Created by kgar on 22/01/16.
 * Copyright (c) 2016 kgar. All rights reserved.
 */
package com.khaledgarbaya.runsheeprun.ui
{
    import com.khaledgarbaya.runsheeprun.Game;

    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;

    public class Control extends Sprite
    {
        public var onAddTriggered: Function;
        public var onRemoveTriggered: Function;

        private var _addBallonsButton: Button;
        private var _removeBallonsButton: Button;
        private const GAP:Number = 20;

        public function Control()
        {
            super();
            this.addEventListener(Event.ADDED, initialize);
        }

        private function initialize(event:Event):void
        {
            this.removeEventListener(Event.ADDED, initialize);
            _addBallonsButton = new Button(Game.gameAsset.getTexture("addButton"));
            _removeBallonsButton = new Button(Game.gameAsset.getTexture("removeButton"));

            addChild(_addBallonsButton);
            _removeBallonsButton.y = _removeBallonsButton.height + GAP;
            addChild(_removeBallonsButton);

            this.addEventListener(Event.TRIGGERED, onTrigger);
        }

        private function onTrigger(event:Event):void
        {
            switch(event.target)
            {
                case _addBallonsButton:
                        if(onAddTriggered != null)
                            onAddTriggered.call(this);
                    break;
                case _removeBallonsButton:
                        if(onRemoveTriggered != null)
                            onRemoveTriggered.call(this);
                    break;
            }
        }
    }
}
