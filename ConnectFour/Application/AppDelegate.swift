//
//  AppDelegate.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window = NSWindow(contentRect: NSRect(x: 500,
                                                   y: 200,
                                                   width: 700, height: 700),
                               styleMask: [.closable, .titled],
                               backing: .buffered,
                               defer: false)
        let controller = BoardGameViewController()
        self.window?.contentViewController = controller
        self.window?.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
