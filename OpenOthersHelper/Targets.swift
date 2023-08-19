//
//  Targets.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import AppKit
import OpenOthersCore

public enum Targets {
        
    static var all: [OpenTarget] {
    
        let ignoreMethodNames = [
            "supportsSecureCoding",
            "setSupportsSecureCoding:",
        ]
        
        let targetClass = ObjCRuntime.Class(OpenTarget.self)
        let targets = targetClass.classMethods.compactMap { (method) -> OpenTarget? in
            
            guard !ignoreMethodNames.contains(method.name) else {
                return nil
            }
            
            NSLog("Resolving a target by calling static method: \(method.name)")
            return targetClass.messageSendToClassMethod(method) as? OpenTarget
        }
        
        NSLog("All targets has been resolved.")
        return targets
    }

    @MainActor
    static var selectables: [OpenTarget] {
        
        return all.filter { target in
            
            OpenOthersHelper.currentWorkspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) != nil
        }
    }
}
