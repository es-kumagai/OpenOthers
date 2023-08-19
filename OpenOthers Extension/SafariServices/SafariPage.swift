//
//  SafariPage.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import SafariServices

extension SFSafariPage {
    
    @MainActor
    var properties: SFSafariPageProperties {
        
        get async throws {

            try await withCheckedThrowingContinuation { continuation in
                
                getPropertiesWithCompletionHandler { properties in
                    
                    guard let properties else {

                        return continuation.resume(throwing: SafariError.propertiesNotFound(in: self))
                    }
                                        
                    continuation.resume(returning: properties)
                }
            }
        }
    }
}
