//
//  Bundle.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import AppKit

public extension Bundle {
    
    var bundleAttributes: [FileAttributeKey : Any]? {
    
        try? FileManager.default.attributesOfItem(atPath: bundleURL.path)
    }
    
    var modificationDate: Date? {
        
        bundleAttributes?[.modificationDate] as? Date
    }
}
