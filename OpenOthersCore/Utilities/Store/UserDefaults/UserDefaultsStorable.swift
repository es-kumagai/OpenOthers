////
////  Storable.swift
////  OpenOthersCore
////
////  Created by Tomohiro Kumagai on 2021/08/22.
////
//
///// A storable type; this protocol only must conform to types compatible with UserDefault.
//public protocol UserDefaultsStorable {
//    
//    var userDefaultsStorableValue: Any { get }
//    
//    init?(userDefaultsStorableValue source: Any)
//}
//
//extension Int : UserDefaultsStorable {
//        
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let value = source as? Int else {
//            
//            return nil
//        }
//        
//        self = value
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        self
//    }
//}
//
//extension String : UserDefaultsStorable {
//    
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let value = source as? String else {
//            
//            return nil
//        }
//        
//        self = value
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        self
//    }
//}
//
//extension Date : UserDefaultsStorable {
//    
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let value = source as? Date else {
//            
//            return nil
//        }
//        
//        self = value
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        self
//    }
//}
//
//extension Data : UserDefaultsStorable {
//    
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let value = source as? Data else {
//            
//            return nil
//        }
//        
//        self = value
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        self
//    }
//}
//
//extension Array : UserDefaultsStorable where Element : UserDefaultsStorable {
//
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let elements = source as? Self else {
//            
//            return nil
//        }
//        
//        let values = elements.map(Element.init(userDefaultsStorableValue:))
//        
//        guard values.allSatisfy( { $0 != nil }) else {
//            
//            return nil
//        }
//        
//        self = values.map { $0! }
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        map(\.userDefaultsStorableValue)
//    }
//}
//
//extension Dictionary : UserDefaultsStorable where Key == String, Value : UserDefaultsStorable {
//
//    public init?(userDefaultsStorableValue source: Any) {
//        
//        guard let elements = source as? Dictionary<String, Any> else {
//            
//            return nil
//        }
//        
//        let items = elements.mapValues(Value.init(userDefaultsStorableValue:))
//        
//        guard items.allSatisfy( { $0.value != nil }) else {
//            
//            return nil
//        }
//        
//        self = items.mapValues { $0! }
//    }
//    
//    public var userDefaultsStorableValue: Any {
//        
//        mapValues(\.userDefaultsStorableValue)
//    }
//}
//
//extension Optional : UserDefaultsStorable where Wrapped : UserDefaultsStorable {
//        
//        public init?(userDefaultsStorableValue source: Any) {
//            
//            guard let value = source as? Wrapped else {
//                
//                return nil
//            }
//            
//            self = value
//        }
//        
//        public var userDefaultsStorableValue: Any {
//            
//            self as Any
//        }
//}
