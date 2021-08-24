//
//  TargetsState.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/24.
//

import Foundation

public struct TargetsState {
    
    @UserDefaultsStore(key: "selectable_target_list_items", appGroupID: appGroupID)
    public var selectableTargetListItems: Array<TargetListItem> = []
    
    public init() {
        
    }
}

