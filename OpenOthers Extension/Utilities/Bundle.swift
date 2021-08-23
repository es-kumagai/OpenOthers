//
//  Bundle.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/23.
//

import AppKit

extension Bundle {
    
    var iconImage: NSImage? {

        object(forInfoDictionaryKey: "CFBundleIconFile")
            .flatMap { $0 as? String }
            .flatMap { image(forResource: $0) }
    }
}
