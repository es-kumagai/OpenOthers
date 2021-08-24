//
//  TargetTableItem.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/23.
//

import Cocoa
import OpenTargets
import OpenOthersCore

@objcMembers
final class TargetTableItem: NSObject {

    var target: OpenTarget
    var iconImage: NSImage?
    
    init(target: OpenTarget, iconImage: NSImage?) {
    
        self.target = target
        self.iconImage = iconImage
    }
    
    var name: String {
        
        target.name
    }
}

extension TargetTableItem {
    
    convenience init(_ item: TargetListItem) {
        
        self.init(target: item.target, iconImage: item.iconImage)
    }
}
