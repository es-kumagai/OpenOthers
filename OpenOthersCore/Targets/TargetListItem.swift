//
//  TargetListItem.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import AppKit
import OpenTargets

public final class TargetListItem {
    
    public var target: OpenTarget
    public var iconImage: NSImage?
    
    public init(target: OpenTarget, iconImage: NSImage?) {
        
        self.target = target
        self.iconImage = iconImage
    }
}

private extension TargetListItem {

    enum Key : String {
        
        case target = "target"
        case iconImage = "icon_image"
    }
}

extension TargetListItem : UserDefaultsStorable {

    public var userDefaultsStoreableValue: Any {
        
        let encoder = JSONEncoder()
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        let targetData = try! encoder.encode(target)
        
        archiver.encode(targetData, forKey: Key.target.rawValue)
        
        if let iconImage = iconImage {

            let iconImageData = try! NSKeyedArchiver.archivedData(withRootObject: iconImage, requiringSecureCoding: NSImage.supportsSecureCoding)

            archiver.encode(iconImageData, forKey: Key.iconImage.rawValue)
        }
        
        return archiver.encodedData
    }
    
    public convenience init?(userDefaultsStorableValue source: Any) {
        
        guard let data = source as? Data else {
            
            return nil
        }
        
        do {

            let archiver = try NSKeyedUnarchiver(forReadingFrom: data)
        
            guard let targetData = archiver.decodeObject(forKey: Key.target.rawValue) as? Data else {
                
                return nil
            }
            
            let target = try JSONDecoder().decode(OpenTarget.self, from: targetData)
            let iconImage = try archiver.decodeObject(forKey: Key.iconImage.rawValue).flatMap {
                
                try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData($0 as! Data) as? NSImage
            }
                        
            self.init(target: target, iconImage: iconImage)
        }
        catch {
            
            return nil
        }
    }
}
