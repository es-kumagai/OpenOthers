//
//  AppDelegate.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import CoreServices
import OpenOthersCore

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var bundleState = BundleState()
    
    func applicationDidFinishLaunching(_ notification: Notification) {

        bundleState.runningHostBundleDate = Bundle.main.modificationDate
    }

    func applicationWillTerminate(_ notification: Notification) {

        bundleState.runningHostBundleDate = nil
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
