//
//  Targets.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import AppKit
import OpenTargets

internal var workspace = NSWorkspace.shared

public enum Targets {}

public extension Targets {
    
    static var all: Array<OpenTarget> = [
        
        .googleChrome,
        .googleChromeSecretMode,
        .firefox,
        .brave,
    ]
    
    static var selectable: [OpenTarget] {
        
        all.filter { target in

            workspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) != nil
        }
    }
    
    static var selectableTargetListItems: [TargetListItem] {
        
        Targets.selectable.map { TargetListItem(target: $0, iconImage: $0.bundle?.iconImage) }
    }
}
