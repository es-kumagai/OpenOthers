//
//  TargetTableItem.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/23.
//

import Cocoa
import OpenTargets

@objcMembers
final class TargetTableItem: NSObject {

    var target: OpenTarget
    
    init(target: OpenTarget) {
    
        self.target = target
    }
    
    var name: String {
        
        target.name
    }
    
    var iconImage: NSImage? {
        
        guard let bundle = Bundle(identifier: target.bundleIdentifier) else {
            
            return nil
        }
        
        return bundle.iconImage
    }
}
