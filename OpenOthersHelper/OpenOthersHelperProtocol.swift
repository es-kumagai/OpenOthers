//
//  OpenOthersHelperProtocol.swift
//  OpenOthersHelper
//  
//  Created by Tomohiro Kumagai on 2023/08/19
//  
//

import AppKit
import OpenOthersCore

/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc public protocol OpenOthersHelperProtocol {
    
    func allTargets() async -> OpenTargets
    func selectableTargets() async -> OpenTargets
    
    @MainActor
    func iconImage(for target: OpenTarget) async -> NSImage?
    
    func open(_ target: OpenTarget, pageURL: URL) async -> Bool
}

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     let connectionToService = NSXPCConnection(serviceName: "jp.ez-net.OpenOthersHelper")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: OpenOthersHelperProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? OpenOthersHelperProtocol {
         proxy.uppercase(string: "hello") { aString in
             NSLog("Result string was: \(aString)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
