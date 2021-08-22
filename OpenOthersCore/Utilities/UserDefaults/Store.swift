//
//  StoreUserDefaults.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import Foundation

@propertyWrapper
public struct Store<Value> : StoreProtocol where Value : Storable {
    
    public let assignedKey: String
    public let defaultValue: Value
    public let userDefaults: UserDefaults
    
    public var wrappedValue: Value {
        
        set (value) {
            userDefaults.set(value, forKey: assignedKey)
        }
        
        get {
            userDefaults.value(forKey: assignedKey) as? Value ?? defaultValue
        }
    }

    public init(defaultValue value: Value, key: String, store: UserDefaults) {
        
        assignedKey = key
        defaultValue = value
        userDefaults = store
    }
}

@propertyWrapper
public struct CodingStore<Value> : StoreProtocol where Value : NSCoding {

    public let assignedKey: String
    public let defaultValue: Value
    public let userDefaults: UserDefaults

    public var wrappedValue: Value {

        set (value) {
            try! userDefaults.set(value, forKey: assignedKey)
        }

        get {
            userDefaults.value(forKey: assignedKey) as? Value ?? defaultValue
        }
    }

    public init(defaultValue value: Value, key: String, store: UserDefaults) {

        assignedKey = key
        defaultValue = value
        userDefaults = store
    }
}

@propertyWrapper
public struct SecureCodingStore<Value> : StoreProtocol where Value : NSSecureCoding {

    public let assignedKey: String
    public let defaultValue: Value
    public let userDefaults: UserDefaults

    public var wrappedValue: Value {

        set (value) {
            try! userDefaults.set(value, forKey: assignedKey)
        }

        get {
            userDefaults.value(forKey: assignedKey) as? Value ?? defaultValue
        }
    }

    public init(defaultValue value: Value, key: String, store: UserDefaults) {

        assignedKey = key
        defaultValue = value
        userDefaults = store
    }
}
