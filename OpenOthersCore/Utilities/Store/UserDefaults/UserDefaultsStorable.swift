//
//  Storable.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

/// A storeable type; this protocol only must conform to types compatible with UserDefault.
public protocol UserDefaultsStorable {
    
    var userDefaultsStoreableValue: Any { get }
    
    init?(userDefaultsStorableValue source: Any)
}

extension Array : UserDefaultsStorable where Element : UserDefaultsStorable {

    public init?(userDefaultsStorableValue source: Any) {
        
        guard let elements = source as? Array<Any> else {
            
            return nil
        }
        
        let values = elements.map(Element.init(userDefaultsStorableValue:))
        
        guard values.allSatisfy( { $0 != nil }) else {
            
            return nil
        }
        
        self = values.compactMap { $0 }
    }
    
    public var userDefaultsStoreableValue: Any {
        
        map(\.userDefaultsStoreableValue)
    }
}

extension Dictionary : UserDefaultsStorable where Key == String, Value : UserDefaultsStorable {

    public init?(userDefaultsStorableValue source: Any) {
        
        guard let elements = source as? Dictionary<String, Any> else {
            
            return nil
        }
        
        let items = elements.mapValues(Value.init(userDefaultsStorableValue:))
        
        guard items.allSatisfy( { $0.value != nil }) else {
            
            return nil
        }
        
        self = items.compactMapValues { $0 }
    }
    
    public var userDefaultsStoreableValue: Any {
        
        mapValues(\.userDefaultsStoreableValue)
    }
}
