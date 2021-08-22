//
//  UserDefaults+NSCoding.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import Foundation

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
