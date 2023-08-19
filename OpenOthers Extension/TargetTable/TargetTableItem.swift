//
//  TargetTableItem.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/23.
//

import Cocoa
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
    
    convenience init(_ item: TargetTableItem) {
        
        self.init(target: item.target, iconImage: item.iconImage)
    }

//    @MainActor
//    static var currentWorkspace = NSWorkspace.shared
//
//    @MainActor
//    static func bundle(for target: OpenTarget) -> Bundle? {
//
//        guard let url = currentWorkspace.urlForApplication(withBundleIdentifier: target.bundleIdentifier) else {
//
//            return nil
//        }
//
//        return Bundle(url: url)
//    }
    
//    convenience init(_ item: TargetListItem) {
//
//        self.init(target: item.target, iconImage: item.iconImage)
//    }
    
//    @MainActor
//    convenience init(target: OpenTarget) {
//        
//        let bundle = Self.bundle(for: target)
//        NSLog("🌈 \(target.name) \(bundle)")
//        self.init(target: target, iconImage: bundle?.iconImage)
//    }
}

extension Array<TargetTableItem> {
    
    @MainActor
    init(from targets: some Sequence<OpenTarget>) async {
        
        self.init()
        
        let helperProxy = SafariWebExtensionHelper.default.proxy!
        
        for target in targets {
            
            let icon = await helperProxy.iconImage(for: target)
            let item = TargetTableItem(target: target, iconImage: icon)
            
            self.append(item)
        }
    }
}
