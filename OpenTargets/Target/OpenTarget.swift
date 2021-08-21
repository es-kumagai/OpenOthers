//
//  OpenTarget.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import AppKit

open class OpenTarget : Codable {

    public let name: String
    public let bundleIdentifier: String
    public let arguments: Array<Argument>
    public let createNewInstance: Bool

    public init(name: String, bundleIdentifier: String, arguments: Array<Argument> = [], createNewInstance: Bool = true) {
        
        self.name = name
        self.bundleIdentifier = bundleIdentifier
        self.arguments = arguments
        self.createNewInstance = createNewInstance
    }

    public enum CodingKeys : String, CodingKey {
        
        case name
        case bundleIdentifier = "bundle_identifier"
        case arguments
        case createNewInstance = "create_new_instance"
    }
    
    public required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        bundleIdentifier = try container.decode(String.self, forKey: .bundleIdentifier)
        arguments = try container.decode(Array<Argument>.self, forKey: .arguments)
        createNewInstance = try container.decode(Bool.self, forKey: .createNewInstance)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(bundleIdentifier, forKey: .bundleIdentifier)
        try container.encode(arguments, forKey: .arguments)
        try container.encode(createNewInstance, forKey: .createNewInstance)
    }
}

/// The current workspace; this can be replaced if you need (e.g. for testing).
internal var openTargetCurrentWorkspace = NSWorkspace.shared

extension OpenTarget : CustomStringConvertible {
    
    public var description: String {
        
        name
    }
}

extension OpenTarget : CustomDebugStringConvertible {
    
    public var debugDescription: String {
        
        "\(name) (\(bundleIdentifier)) \(arguments)"
    }
}

public extension OpenTarget {
        
    var applicationURL: URL? {
    
        openTargetCurrentWorkspace.urlForApplication(withBundleIdentifier: bundleIdentifier)
    }
    
    func open(with url: URL, completionHandler: ((Result<NSRunningApplication, Error>) -> Void)? = nil) {
        
        openTargetCurrentWorkspace.openApplication(url, with: self, completionHandler: completionHandler)
    }
}
