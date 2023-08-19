//
//  SafariWindow.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices

extension SFSafariWindow {
    
    @MainActor
    var activeTab: SFSafariTab {
        
        get async throws {
            
            try await withCheckedThrowingContinuation { continuation in
                
                getActiveTab { tab in
                    
                    guard let tab else {
                        
                        return continuation.resume(throwing: SafariError.tabNotFound(on: self))
                    }
                    
                    continuation.resume(returning: tab)
                }
            }
        }
    }
    
    @MainActor
    var activePage: SFSafariPage {

        get async throws {
            
            try await activeTab.activePage
        }
    }
    
    @MainActor
    var activePageProperties: SFSafariPageProperties {
        
        get async throws {
            
            try await activeTab.activePageProperties
        }
    }
}
