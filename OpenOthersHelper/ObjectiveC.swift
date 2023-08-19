//
//  ObjectiveC.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/28.
//

import ObjectiveC.runtime

enum ObjCRuntime {
    
}

extension ObjCRuntime {
    
    struct Class {
    
        let rawValue: AnyClass
        
        init(_ rawValue: AnyClass) {
            
            self.rawValue = rawValue
        }
    }
    
    struct Method {
        
        var rawValue: ObjectiveC.Method
        
        init(_ rawValue: ObjectiveC.Method) {
            
            self.rawValue = rawValue
        }
    }
}

extension ObjCRuntime.Method {
    
    struct Description {
        
        var rawValue: objc_method_description
        
        init(_ rawValue: objc_method_description) {
            
            self.rawValue = rawValue
        }
    }
    
    struct Implementation {
        
        var rawValue: IMP
        
        init(_ rawValue: IMP) {
            
            self.rawValue = rawValue
        }
    }
    
    struct Argument {
        
        var selector: Selector
        
        init(selector: Selector) {
            
            self.selector = selector
        }
    }
}

extension ObjCRuntime.Class {

    static func methodList(of target: AnyClass) -> [ObjCRuntime.Method] {
        
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        
        defer {
            count.deallocate()
        }
        
        guard let firstMethod = class_copyMethodList(target, count) else {
            
            return []
        }
        
        let methods = UnsafeBufferPointer(start: firstMethod, count: Int(count.pointee))
        
        return methods.map(ObjCRuntime.Method.init)
    }
    
    static func messageSendToMethod(_ method: ObjCRuntime.Method, of target: Any, withArguments argument1: Any? = nil, _ argument2: Any? = nil, _ argument3: Any? = nil) -> Any? {
        
        let perform = unsafeBitCast(method.implementation, to: (@convention(c) (Any?, Selector, Any?, Any?, Any?) -> Any?).self)
        
        return perform(target, method.selector, argument1, argument2, argument3)
    }

    var meta: AnyClass! {
    
        object_getClass(rawValue)
    }
    
    var instanceMethods: [ObjCRuntime.Method] {
        
        Self.methodList(of: rawValue)
    }
    
    var classMethods: [ObjCRuntime.Method] {
        
        Self.methodList(of: meta)
    }
    
    func messageSendToInstanceMethod(_ method: ObjCRuntime.Method, withArguments argument1: Any? = nil, _ argument2: Any? = nil, _ argument3: Any?) -> Any? {
    
        Self.messageSendToMethod(method, of: rawValue, withArguments: argument1, argument2, argument3)
    }
    
    func messageSendToInstanceMethod(_ method: ObjCRuntime.Method) -> Any? {

        messageSendToInstanceMethod(method, withArguments: nil, nil, nil)
    }

    func messageSendToClassMethod(_ method: ObjCRuntime.Method, withArguments argument1: Any? = nil, _ argument2: Any? = nil, _ argument3: Any?) -> Any? {
    
        Self.messageSendToMethod(method, of: meta!, withArguments: argument1, argument2, argument3)
    }

    func messageSendToClassMethod(_ method: ObjCRuntime.Method) -> Any? {
    
        messageSendToClassMethod(method, withArguments: nil, nil, nil)
    }
}

extension ObjCRuntime.Method {
    
    var selector: Selector {
    
        method_getName(rawValue)
    }
    
    var name: String {
        
        String(cString: sel_getName(selector))
    }
    
    var argumentCount: Int {
    
        Int(method_getNumberOfArguments(rawValue))
    }
    
    var returnType: String {
        
        String(cString: method_copyReturnType(rawValue))
    }
    
    var implementation: Implementation {
        
        Implementation(method_getImplementation(rawValue))
    }
    
    var typeEncoding: String! {
        
        method_getTypeEncoding(rawValue).map { String(cString: $0) }
    }
    
    var methodDescription: Description {
        
        Description(method_getDescription(rawValue).pointee)
    }
}

extension ObjCRuntime.Method : Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        sel_isEqual(lhs.selector, rhs.selector)
    }
}

extension ObjCRuntime.Method.Description {
    
    var selector: Selector! {
    
        rawValue.name
    }
    
    var name: String {
        
        String(cString: sel_getName(selector))
    }
    
    var types: String! {
        
        rawValue.types.map { String.init(cString: $0) }
    }
}
