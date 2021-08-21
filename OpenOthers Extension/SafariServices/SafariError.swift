//
//  SafariServiceError.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices

enum SafariError : Error {
    
    case tabNotFound(on: SFSafariWindow?)
    case pageNotFound(on: SFSafariTab?)
    case propertiesNotFound(in: SFSafariPage?)
}
