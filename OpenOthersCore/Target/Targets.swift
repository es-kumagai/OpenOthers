//
//  Targets.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import AppKit

public enum Targets {}

public extension Targets {
    
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
}
