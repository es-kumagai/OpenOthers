//
//  Targets.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import AppKit
import OpenOthersCore

@MainActor
internal var workspace = NSWorkspace.shared

extension Targets {
    
    @MainActor
    static var selectables: [OpenTarget] {
        
        return all.filter { target in
            
            return workspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) != nil
        }
    }
}
