//
//  ViewController.swift
//  OpenOthersLauncher
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import Ocean

class ViewController: NSViewController, NotificationObservable {
    
    var notificationHandlers = Notification.Handlers()
    
    @IBOutlet var selectedTargetLabel: NSTextField!
    @IBOutlet var urlLabel: NSTextField!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        selectedTargetLabel.stringValue = ""
        urlLabel.stringValue = ""
    }
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        
        observe(OpenRequestDetectedNotification.self) { [unowned self] notification in
            
            selectedTargetLabel.stringValue = notification.target.name
            urlLabel.stringValue = notification.url.absoluteString
        }
    }

    override func viewWillDisappear() {
        
        super.viewWillDisappear()
        
        notificationHandlers.releaseAll()
    }
}

