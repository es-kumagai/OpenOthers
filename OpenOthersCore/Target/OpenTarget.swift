//
//  OpenTarget.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

@objcMembers
public class OpenTarget : NSObject, NSSecureCoding, @unchecked Sendable {

    public let name: String
    public let bundleIdentifier: String
    public let mode: Mode
    public let arguments: Array<Argument>
    public let createNewInstance: Bool

    public init(name: String, bundleIdentifier: String, mode: Mode, arguments: Array<Argument> = [], createNewInstance: Bool = true) {
        
        self.name = name
        self.bundleIdentifier = bundleIdentifier
        self.mode = mode
        self.arguments = arguments
        self.createNewInstance = createNewInstance
    }

    public static var supportsSecureCoding = true
    
    public required convenience init?(coder: NSCoder) {
        
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"), let bundleIdentifier = coder.decodeObject(of: NSString.self, forKey: "bundleIdentifier"), let modeRawValue = coder.decodeObject(of: NSString.self, forKey: "modeRawValue"), let mode = Mode(rawValue: modeRawValue as String), let argumentsDataTypesData = coder.decodeObject(of: NSData.self, forKey: "argumentDataTypesData") else {
            
            return nil
        }
        
        
        guard let argumentDataTypes = try?
                NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Argument.CodingData.self, from: argumentsDataTypesData as Data) else {
            
            return nil
        }
        
        let arguments = argumentDataTypes.map(Argument.init)
        let createNewInstance = coder.decodeBool(forKey: "createNewInstance")
        
        self.init(name: name as String, bundleIdentifier: bundleIdentifier as String, mode: mode, arguments: arguments, createNewInstance: createNewInstance)
    }
    
    public func encode(with coder: NSCoder) {
        
        let argumentDataTypesData = try! NSKeyedArchiver.archivedData(withRootObject: arguments.map(\.codingData), requiringSecureCoding: true)
        
        coder.encode(name, forKey: "name")
        coder.encode(bundleIdentifier, forKey: "bundleIdentifier")
        coder.encode(mode.rawValue, forKey: "modeRawValue")
        coder.encode(argumentDataTypesData, forKey: "argumentDataTypesData")
        coder.encode(createNewInstance, forKey: "createNewInstance")
    }
}

extension OpenTarget {
    
    public override var description: String {
        
        name
    }
    
    public override var debugDescription: String {
        
        "\(name) (\(bundleIdentifier), \(mode)) \(arguments)"
    }
}
