//
//  AppDelegate.swift
//  MenuCalendar
//
//  Created by Masanori Kuze on 2017/08/14.
//  Copyright © 2017年 Masanori Kuze. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    
    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: "CalendarViewImage")
            button.action = #selector(togglePopover(sender:))
        }
        
        popover.contentViewController = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        
        // パネル以外でマウスをクリックしたらパネルを隠す
        popover.behavior = .transient

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }

}

