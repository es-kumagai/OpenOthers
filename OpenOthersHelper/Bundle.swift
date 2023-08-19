//
//  Bundle.swift
//  OpenOthersHelper
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import AppKit
import OpenOthersCore

extension Bundle {
    
    @MainActor
    static var currentWorkspace = NSWorkspace.shared
    
    @MainActor
    convenience init?(for target: OpenTarget) {
        
        guard let bundleURL = Self.currentWorkspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) else {
            
            return nil
        }
        
        self.init(url: bundleURL)
    }
    
    var iconImage: NSImage? {

        object(forInfoDictionaryKey: "CFBundleIconFile")
            .flatMap { $0 as? String }
            .flatMap { image(forResource: $0) }
    }
}
