//
//  AppDelegate.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import CoreServices

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {

        guard let bundleForLauncher = Bundle.main.bundleForLauncher else {
            
            NSLog("Launcher application did not found.")
            return
        }
        
        let workspace = NSWorkspace.shared
        let launcherProcesses = workspace.runningApplications.filter { $0.bundleIdentifier == bundleForLauncher.bundleIdentifier }
        
        if launcherProcesses.isEmpty {

            // To open launcher outside of the sandbox, uses Process instead of NSWorkspace.openApplication.
            let process = Process()

            process.launchPath = "/usr/bin/open"
            process.arguments = ["-a", bundleForLauncher.bundlePath]
            process.launch()
        }
    }

    func applicationWillTerminate(_ notification: Notification) {

    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
