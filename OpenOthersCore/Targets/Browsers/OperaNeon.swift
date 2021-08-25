//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let operaNeon = OperaNeon()
}

public final class OperaNeon : OpenTarget {
    
    public convenience init() {
    
        let name = "Opera Neon"
        let bundleIdentifier = "com.opera.Neon"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
