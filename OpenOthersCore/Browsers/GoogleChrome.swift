//
//  TargetGoogleChrome.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

public extension OpenTarget {
    
    static let googleChrome = GoogleChrome()
    static let googleChromeSecretMode = GoogleChrome(secretMode: true)
}

public final class GoogleChrome : OpenTarget {
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = "com.google.Chrome"
        let mode: Mode = secretMode ? .secret : .normal
        let arguments: Array<OpenTarget.Argument>
        let createNewInstance: Bool

        switch secretMode {
        
        case false:
            name = "Google Chrome"
            createNewInstance = true
            arguments = [.targetURL]

        case true:
            name = "Google Chrome (Secret Mode)"
            createNewInstance = true
            arguments = ["-incognito", .targetURL]
        }

        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
}
