//
//  SafariExtensionHelper.swift
//  OpenOthers Extension
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import Foundation
import OpenOthersHelper

public final class SafariWebExtensionHelper {
    
    public typealias Proxy = OpenOthersHelperProtocol
    
    let service: NSXPCConnection
    
    public static let `default` = SafariWebExtensionHelper()
    
    convenience init() {

        let service = NSXPCConnection(serviceName: "jp.ez-net.OpenOthersHelper")

        self.init(service: service)
    }
    
    init(service: NSXPCConnection) {
        self.service = service

        service.remoteObjectInterface = NSXPCInterface(with: OpenOthersHelperProtocol.self)
        
        service.resume()
        
        NSLog("Helper service has been launched.")
    }
    
    deinit {
        NSLog("Helper service will be terminated.")
        
        service.suspend()
        service.invalidate()
    }
    
    public var proxy: Proxy? {
        service.remoteObjectProxy as? Proxy
    }
}
