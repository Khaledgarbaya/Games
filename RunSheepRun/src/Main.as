package {
import com.khaledgarbaya.runsheeprun.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.utils.ByteArray;
    import flash.utils.setTimeout;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.RenderTexture;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.SystemUtil;
    import starling.utils.formatString;
	
	import utils.ProgressBar;
	import com.khaledgarbaya.utils.Logger;
    /**
     * ...
     * @author kgarbaya
     * @copyright (c) Khaled Garbaya
     */
	[SWF(width="480", height="320", frameRate="60", backgroundColor="#57BDE3")]
	public class Main extends Sprite
	{
		private const StageWidth:int  = 480;
        private const StageHeight:int = 320;

        private var mStarling:Starling;
        private var mBackground:Loader;
        private var mProgressBar:ProgressBar;
        //set to empty when testing on device
        private const BASE_PATH:String = "./assets/";

		public function Main():void 
		{
			Logger.info("Main::Main");
			if (stage == null) 
			{
				this.addEventListener(flash.events.Event.ADDED_TO_STAGE, initialize);
			}
			else 
			{
				initialize(null);
			}
		}
		
		private function initialize(event: flash.events.Event): void
		{
			Logger.info("Main::initialize");
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, initialize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

            var iOS:Boolean = SystemUtil.platform == "IOS";
            var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
            trace("stage.fullScreenWidth ",stage.fullScreenWidth);
            trace("stage.fullScreenHeight ",stage.fullScreenHeight);
            var screenSize:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = new Rectangle(0,0,stage.fullScreenWidth,stage.fullScreenHeight);//RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, iOS);
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640

            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = iOS; // safe on iOS, dangerous on Android

            mStarling = new Starling(Game, stage, viewPort, null, "auto", "auto");
            trace("viewport.width ",viewPort.width);
            trace("viewPort.height ",viewPort.height);
            mStarling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
            mStarling.stage.stageHeight   = StageHeight; // <- same size on all devices!
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.simulateMultitouch  = false;
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function(event: starling.events.Event):void
            {
                loadAssets(scaleFactor, startGame);
            });

            mStarling.start();
            initElements(scaleFactor);

            // When the game becomes inactive, we pause Starling; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated.

            if (!SystemUtil.isDesktop)
            {
                NativeApplication.nativeApplication.addEventListener(
                        flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
                NativeApplication.nativeApplication.addEventListener(
                        flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(true); });
            }
		}
		private function loadAssets(scaleFactor:int, onComplete:Function):void
        {
            // Our assets are loaded and managed by the 'AssetManager'. To use that class,
            // we first have to enqueue pointers to all assets we want it to load.

            var appDir:File = File.applicationDirectory;
            var files:Array = appDir.getDirectoryListing();

            for (var i:uint=0; i<files.length;i++)
            {
                trace(files[i].name);
                trace(files[i].nativePath);
            }
            var assets:AssetManager = new AssetManager(scaleFactor);

            assets.verbose = Capabilities.isDebugger;
            if (!SystemUtil.isDesktop)
            {
                assets.enqueue(
                        appDir.resolvePath(BASE_PATH+"audio"),
                        appDir.resolvePath(formatString(BASE_PATH+"fonts/{0}x", scaleFactor)),
                        appDir.resolvePath(formatString(BASE_PATH+"textures/{0}x", scaleFactor))
                );
            }

            // Now, while the AssetManager now contains pointers to all the assets, it actually
            // has not loaded them yet. This happens in the "loadQueue" method; and since this
            // will take a while, we'll update the progress bar accordingly.

            assets.loadQueue(function(ratio:Number):void
            {
                mProgressBar.ratio = ratio;
                if (ratio == 1) onComplete(assets);
            });
        }

        private function startGame(assets:AssetManager):void
        {
           var game:Game = mStarling.root as Game;
            game.start(assets);
            setTimeout(removeElements, 150);// delay to make 100% sure there's no flickering.
        }

        private function initElements(scaleFactor:int):void
        {
            // Add background image. By using "loadBytes", we can avoid any flickering.

           /* var bgPath:String = formatString("textures/{0}x/background.jpg", scaleFactor);
            var bgFile:File = File.applicationDirectory.resolvePath(bgPath);
            var bytes:ByteArray = new ByteArray();
            var stream:FileStream = new FileStream();
            stream.open(bgFile, FileMode.READ);
            stream.readBytes(bytes, 0, stream.bytesAvailable);
            stream.close();

            mBackground = new Loader();
            mBackground.loadBytes(bytes);
            mBackground.scaleX = 1.0 / scaleFactor;
            mBackground.scaleY = 1.0 / scaleFactor;
            mStarling.nativeOverlay.addChild(mBackground);

            mBackground.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
                function(e:Object):void
                {
                    (mBackground.content as Bitmap).smoothing = true;
                });
            */
            // While the assets are loaded, we will display a progress bar.

            mProgressBar = new ProgressBar(175, 20);
            mProgressBar.x = (StageWidth - mProgressBar.width) / 2;
            mProgressBar.y =  StageHeight * 0.7;
            mStarling.nativeOverlay.addChild(mProgressBar);
        }

        private function removeElements():void
        {
           /* if (mBackground)
            {
                mStarling.nativeOverlay.removeChild(mBackground);
                mBackground = null;
            }*/

            if (mProgressBar)
            {
                mStarling.nativeOverlay.removeChild(mProgressBar);
                mProgressBar = null;
            }
        }
		
	}
	
}