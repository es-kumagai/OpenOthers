//
//  SafariPageProperties.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import SafariServices
import OpenOthersCore

extension SFSafariPageProperties {
    
    @MainActor
    var currentTargetMode: OpenTarget.Mode {
        
        usesPrivateBrowsing ? .secret : .normal
    }
}
