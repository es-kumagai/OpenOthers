//
//  StoreUserDefaults.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

/// A storeable type; this protocol only must conform to types compatible with UserDefault.
public protocol Storeable {
    
    var storeableValue: Any { get }
    
    init!(storeableValue: Any)
}

extension Storeable {

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

extension Double : Storeable {}
extension Float : Storeable {}
extension String : Storeable {}
extension Bool : Storeable {}
extension Data : Storeable {}
extension Array : Storeable where Element : Storeable {}
extension Dictionary : Storeable where Key == String, Value : Storeable {}
extension Optional : Storeable where Wrapped : Storeable {}
extension Date : Storeable {

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

public extension UserDefaults {
    
    func set<Value: Storeable>(_ value: Value, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func set<Value: Storeable>(_ value: Array<Value>, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func set<Value: Storeable>(_ value: Dictionary<String, Value>, forKey key: String) {
        
        set(value.storeableValue, forKey: key)
    }
    
    func value<Value: Storeable>(forKey key: String, as _: Value.Type) -> Value? {
        
        value(forKey: key) as? Value
    }
}

public extension UserDefaults {
 
    func set<Value : NSCoding>(_ value: Value, forKey key: String) throws {
        
        let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        
        
        set(data, forKey: key)
    }
    
    func value<Value : NSCoding>(forKey key: String, as _: Value.Type) throws -> Value? {
        
        guard let data = data(forKey: key) else {
            
            return nil
        }
        
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Value
    }

    
       func set<Value : NSSecureCoding>(_ value: Value, forKey key: String) throws {
           
           let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
           
           
           set(data, forKey: key)
       }
}

@propertyWrapper
public struct Store<Value> where Value : Storeable {
    
    let assignedKey: String
    let defaultValue: Value
    let userDefaults: UserDefaults
    
    public var wrappedValue: Value {
        
        set (value) {
            
            userDefaults.set(value, forKey: assignedKey)
        }
        
        get {
            
            userDefaults.value(forKey: assignedKey) as? Value ?? defaultValue
        }
    }
    
    public init(wrappedValue: Value, key: String, appGroupID: String? = nil) {
        
        self.assignedKey = key
        self.defaultValue = wrappedValue
        self.userDefaults = appGroupID.map(UserDefaults.init(suiteName:)).map(\.unsafelyUnwrapped) ?? .standard
    }
    
    public func removeFromStore() {
        
        userDefaults.removeObject(forKey: assignedKey)
    }
}
