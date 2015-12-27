//
//  AppDelegate.swift
//  himawari8Wallpaper
//
//  Created by ToKin-Hang on 27/12/2015.
//  Copyright © 2015 to kin hang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
     let mainStoryboard = NSStoryboard(name: "Main", bundle: nil)


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        if let button = statusItem.button{
            button.image = NSImage(named: "AppIcon")
            button.action = Selector("togglePopover:")
        }
        guard let windowController = mainStoryboard.instantiateControllerWithIdentifier("popover") as? NSViewController else {return}
        
        popover.contentViewController = windowController
    }
    

    

    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            popover.performClose(sender)
            
        } else {
            if let button = statusItem.button {
                
                popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
            }
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

