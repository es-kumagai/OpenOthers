//
//  StoreUserDefaults.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import Foundation

@propertyWrapper
public struct UserDefaultsStore<Value> : StoreProtocol {
    
    public let assignedKey: String
    public let defaultValue: Value
    public let store: SafeUserDefaults
    
    func removeFromStore() {
        
        store.removeValue(forKey: assignedKey)
    }

    public var wrappedValue: Value {
        
        set (value) {
            try! write(value)
        }
        
        get {
            try! read()
        }
    }
    
    public var projectedValue: Self {
        
        self
    }

    public init(defaultValue value: Value, key: String, store: SafeUserDefaults) {
        
        self.assignedKey = key
        self.defaultValue = value
        self.store = store
    }
}

public extension UserDefaultsStore {
    
    init(wrappedValue value: Value, key: Key, appGroupID: String?) {
       
       self.init(defaultValue: value, key: key, appGroupID: appGroupID)
   }

    init(defaultValue value: Value, key: Key, appGroupID: String? = nil) {
        
        let store = appGroupID.map(SafeUserDefaults.init(suiteName:)).map(\.unsafelyUnwrapped) ?? .standard

        self.init(defaultValue: value, key: key, store: store)
    }
    
    /// Only supports Basic types and types compatible with either UserDefaultsStorable or NSCoding.
    /// - Parameter value: <#value description#>
    /// - Throws: <#description#>
    func write(_ value: Value) throws {
        
        switch value {
        
        case let value as NSData:
            try store.write(value, forKey: assignedKey)
            
        case let value as NSString:
            try store.write(value, forKey: assignedKey)
            
        case let value as NSNumber:
            try store.write(value, forKey: assignedKey)
            
        case let value as NSDate:
            try store.write(value, forKey: assignedKey)
            
        case let value as Array<NSData>:
            try store.write(value, forKey: assignedKey)
            
        case let value as Array<NSString>:
            try store.write(value, forKey: assignedKey)
            
        case let value as Array<NSNumber>:
            try store.write(value, forKey: assignedKey)
            
        case let value as Array<NSDate>:
            try store.write(value, forKey: assignedKey)
            
        case let value as SafeUserDefaults.Dictionary<NSData>:
            try store.write(value, forKey: assignedKey)
            
        case let value as SafeUserDefaults.Dictionary<NSString>:
            try store.write(value, forKey: assignedKey)
            
        case let value as SafeUserDefaults.Dictionary<NSNumber>:
            try store.write(value, forKey: assignedKey)
            
        case let value as SafeUserDefaults.Dictionary<NSDate>:
            try store.write(value, forKey: assignedKey)
        
        case let value as UserDefaultsStorable:
            try store.write(value, forKey: assignedKey)
            
        case let value as NSSecureCoding:
            try store.write(value, forKey: assignedKey)
            
        case let value as NSCoding:
            try store.write(value, forKey: assignedKey)
            
        default:
            throw SafeUserDefaults.WriteError.incompatibleValue
        }
    }
    
    func read() throws -> Value {
        
        do {
            return try store.unsafeRead(forKey: assignedKey, as: Value.self, alternativeValueIfNotExist: defaultValue)
        }
        catch SafeUserDefaults.ReadError.incompatibleValue(let anyValue, with: _) {

            switch anyValue {
            
            case let source where Value.self is UserDefaultsStorable.Type:

                let storableType = Value.self as! UserDefaultsStorable.Type
                
                guard let value = storableType.init(userDefaultsStorableValue: source) as? Value else {
                    
                    throw SafeUserDefaults.ReadError.incompatibleValue(source, with: Value.self)
                }
                
                return value

            case let source as Data:
            
                do {
                    
                    guard let anyValue = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(source) else {
                        
                        throw SafeUserDefaults.ReadError.incompatibleValue(source, with: Value.self)
                    }
                    
                    guard let value = anyValue as? Value else {
                        
                        throw SafeUserDefaults.ReadError.incompatibleValue(anyValue, with: Value.self)
                    }
                    
                    return value
                }
                catch let error as SafeUserDefaults.ReadError {
                    
                    throw error
                }
                catch {
                    
                    throw SafeUserDefaults.ReadError.failedToUnarchive(error)
                }
                
            default:
                throw SafeUserDefaults.ReadError.incompatibleValue(anyValue, with: Value.self)
            }
        }
    }
}
