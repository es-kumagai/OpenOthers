//
//  NotificationName.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/29.
//

import Ocean
import OpenTargets

struct OpenRequestDetectedNotification : NotificationProtocol {
    
    var target: OpenTarget
    var url: URL
}
