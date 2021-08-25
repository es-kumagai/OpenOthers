//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let mozillaFirefox = MozillaFirefox()
    static let mozillaFirefoxSecretMode = MozillaFirefox(secretMode: true)
}

public final class MozillaFirefox : OpenTarget {
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = "org.mozilla.firefox"
        let arguments: Array<OpenTarget.Argument>
        let createNewInstance: Bool

        switch secretMode {
        
        case false:
            name = "Mozilla Firefox"
            createNewInstance = true
            arguments = [.targetURL]

        case true:
            name = "Mozilla Firefox (Secret Mode)"
            createNewInstance = true
            arguments = ["-private-window", .targetURL]
        }
        
        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: createNewInstance)
    }
}
