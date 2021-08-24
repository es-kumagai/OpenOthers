//
//  UserDefaults.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import Foundation

public final class SafeUserDefaults {
    
    public typealias Dictionary<Value> = Swift.Dictionary<String, Value>
    
    private let userDefaults: UserDefaults
    
    public static let standard = SafeUserDefaults(userDefaults: .standard)
    
    internal init(userDefaults: UserDefaults) {
        
        self.userDefaults = userDefaults
    }
    
    public init() {
    
        userDefaults = UserDefaults()
    }
    
    public init?(suiteName: String?) {
        
        guard let userDefaults = UserDefaults(suiteName: suiteName) else {
            
            return nil
        }
        
        self.userDefaults = userDefaults
    }
    
    var volatileDomains: [String] {
    
        userDefaults.volatileDomainNames
    }
    
    func volatileDomain(forName name: String) -> [String : Any] {
    
        userDefaults.volatileDomain(forName: name)
    }
    
    func removeValue(forKey key: String) {
        
        userDefaults.removeObject(forKey: key)
    }
    
    func registerDefaults(_ defaults: [String : Any]) {
        
        userDefaults.register(defaults: defaults)
    }
    
    func removeSuite(named name: String) {
        
        userDefaults.removeSuite(named: name)
    }
    
    func removeVolatileDomain(forName name: String) {
        
        userDefaults.removeVolatileDomain(forName: name)
    }
    
    func removePersistentDomain(forName name: String) {
        
        userDefaults.removePersistentDomain(forName: name)
    }
    
    func synchronize() {

        userDefaults.synchronize()
    }
}

// MARK: - Internal Utilities

internal extension SafeUserDefaults {
    
    func convertCompatibleValue<Value>(_ compatibleValue: Any, to type: Value.Type) throws -> Value where Value : UserDefaultsStorable {
        
        guard let value = Value(userDefaultsStorableValue: compatibleValue) else {
            
            throw ReadError.incompatibleValue(compatibleValue, with: Value.self)
        }
        
        return value
    }
    
    func unsafeWrite(_ value: Any, forKey key: String) throws {
    
        userDefaults.set(value, forKey: key)
    }
    
    func unsafeRead<Value>(forKey key: String, as type: Value.Type) throws -> Value? {
        
        guard let typeUnsfecifiedValue = userDefaults.value(forKey: key) else {
            
            return nil
        }
        
        guard let value = typeUnsfecifiedValue as? Value else {
            
            throw ReadError.incompatibleValue(typeUnsfecifiedValue, with: Value.self)
        }
        
        return value
    }
    
    func unsafeRead<Value>(forKey key: String, as type: Value.Type, alternativeValueIfNotExist alternativeValue: Value) throws -> Value {
        
        try unsafeRead(forKey: key, as: type) ?? alternativeValue
    }
}

// MARK: - Standard API

public extension SafeUserDefaults {

    func write(_ value: NSData, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func write(_ value: NSString, forKey key: String) throws {
    
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: NSNumber, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: NSDate, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: Array<NSData>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: Array<NSString>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: Array<NSNumber>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }
    
    func write(_ value: Array<NSDate>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func write(_ value: Dictionary<NSData>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func write(_ value: Dictionary<NSString>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func write(_ value: Dictionary<NSNumber>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func write(_ value: Dictionary<NSDate>, forKey key: String) throws {
        
        try unsafeWrite(value, forKey: key)
    }

    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: NSData) throws -> NSData {
        
        try unsafeRead(forKey: key, as: NSData.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: NSString) throws -> NSString {
        
        try unsafeRead(forKey: key, as: NSString.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: NSNumber) throws -> NSNumber {
        
        try unsafeRead(forKey: key, as: NSNumber.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: NSDate) throws -> NSDate {
        
        try unsafeRead(forKey: key, as: NSDate.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Array<NSData>) throws -> Array<NSData> {
        
        try unsafeRead(forKey: key, as: Array<NSData>.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Array<NSString>) throws -> Array<NSString> {
        
        try unsafeRead(forKey: key, as: Array<NSString>.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Array<NSNumber>) throws -> Array<NSNumber> {
        
        try unsafeRead(forKey: key, as: Array<NSNumber>.self, alternativeValueIfNotExist: alternativeValue)
    }
    
    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Array<NSDate>) throws -> Array<NSDate> {
        
        try unsafeRead(forKey: key, as: Array<NSDate>.self, alternativeValueIfNotExist: alternativeValue)
    }

    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Dictionary<NSData>) throws -> Dictionary<NSData> {
        
        try unsafeRead(forKey: key, as: Dictionary<NSData>.self, alternativeValueIfNotExist: alternativeValue)
    }

    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Dictionary<NSString>) throws -> Dictionary<NSString> {
        
        try unsafeRead(forKey: key, as: Dictionary<NSString>.self, alternativeValueIfNotExist: alternativeValue)
    }

    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Dictionary<NSNumber>) throws -> Dictionary<NSNumber> {
        
        try unsafeRead(forKey: key, as: Dictionary<NSNumber>.self, alternativeValueIfNotExist: alternativeValue)
    }

    func read(forKey key: String, alternativeValueIfNotExist alternativeValue: Dictionary<NSDate>) throws -> Dictionary<NSDate> {
        
        try unsafeRead(forKey: key, as: Dictionary<NSDate>.self, alternativeValueIfNotExist: alternativeValue)
    }
}

// MARK: - Enhanced API
public extension SafeUserDefaults {

    func write<Value>(_ value: Value, forKey key: String) throws where Value : UserDefaultsStorable {
        
        try write(value as UserDefaultsStorable, forKey: key)
    }
    
    func write(_ value: UserDefaultsStorable, forKey key: String) throws {

        try unsafeWrite(value.userDefaultsStoreableValue, forKey: key)
    }
    
    func read<Value>(forKey key: String, alternativeValueIfNotExist alternativeValue: Value) throws -> Value where Value : UserDefaultsStorable {
        
        guard let compatibleValue = try unsafeRead(forKey: key, as: Any.self) else {
            
            return alternativeValue
        }
        
        return try convertCompatibleValue(compatibleValue, to: Value.self)
    }
    
    func write<Element>(_ value: Array<Element>, forKey key: String) throws where Element : UserDefaultsStorable {
        
        try unsafeWrite(value.map(\.userDefaultsStoreableValue), forKey: key)
    }
    
    func read<Element>(forKey key: String, alternativeValueIfNotExist alternativeValue: Array<Element>) throws -> Array<Element> where Element : UserDefaultsStorable {
    
        guard let anyValue = try unsafeRead(forKey: key, as: NSArray?.self, alternativeValueIfNotExist: nil) else {
            
            return alternativeValue
        }
        
        guard let compatibleValue = anyValue as? Array<Any> else {
            
            throw ReadError.incompatibleValue(anyValue, with: Array<Any>.self)
        }
        
        return try compatibleValue.map {
            
            try convertCompatibleValue($0, to: Element.self)
        }
    }
    
    func write<SubValue>(_ value: Dictionary<SubValue>, forKey key: String) throws where SubValue : UserDefaultsStorable {

        try unsafeWrite(value.mapValues(\.userDefaultsStoreableValue), forKey: key)
    }

    func read<SubValue>(forKey key: String, alternativeValueIfNotExist alternativeValue: Dictionary<SubValue>) throws -> Dictionary<SubValue> where SubValue : UserDefaultsStorable {
    
        guard let anyValue = try unsafeRead(forKey: key, as: NSDictionary?.self, alternativeValueIfNotExist: nil) else {
            
            return alternativeValue
        }
        
        guard let compatibleValue = anyValue as? Dictionary<Any> else {
        
            throw ReadError.incompatibleValue(anyValue, with: Dictionary<Any>.self)
        }
        
        return try compatibleValue.mapValues {
            
            try convertCompatibleValue($0, to: SubValue.self)
        }
    }
}

// MARK: - Reference Convertible

public extension SafeUserDefaults {
    
    func write<Value>(_ value: Value, forKey key: String) throws where Value : ReferenceConvertible, Value.ReferenceType == NSData {
    
        try write(value as! Value.ReferenceType, forKey: key)
    }

    func write<Value>(_ value: Value, forKey key: String) throws where Value : ReferenceConvertible, Value.ReferenceType == NSString {
    
        try write(value as! Value.ReferenceType, forKey: key)
    }

    func write<Value>(_ value: Value, forKey key: String) throws where Value : ReferenceConvertible, Value.ReferenceType == NSNumber {
    
        try write(value as! Value.ReferenceType, forKey: key)
    }

    func write<Value>(_ value: Value, forKey key: String) throws where Value : ReferenceConvertible, Value.ReferenceType == NSDate {
    
        try write(value as! Value.ReferenceType, forKey: key)
    }
    
    func read<Value>(forKey key: String, alternativeValueIfNotExist alternativeValue: Value) throws -> Value where Value : ReferenceConvertible, Value.ReferenceType == NSData {
        
        try read(forKey: key, alternativeValueIfNotExist: alternativeValue as! Value.ReferenceType) as! Value
    }

    func read<Value>(forKey key: String, alternativeValueIfNotExist alternativeValue: Value) throws -> Value where Value : ReferenceConvertible, Value.ReferenceType == NSString {
        
        try read(forKey: key, alternativeValueIfNotExist: alternativeValue as! Value.ReferenceType) as! Value
    }

    func read<Value>(forKey key: String, alternativeValueIfNotExist alternativeValue: Value) throws -> Value where Value : ReferenceConvertible, Value.ReferenceType == NSNumber {
        
        try read(forKey: key, alternativeValueIfNotExist: alternativeValue as! Value.ReferenceType) as! Value
    }

    func read<Value>(forKey key: String, alternativeValueIfNotExist alternativeValue: Value) throws -> Value where Value : ReferenceConvertible, Value.ReferenceType == NSDate {
        
        try read(forKey: key, alternativeValueIfNotExist: alternativeValue as! Value.ReferenceType) as! Value
    }
}

// MARK: - NSCoding

extension SafeUserDefaults {

    func write<Value>(_ value: Value, forKey key: String) throws where Value : NSCoding {
        
        try write(value as NSCoding, forKey: key)
    }
    
    func write(_ value: NSCoding, forKey key: String) throws {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) as NSData
            try write(data, forKey: key)
        }
        catch {
            
            throw WriteError.failedToArchive(error)
        }
    }
    
    func write<Value>(_ value: Value, forKey key: String) throws where Value : NSSecureCoding {
        
        try write(value as NSSecureCoding, forKey: key)
    }
    
    func write(_ value: NSSecureCoding, forKey key: String) throws {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: type(of: value).supportsSecureCoding) as NSData
            try write(data, forKey: key)
        }
        catch {
            
            throw WriteError.failedToArchive(error)
        }
    }

    func read<Value>(forKey key: String, valueIfNotExists defaultValue: Value) throws -> Value where Value : NSCoding {
        
        let anyValue = try read(forKey: key, valueIfNotExists: defaultValue as NSCoding)
        
        guard let value = anyValue as? Value else {

            throw ReadError.incompatibleValue(anyValue, with: Value.self)
        }
        
        return value
    }
    
    func read(forKey key: String, valueIfNotExists defaultValue: NSCoding) throws -> NSCoding {
        
        guard let data = try unsafeRead(forKey: key, as: NSData.self) else {
            
            return defaultValue
        }

        do {
            guard let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as Data) as? NSCoding else {
                
                throw ReadError.incompatibleValue(data, with: NSCoding.self)
            }
        
            return value
        }
        catch {
            
            throw ReadError.failedToUnarchive(error)
        }
    }
}
