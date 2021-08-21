//
//  TargetGoogleChrome.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import OpenTargets

public extension OpenTarget {
    
    static var googleChrome: OpenTarget { GoogleChrome() }
    static var googleChromeSecretMode: OpenTarget { GoogleChromeSecretMode() }
}

public final class GoogleChrome : OpenTarget {
    
    public init() {
    
        let name = "Google Chrome"
        let bundleIdentifier = "com.google.Chrome"
        let arguments: Array<OpenTargetArgument> = [
            
            .targetURL,
        ]

        super.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: false)
    }
    
    public required init(from decoder: Decoder) throws {
        
        try super.init(from: decoder)
    }
}

public final class GoogleChromeSecretMode : OpenTarget {

    public init() {
    
        let name = "Google Chrome (Secret Mode)"
        let bundleIdentifier = "com.google.Chrome"
        let arguments: Array<OpenTargetArgument> = [
            
            "-incognito",
            .targetURL,
        ]

        super.init(name: name, bundleIdentifier: bundleIdentifier, arguments: arguments, createNewInstance: true)
    }
    
    public required init(from decoder: Decoder) throws {
        
        try super.init(from: decoder)
    }
}
