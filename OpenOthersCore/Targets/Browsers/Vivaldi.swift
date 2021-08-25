//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let vivaldi = Vivaldi()
}

public final class Vivaldi : OpenTarget {
    
    public convenience init() {
    
        let name = "Vivaldi"
        let bundleIdentifier = "com.vivaldi.Vivaldi"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
