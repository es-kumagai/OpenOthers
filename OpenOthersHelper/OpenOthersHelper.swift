//
//  OpenOthersHelper.swift
//  OpenOthersHelper
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import AppKit
import OpenOthersCore

/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
public class OpenOthersHelper: NSObject, OpenOthersHelperProtocol {
    
    static let currentWorkspace = NSWorkspace.shared
    
    public func allTargets() async -> OpenTargets {
        OpenTargets(Targets.all)
    }
    
    public func selectableTargets() async -> OpenTargets {
        await OpenTargets(Targets.selectables)
    }
    
    @MainActor
    public func iconImage(for target: OpenTarget) async -> NSImage? {
        
        let bundle = Bundle(for: target)
        return bundle?.iconImage
    }

    /// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
    @MainActor
    public func open(_ target: OpenTarget, pageURL: URL) async -> Bool {
        
        do {
            
            let application = try await OpenOthersHelper.currentWorkspace.openApplication(pageURL, with: target)

            NSLog("Target application has been opened: %@", application.bundleIdentifier ?? "(null)")
            return true
        }
        catch {
            
            NSLog("Error: %@", error.localizedDescription)
            return false
        }
    }
}
