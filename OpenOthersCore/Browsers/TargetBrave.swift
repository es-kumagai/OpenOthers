//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

public extension OpenTarget {
    
    static let brave = Brave()
    static let braveSecretMode = Brave(secretMode: true)
}

public final class Brave : OpenTarget {
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = "com.brave.Browser"
        let mode: Mode = secretMode ? .secret : .normal
        let arguments: Array<OpenTarget.Argument>
        let createNewInstance: Bool

        switch secretMode {
        
        case false:
            name = "Brave"
            createNewInstance = true
            arguments = [.targetURL]

        case true:
            name = "Brave (Secret Mode)"
            createNewInstance = true
            arguments = ["-incognito", .targetURL]
        }

        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
}
