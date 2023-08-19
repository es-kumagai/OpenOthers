//
//  StoreProtocol.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

public protocol StoreProtocol {

    associatedtype Value
    associatedtype Key
    associatedtype Store
    
    var assignedKey: Key { get }
    var defaultValue: Value { get }
    var store: Store { get }

    var wrappedValue: Value { get set }
    
    init(defaultValue value: Value, key: Key, store: Store)
    
    func write(_ value: Value)
    func read() -> Value?
}

public extension StoreProtocol {

     init(wrappedValue value: Value, key: Key, store: Store) {
        
        self.init(defaultValue: value, key: key, store: store)
    }
}
