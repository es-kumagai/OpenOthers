//
//  OpenOthersScheme.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import Sky_AppKit
import OpenTargets
import OpenOthersCore
import Swim

final class OpenOthersScheme : URLScheme {

    internal static var workspace = NSWorkspace.shared
    
    static let scheme = basicScheme
    static let host = "open"
    
    static func action(url: URL) throws {

        let decoder = Base64Decoder()
        
        guard let pageURL = url.queries["url"].flatMap(decoder.url(from:)) else {
            
            throw URLSchemeActionError.invalidURL(url, description: "It was not specified that a url to open")
        }
        
        guard let targetData = url.queries["target"].flatMap(decoder.data(from:)) else {
            
            throw URLSchemeActionError.invalidURL(url, description: "Received an invalid url scheme")
        }
        
        do {

            let decoder = JSONDecoder()
            let target = try decoder.decode(OpenTarget.self, from: targetData)
            
            guard Targets.selectables.contains(bundleURL: target.bundleURL) else {
            
                throw URLSchemeActionError.invocationFailure(description: "The specified target '\(target)' is not allowed")
            }
            
            OpenRequestDetectedNotification(target: target, url: url).post()
            
            let waitingForOpeningSemaphore = DispatchSemaphore(value: 0)
            
            target.open(with: pageURL) { result in

                waitingForOpeningSemaphore.signal()
                
                switch result {
                
                case .success(let application):
                    NSLog("Target application has been opened: %@", application.bundleIdentifier ?? "(null)")
                    
                case .failure(let error):
                    NSLog("Error: %@", error.localizedDescription)
                }
            }
            
            waitingForOpeningSemaphore.wait()
        }
        catch let error as URLSchemeActionError {

            throw error
        }
        catch let error as DecodingError {
            
            throw URLSchemeActionError.invocationFailure(description: "Failed to decode the target data: \(error.localizedDescription)")
        }
        catch {
            
            throw URLSchemeActionError.invocationFailure(description: "Unexpected error: \(error.localizedDescription)")
        }
    }
}
