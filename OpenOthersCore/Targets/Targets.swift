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
    
    static var all: [OpenTarget] {
    
        let targetClass = ObjCRuntime.Class(OpenTarget.self)
        let targets = targetClass.classMethods.compactMap {
            
            targetClass.messageSendToClassMethod($0) as? OpenTarget
        }
        
        return targets
    }
    
    static var selectables: [OpenTarget] {
        
        all.filter { target in

            workspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) != nil
        }
    }
}
