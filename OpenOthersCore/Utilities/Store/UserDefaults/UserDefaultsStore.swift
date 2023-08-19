////
////  StoreUserDefaults.swift
////  OpenOthersCore
////
////  Created by Tomohiro Kumagai on 2021/08/22.
////
//
//import Foundation
//
//@propertyWrapper
//public struct UserDefaultsStore<Value : UserDefaultsStorable> : StoreProtocol {
//    
//    public let assignedKey: String
//    public let defaultValue: Value
//    public let store: UserDefaults
//    
//    func removeFromStore() {
//        
//        store.removeObject(forKey: assignedKey)
//    }
//
//    public var wrappedValue: Value {
//        
//        set (value) {
//            write(value)
//        }
//        
//        get {
//            read() ?? defaultValue
//        }
//    }
//    
//    public var projectedValue: Self {
//        
//        self
//    }
//
//    public init(defaultValue value: Value, key: String, store: UserDefaults) {
//        
//        self.assignedKey = key
//        self.defaultValue = value
//        self.store = store
//    }
//}
//
//public extension UserDefaultsStore {
//    
//    init(wrappedValue value: Value, key: Key, appGroupID: String?) {
//       
//        self.init(defaultValue: value, key: key, appGroupID: appGroupID)
//   }
//
//    init(defaultValue value: Value, key: Key, appGroupID: String? = nil) {
//        
//        let store: UserDefaults
//        
//        if let appGroupID {
//            store = UserDefaults(suiteName:appGroupID) ?? .standard
//        } else {
//            store = .standard
//        }
//
//        self.init(defaultValue: value, key: key, store: store)
//    }
//    
//    /// Only supports Basic types and types compatible with either UserDefaultsStorable or NSCoding.
//    /// - Parameter value: <#value description#>
//    /// - Throws: <#description#>
//    func write(_ value: Value) {
//        
//        store.set(value.userDefaultsStorableValue, forKey: assignedKey)
//    }
//    
//    func read() -> Value? {
//        
//        guard let value = store.object(forKey: assignedKey) else {
//
//            return nil
//        }
//
//        return Value(userDefaultsStorableValue: value)
//    }
//}
