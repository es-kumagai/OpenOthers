//
//  UserDefaults+Store.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import Foundation

public extension UserDefaults {
    
    func set<Value: Storable>(_ value: Value, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func set<Value: Storable>(_ value: Array<Value>, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func set<Value: Storable>(_ value: Dictionary<String, Value>, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func value<Value: Storable>(forKey key: String, as _: Value.Type) -> Value? {
        
        value(forKey: key) as? Value
    }
}
