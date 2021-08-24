//
//  SafeUserDefaultsError.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

public extension SafeUserDefaults {
    
    enum ReadError : Error {
    
        case invalidKey(Any)
        case incompatibleValue(Any, with: Any.Type)
        case failedToUnarchive(Error)
    }
    
    enum WriteError : Error {
        
        case failedToArchive(Error)
        case incompatibleValue
    }
}
