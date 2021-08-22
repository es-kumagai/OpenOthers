//
//  Launcher.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import AppKit
import OpenOthersCore

extension AppDelegate {
    
    /// To register url schemes, launch OpenOthersLauncher.app embedded in main bundle at least once.
    func launchBundledOpenOthersHostAppOnce() {
        
        guard let hostBundle = Bundle.main.bundleForExtensionHost else {
            
            NSApp.showAlert("", caption: "Host application did not found.")
            return
        }
        
        let workspace = NSWorkspace.shared
        let hostProcesses = workspace.runningApplications.filter { $0.bundleIdentifier == hostBundle.bundleIdentifier }
        
        func openBundledOpenOthersHostApp() {
            
            let configuration = NSWorkspace.OpenConfiguration()
            
            workspace.openApplication(at: hostBundle.bundleURL, configuration: configuration) { application, error in
                
                if let application = application {
                    
                    self.hostApplicationLaunchedByLauncher = application
                }
                
                if let error = error {
                    
                    NSApp.showAlert(error.localizedDescription, caption: "Failed to open Host App.")
                }
            }
        }
        
        func terminateAllRunningHostApps() {
            
        }
        
        if hostProcesses.isEmpty {

            openBundledOpenOthersHostApp()
        }
        else {
            
            let runningHostProcesses = hostProcesses.compactMap(\.bundleURL).compactMap(Bundle.init(url:))
            
            guard let storedHostBundleDate = runningHostProcesses.compactMap(\.modificationDate).sorted(by: >).first else {
                
                return
            }
            
            switch bundleState.runningHostBundleDate {
            
            case let runningHostBundleDate? where storedHostBundleDate > runningHostBundleDate:
                fallthrough
                
            case nil:
                hostProcesses.filter { !$0.isTerminated }.forEach { $0.terminate() }
                openBundledOpenOthersHostApp()

            case _?:
                break
            }
        }
    }
    
    func terminateLaunchBundledOpenOthersHostApp() {
        
        if let hostApplication = hostApplicationLaunchedByLauncher, !hostApplication.isTerminated {
            
            hostApplication.terminate()
        }
        
        hostApplicationLaunchedByLauncher = nil
    }
}
