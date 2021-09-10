//
//  AppDelegate.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import Sky_AppKit
import Ocean
import OpenOthersCore

@main @objcMembers
class AppDelegate: NSObject, NSApplicationDelegate, NotificationObservable {

    var notificationHandlers = Notification.Handlers()
    
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
        
        observe(OpenRequestDidFinishNotification.self) { [unowned self] notification in
            
            DispatchQueue.main.sync {

                terminateLaunchBundledOpenOthersHostApp()
                NSApp.terminate(self)
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {

        notificationHandlers.releaseAll()

        schemeManager = nil
        terminationTimer = nil
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate {
    
    func updateSelectableTargets() {
    
        targetState.selectableTargetListItems = Targets.selectables.map(TargetListItem.init)
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

        guard let error = error else {
            
            return
        }

        let message: String
        
        switch error {
        
        case let error as URLSchemeActionError:
            message = "\(error)"

        case let error:
            message = error.localizedDescription
        }

        NSApp.showAlert("\(message) on \(scheme)", caption: "An error occurs during invoking URL scheme action")
    }
    
    func urlSchemeManager(_ manager: URLSchemeManager, handlingDidFinishWithMatchingCount matchingCount: Int) {

        if matchingCount == 0 {

            OpenRequestDidFinishNotification().post()
        }
    }
}
