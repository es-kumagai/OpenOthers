//
//  TargetBrave.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/25.
//

public extension OpenTarget {
    
    static let microsoftEdge = MicrosoftEdge()
    static let microsoftEdgeSecretMode = MicrosoftEdge(secretMode: true)
}

public final class MicrosoftEdge : OpenTarget {
    
    public convenience init(secretMode: Bool = false) {
    
        let name: String
        let bundleIdentifier = "com.microsoft.edgemac"
        let mode: Mode = secretMode ? .secret : .normal
        let arguments: Array<OpenTarget.Argument>
        let createNewInstance: Bool

        switch secretMode {
        
        case false:
            name = "Microsoft Edge"
            createNewInstance = true
            arguments = [.targetURL]

        case true:
            name = "Microsoft Edge (Secret Mode)"
            createNewInstance = true
            arguments = ["--inprivate", .targetURL]
        }

        self.init(name: name, bundleIdentifier: bundleIdentifier, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
}
