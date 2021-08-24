//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let firefox = Firefox()
}

public final class Firefox : OpenTarget {
    
    public convenience init() {
    
        let name = "Firefox"
        let bundleIdentifier = "org.mozilla.firefox"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
