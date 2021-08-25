//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

import OpenTargets

public extension OpenTarget {
    
    static let microsoftEdge = MicrosoftEdge()
}

public final class MicrosoftEdge : OpenTarget {
    
    public convenience init() {
    
        let name = "Microsoft Edge"
        let bundleIdentifier = "com.microsoft.edgemac"
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
}
