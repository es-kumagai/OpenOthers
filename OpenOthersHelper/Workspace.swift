//
//  Workspace.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

@preconcurrency import AppKit
import OpenOthersCore

extension NSWorkspace {
    
    @discardableResult
    @MainActor
    func openApplication(_ url: URL, with target: OpenTarget) async throws -> NSRunningApplication {

        guard let applicationURL = urlForApplication(withBundleIdentifier: target.bundleIdentifier) else {
        
            throw OpenTarget.Error.notSupported
        }
        
        let arguments = target.arguments.map { argument -> String in
            
            switch argument {
            
            case .string(let string):
                return string
                
            case .targetURL:
                return url.absoluteString
            }
        }
        
        let configuration = OpenConfiguration()
        
        configuration.arguments = arguments
        configuration.createsNewApplicationInstance = target.createNewInstance
        
        do {
            return try await openApplication(at: applicationURL, configuration: configuration)
        } catch {
            throw OpenTarget.Error.failedToLaunch(description: error.localizedDescription)
        }
    }
}
