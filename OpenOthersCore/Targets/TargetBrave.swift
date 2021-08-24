//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static var brave: OpenTarget { Brave() }
}

public final class Brave : OpenTarget {
    
    public convenience init() {
    
        let name = "Brave"
        let bundleIdentifier = "com.brave.Browser"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
