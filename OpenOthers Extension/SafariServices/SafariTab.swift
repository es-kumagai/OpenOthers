//
//  SafariTab.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

@preconcurrency import SafariServices

extension SFSafariTab {
    
    @MainActor
    var activePage: SFSafariPage {
        
        get async throws {
            
            try await withCheckedThrowingContinuation { continuation in
                
                getActivePage { page in
                    
                    guard let page else {
                        
                        return continuation.resume(throwing: SafariError.pageNotFound(on: self))
                    }
                    
                    continuation.resume(returning: page)
                }
            }
        }
    }
    
    @MainActor
    var activePageProperties: SFSafariPageProperties {

        get async throws {
            
            try await activePage.properties
        }
    }
}
