//
//  Bundle.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Foundation

extension Bundle {
    
    var launcherURL: URL! {
        
        url(forAuxiliaryExecutable: "OpenOthersLauncher.app")
    }
    
    var bundleForLauncher: Bundle! {
        
        launcherURL.flatMap(Bundle.init(url:))
    }
}
