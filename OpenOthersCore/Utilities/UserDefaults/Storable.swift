//
//  Storable.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

/// A storeable type; this protocol only must conform to types compatible with UserDefault.
public protocol Storable {
    
    var storeableValue: Any { get }
    
    init!(storeableValue: Any)
}

extension Storable {

    public var storeableValue: Any {

        self
    }
    
    public init?(storeableValue: Any) {
        
        guard let value = storeableValue as? Self else {
            
            return nil
        }
        
        self = value
    }
}

extension Double : Storable {}
extension Float : Storable {}
extension String : Storable {}
extension Bool : Storable {}
extension Data : Storable {}
extension Array : Storable where Element : Storable {}
extension Dictionary : Storable where Key == String, Value : Storable {}
extension Optional : Storable where Wrapped : Storable {}
extension Date : Storable {

    public var storeableValue: Any {
        
        try! NSKeyedArchiver.archivedData(withRootObject: self as NSDate, requiringSecureCoding: true)
    }
    
    public init!(storeableValue: Any) {
        
        guard let data = storeableValue as? Data else {
            
            return nil
        }
        
        guard let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSDate else {
            
            return nil
        }

        self = value as Date
    }
}
