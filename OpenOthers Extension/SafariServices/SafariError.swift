//
//  SafariServiceError.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

@preconcurrency import SafariServices

enum SafariError : Error {
    
    case windowNotFound
    case tabNotFound(on: SFSafariWindow?)
    case pageNotFound(on: SFSafariTab?)
    case propertiesNotFound(in: SFSafariPage?)
}
