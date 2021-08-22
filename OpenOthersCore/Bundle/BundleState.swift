//
//  BundleState.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

public struct BundleState {
    
    @Store(key: "running_host_bundle_date", appGroupID: appGroupID)
    public var runningHostBundleDate: Date? = nil
    
    public init() {
        
    }
}
