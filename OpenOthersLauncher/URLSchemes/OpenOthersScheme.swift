//
//  OpenOthersScheme.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import Sky_AppKit
import OpenTargets

final class OpenOthersScheme : URLScheme {

    internal static var workspace = NSWorkspace.shared
    
    #if DEBUG
    static let scheme = "openothers-beta"
    #else
    static let scheme = "openothers"
    #endif
    
    static let host = "open"
    
    static func action(url: URL) {

        let decoder = Base64Decoder()
        
        guard let pageURL = url.queries["url"].flatMap(decoder.url(from:)) else {
            
            fatalError("It was not specified that a url to open.")
        }
        
        guard let targetData = url.queries["target"].flatMap(decoder.data(from:)) else {
            
            fatalError("Received an invalid url scheme: \(url)")
        }
        
        do {

            let decoder = JSONDecoder()
            let target = try decoder.decode(OpenTarget.self, from: targetData)
            
            target.open(with: pageURL) { result in
                
            }
            return
            let applicationURL = workspace.urlForApplication(withBundleIdentifier: "com.google.Chrome")!
            let configuration = NSWorkspace.OpenConfiguration()
            
            configuration.createsNewApplicationInstance = true
            configuration.arguments = [
                "-incognito",
                "https://yahoo.co.jp",
            ]
            
            workspace.openApplication(at: applicationURL, configuration: configuration) { application, error in
                
                NSLog("Application: %@", application?.bundleIdentifier ?? "")
                NSLog("Error: %@", error?.localizedDescription ?? "")
            }
        }
        catch let error as DecodingError {
            
            fatalError("Failed to decode the target data: \(error)")
        }
        catch {
            
            fatalError("Unexpected error: \(error)")
        }
    }
}
