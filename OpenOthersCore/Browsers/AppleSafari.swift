//
//  TargetGoogleChrome.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import OpenTargets

public extension OpenTarget {
    
    static let appleSafari = AppleSafari()
    static let appleSafariSecretMode = AppleSafari(secretMode: true)
}

public final class AppleSafari : OpenTarget {
    
    public static let bundleIdentifier = "com.apple.Safari"
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = Self.bundleIdentifier
        let mode: Mode
        let arguments: Array<OpenTarget.Argument> = []
        let createNewInstance: Bool = false

        switch secretMode {
        
        case false:
            name = "Apple Safari"
            mode = .normal
            
        case true:
            name = "Apple Safari (Secret Mode)"
            mode = .secret
        }
        
        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
}
