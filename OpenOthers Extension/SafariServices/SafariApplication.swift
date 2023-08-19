//
//  SafariApplication.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import SafariServices

extension SFSafariApplication {
    
    @MainActor
    static var activeWindow: SFSafariWindow {
        
        get async throws {
            
            try await withCheckedThrowingContinuation { continuation in
                
                getActiveWindow { window in
                    
                    guard let window else {
                        
                        return continuation.resume(throwing: SafariError.windowNotFound)
                    }
                    
                    continuation.resume(returning: window)
                }
            }
        }
    }
}
