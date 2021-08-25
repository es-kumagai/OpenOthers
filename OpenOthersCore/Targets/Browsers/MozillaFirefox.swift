//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let mozillaFirefox = MozillaFirefox()
}

public final class MozillaFirefox : OpenTarget {
    
    public convenience init() {
    
        let name = "Mozilla Firefox"
        let bundleIdentifier = "org.mozilla.firefox"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
