//
//  StoreProtocol.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import Foundation

public protocol StoreProtocol {

    associatedtype Value
    
    var assignedKey: String { get }
    var defaultValue: Value { get }
    var userDefaults: UserDefaults { get }
    
    var wrappedValue: Value { get }
    
    init(defaultValue value: Value, key: String, store: UserDefaults)
}

public extension StoreProtocol {

     init(wrappedValue value: Value, key: String, store: UserDefaults) {
        
        self.init(defaultValue: value, key: key, store: store)
    }

    init(wrappedValue value: Value, key: String, appGroupID: String?) {
       
       self.init(defaultValue: value, key: key, appGroupID: appGroupID)
   }

    init(defaultValue value: Value, key: String, appGroupID: String? = nil) {
        
        let store = appGroupID.map(UserDefaults.init(suiteName:)).map(\.unsafelyUnwrapped) ?? .standard

        self.init(wrappedValue: value, key: key, store: store)
    }

    func removeFromStore() {
        
        userDefaults.removeObject(forKey: assignedKey)
    }
}
