//
//  Bundle.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/29.
//

import AppKit

extension Bundle {
    
    var urlForSafariExtensionBundle: URL? {
        
        builtInPlugInsURL?.appendingPathComponent("OpenOthers Extension.appex")
    }
    
    var safariExtensionBundle: Bundle? {

        urlForSafariExtensionBundle.flatMap(Bundle.init(url:))
    }
}
