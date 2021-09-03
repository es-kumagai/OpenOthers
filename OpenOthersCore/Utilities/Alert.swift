//
//  ErrorAlertController.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import AppKit

public extension NSApplication {
    
    func showAlert(_ message: String, caption: String = "", style: NSAlert.Style = .critical, buttons: [NSAlert.Button] = []) {
        
        switch (caption, message) {
        
        case ("", ""):
            break
            
        case ("", let log), (let log, ""):
            NSLog("%@", log)

        case (let caption, let message):
            NSLog("%@; %@", caption, message)
        }
        
        func show() {
            
            let alert = NSAlert()
        
            alert.messageText = caption
            alert.informativeText = message
            alert.alertStyle = style
            
            buttons.forEach(alert.addButton(_:))
            
            alert.runModal()
        }

        switch Thread.isMainThread {
        
        case true:
            show()
            
        case false:
            DispatchQueue.main.sync(execute: show)
        }
    }
}
