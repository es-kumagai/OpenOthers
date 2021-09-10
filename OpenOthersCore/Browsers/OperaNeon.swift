//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let operaNeon = OperaNeon()
    static let operaNeonSecretMode = OperaNeon(secretMode: true)
}

public final class OperaNeon : OpenTarget {
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = "com.opera.Neon"
        let mode: Mode = secretMode ? .secret : .normal
        let arguments: Array<OpenTarget.Argument>
        let createNewInstance: Bool

        switch secretMode {
        
        case false:
            name = "Opera Neon"
            createNewInstance = true
            arguments = [.targetURL]

        case true:
            name = "Opera Neon (Secret Mode)"
            createNewInstance = true
            arguments = ["-incognito", .targetURL]
        }

        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
}
