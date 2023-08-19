//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

public extension OpenTarget {
    
    static let vivaldi = Vivaldi()
}

public final class Vivaldi : OpenTarget {
    
    public convenience init() {
    
        let name = "Vivaldi"
        let bundleIdentifier = "com.vivaldi.Vivaldi"
        let mode = Mode.normal
        let arguments: Array<OpenTarget.Argument> = [
            
            .targetURL,
        ]

        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: true)
    }
}
