//
//  Storable.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

extension Double : UserDefaultsStorable {}
extension Float : UserDefaultsStorable {}
extension String : UserDefaultsStorable {}
extension Bool : UserDefaultsStorable {}
extension Data : UserDefaultsStorable {}
extension Array : UserDefaultsStorable where Element : UserDefaultsStorable {}
extension Dictionary : UserDefaultsStorable where Key == String, Value : UserDefaultsStorable {}
extension Optional : UserDefaultsStorable where Wrapped : UserDefaultsStorable {}


/// A storeable type; this protocol only must conform to types compatible with UserDefault.
public protocol UserDefaultsStorable {
    
    var userDefaultsStoreableValue: Any { get }
    
    init?(storeableValue source: Any)
}

extension UserDefaultsStorable {

    public var userDefaultsStoreableValue: Any {

        self
    }
    
    public init?(storeableValue source: Any) {
        
        guard let value = source as? Self else {
            
            return nil
        }
        
        self = value
    }
}
