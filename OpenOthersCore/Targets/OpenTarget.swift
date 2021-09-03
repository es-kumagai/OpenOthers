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

public extension TargetListItem {
    
    convenience init(target: OpenTarget) {
        
        self.init(target: target, iconImage: target.bundle?.iconImage)
    }
}

public extension Sequence where Element == OpenTarget {
    
    func contains(bundleURL: URL?) -> Bool {
        
        map(\.bundleURL).contains(bundleURL)
    }
}
