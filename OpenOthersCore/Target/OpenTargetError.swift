//
//  OpenTargetError.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

extension OpenTarget {

    public enum Error : Swift.Error {
        
        case unexpected(description: String)
        case notSupported
        case invalidTarget(OpenTarget, description: String)
        case failedToLaunch(description: String)
    }
}
