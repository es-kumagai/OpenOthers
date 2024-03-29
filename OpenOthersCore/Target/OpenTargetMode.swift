//
//  OpenTargetMode.swift
//  OpenTargets
//
//  Created by Tomohiro Kumagai on 2021/09/11.
//

extension OpenTarget {
    
    public enum Mode : String, Codable {
        
        case normal
        case secret
    }
}

extension OpenTarget.Mode : Sendable {
    
}

extension OpenTarget.Mode : CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        
        case .normal:
            return "Normal Mode"
            
        case .secret:
            return "Secret Mode"
        }
    }
}
