//
//  Bundle.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import AppKit

extension Bundle {
    
    var extensionHostURL: URL! {
        
        bundleURL.deletingLastPathComponent().appendingPathComponent("OpenOthers.app")
    }
    
    var bundleForExtensionHost: Bundle! {
        
        extensionHostURL.flatMap(Bundle.init(url:))
    }
}
