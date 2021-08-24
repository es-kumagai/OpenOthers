//
//  AppDelegate.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import Sky_AppKit
import OpenOthersCore

@main @objcMembers
class AppDelegate: NSObject, NSApplicationDelegate {

    let bundleState = BundleState()
    var targetState = TargetsState()
    
    var hostApplicationLaunchedByLauncher: NSRunningApplication?
    var schemeManager: URLSchemeManager!
    var terminationTimer: Timer!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        updateSelectableTargets()
        
        schemeManager = URLSchemeManager(schemes: [OpenOthersScheme.self])
        schemeManager.delegate = self
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        launchBundledOpenOthersHostAppOnce()
                
        terminationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(autoTerminationChecker(_:)), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {

        schemeManager = nil
        terminationTimer = nil
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate {
    
    func updateSelectableTargets() {
    
        targetState.selectableTargetListItems = Targets.selectableTargetListItems
    }
    
    /// Terminates launcher process automatically when the host application is terminated.
    /// - Parameter timer: The timer that invoked this method.
    func autoTerminationChecker(_ timer: Timer) {
        
        guard !schemeManager.handlingProcessInProgress else {
            
            return
        }
        
        guard let hostBundle = NSWorkspace.shared.urlForApplication(withBundleIdentifier: hostBundleIdentifier).flatMap(Bundle.init(url:)) else {
            
            return
        }
        
        let hostApplications = NSWorkspace.shared.runningApplications.filter { $0.bundleIdentifier == hostBundle.bundleIdentifier }
        
        if hostApplications.isEmpty {

            timer.invalidate()
            NSApp.terminate(self)
        }
    }
}

extension AppDelegate : URLSchemeManagerDelegate {
    
    func urlSchemeManager(_ manager: URLSchemeManager, schemeDidHandle scheme: URLScheme.Type, errorIfOccurs error: Error?) {
        
        if let error = error {
            
            NSApp.showAlert("\(error.localizedDescription) on \(scheme)", caption: "An error occurs during invoking URL scheme action.")
            return
        }
    }
    
    func urlSchemeManager(_ manager: URLSchemeManager, handlingDidFinishWithMatchingCount matchingCount: Int) {

        terminateLaunchBundledOpenOthersHostApp()
        NSApp.terminate(self)
    }
}
