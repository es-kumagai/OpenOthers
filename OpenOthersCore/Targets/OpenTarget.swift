//
//  OpenTarget.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import AppKit
import OpenTargets

internal extension OpenTarget {
    
    var workspace: NSWorkspace { .shared }
}

public extension OpenTarget {
    
    var bundleURL: URL? {
    
        workspace.urlForApplication(withBundleIdentifier: bundleIdentifier)
    }
    
    var bundle: Bundle? {
    
        bundleURL.flatMap(Bundle.init(url:))
    }
}