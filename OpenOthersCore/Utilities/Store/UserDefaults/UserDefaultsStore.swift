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
    public let store: UserDefaults
    
    public enum ReadError : Error {
        
        case unexpectedValueType(Any?, expected: Any.Type)
        case unarchivingFailure(Data, toType: Any.Type)
        case codingError(Error)
    }
    
    public enum WriteError : Error {
        
        case codingError(Error)
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

    public init(defaultValue value: Value, key: String, store: UserDefaults) {
        
        self.assignedKey = key
        self.defaultValue = value
        self.store = store
    }
}

extension UserDefaultsStore {
    
    init(wrappedValue value: Value, key: Key, appGroupID: String?) {
       
       self.init(defaultValue: value, key: key, appGroupID: appGroupID)
   }

    init(defaultValue value: Value, key: Key, appGroupID: String? = nil) {
        
        let store = appGroupID.map(UserDefaults.init(suiteName:)).map(\.unsafelyUnwrapped) ?? .standard

        self.init(defaultValue: value, key: key, store: store)
    }

    func removeFromStore() {
        
        store.removeObject(forKey: assignedKey)
    }

    public func write(_ value: Value) throws {
        
        store.set(value, forKey: assignedKey)
    }
    
    public func read() throws -> Value {
        
        store.value(forKey: assignedKey) as? Value ?? defaultValue
    }
}

private extension UserDefaultsStore {
    
    func valueForReading<Result : UserDefaultsStorable>(as _: Result.Type) throws -> Result? {
        
        guard let value = store.value(forKey: assignedKey) else {
            
            return nil
        }
        
        guard let result = Result(storeableValue: value) else {
            
            throw ReadError.unexpectedValueType(value, expected: Result.self)
        }
        
        return result
    }
    
    func archivedDataForWriting<T : NSCoding>(of value: T, requiringSecureCoding: Bool) throws -> Data {
        
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: requiringSecureCoding)
        }
        catch {
            
            throw WriteError.codingError(error)
        }
    }
    
    func unarchivedDataForReading<Result : NSCoding>(of anyValue: Any?, to _: Result.Type) throws -> Result? {
        
        do {
            guard let anyValue = anyValue else {
                
                return nil
            }
            
            guard let data = anyValue as? Data else {
            
                throw ReadError.unexpectedValueType(anyValue, expected: Data.self)
            }
            
            guard let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) else {
                
                throw ReadError.unarchivingFailure(data, toType: Result.self)
            }
            
            guard let result = value as? Result else {
                
                throw ReadError.unexpectedValueType(value, expected: Result.self)
            }
            
            return result
        }
        catch {
            
            throw ReadError.codingError(error)
        }
    }
}

extension UserDefaultsStore where Value : UserDefaultsStorable {
    
    public func write(_ value: Value) throws {
        
        store.set(value.userDefaultsStoreableValue, forKey: assignedKey)
    }
    
    public func read() throws -> Value {
        
        try valueForReading(as: Value.self) ?? defaultValue
    }
}

extension UserDefaultsStore where Value : NSCoding {
    
    public func write(_ value: Value) throws {
        
        try store.set(archivedDataForWriting(of: value, requiringSecureCoding: false), forKey: assignedKey)
    }
    
    public func read() throws -> Value {
        
        try unarchivedDataForReading(of: store.value(forKey: assignedKey), to: Value.self) ?? defaultValue
    }
}

extension UserDefaultsStore where Value : NSSecureCoding {
    
    public func write(_ value: Value) throws {
        
        try store.set(archivedDataForWriting(of: value, requiringSecureCoding: Value.supportsSecureCoding), forKey: assignedKey)
    }
    
    public func read() throws -> Value {
        
        try unarchivedDataForReading(of: store.value(forKey: assignedKey), to: Value.self) ?? defaultValue
    }
}

extension UserDefaultsStore where Value : ReferenceConvertible, Value.ReferenceType : NSCoding {
    
    public func read() throws -> Value {
        
        guard let referenceValue = try unarchivedDataForReading(of: store.value(forKey: assignedKey), to: Value.ReferenceType.self) else {
            
            return defaultValue
        }

        guard let result = referenceValue as? Value else {
            
            throw ReadError.unexpectedValueType(referenceValue, expected: Value.self)
        }
        
        return result
    }

    public func write(_ value: Value) throws {
        
        let value = value as! Value.ReferenceType
        let data = try archivedDataForWriting(of: value, requiringSecureCoding: false)
        
        store.set(data, forKey: assignedKey)
    }
}

extension UserDefaultsStore where Value : ReferenceConvertible, Value.ReferenceType : NSSecureCoding {
    
    public func write(_ value: Value) throws {
        
        let value = value as! Value.ReferenceType
        let data = try archivedDataForWriting(of: value, requiringSecureCoding: Value.ReferenceType.supportsSecureCoding)
        
        store.set(data, forKey: assignedKey)
    }
}
