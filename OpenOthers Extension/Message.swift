//
//  Message.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import OpenOthersCore

extension SafariMessage {
    
    static func urlNotFound() -> SafariMessage {
        
        SafariMessage(name: "URLNotFound", userInfo: nil)
    }
    
    static func targetNotSupported(_ target: OpenTarget) -> SafariMessage {
        
        SafariMessage(name: "TargetNotSupported", userInfo: ["Target" : target.description])
    }
    
    static func failedToOpenTarget(_ target: OpenTarget) -> SafariMessage {
        
        SafariMessage(name: "FailedToOpenTarget", userInfo: ["Target" : target.description])
    }
}
