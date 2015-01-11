/**
 *
 * Created by kgar on 01/01/15.
 * Copyright (c) 2015 kgar. All rights reserved.
 */
package com.khaledgarbaya.utils
{
public class Logger
{
    private static const INFO_TAG:String = "[INFO]: ";
    private static const ERROR_TAG:String = "[ERROR]: ";

    public static function info(msg:*):void
    {
//			if (!Capabilities.isDebugger)
//				return;
        trace(INFO_TAG, msg);
    }

    public static function error(msg:*):void
    {
//			if (!Capabilities.isDebugger)
//				return;
        trace(ERROR_TAG, msg);
    }

}

}