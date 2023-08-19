//
//  OpenTargets.swift
//  OpenOthersCore
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import Foundation

public final class OpenTargets : NSObject, NSSecureCoding, Sendable {
    
    public static var supportsSecureCoding = true
    
    public let targets: [OpenTarget]
    
    public init(_ targets: [OpenTarget]) {
        
        self.targets = targets
    }
    
    public required init?(coder: NSCoder) {
        
        guard let targetsData = coder.decodeObject(of: NSData.self, forKey: "targetsData") else {
            
            return nil
        }
        
        guard let targets = try? NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: OpenTarget.self, from: targetsData as Data) else {
            
            return nil
        }
        
        self.targets = targets
    }
    
    public func encode(with coder: NSCoder) {
        
        let targetsData = try! NSKeyedArchiver.archivedData(withRootObject: targets, requiringSecureCoding: true)
        
        coder.encode(targetsData, forKey: "targetsData")
    }
}

extension OpenTargets : RandomAccessCollection {
    
    public var startIndex: Int {
        
        targets.startIndex
    }
    
    public var endIndex: Int {
        
        targets.endIndex
    }
    
    public subscript(position: Int) -> OpenTarget {
        
        targets[position]
    }
}
