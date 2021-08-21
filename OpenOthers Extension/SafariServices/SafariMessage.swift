//
//  SafariMessage.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices

struct SafariMessage {
    
    typealias UserInfo = Dictionary<String, Any>

    var name: String
    var userInfo: UserInfo?
}

extension SFSafariPage {
    
    func dispatchMessageToScript(with message: SafariMessage) {
        
        dispatchMessageToScript(withName: message.name, userInfo: message.userInfo)
    }
}
