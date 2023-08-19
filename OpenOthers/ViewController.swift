//
//  ViewController.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
@preconcurrency import SafariServices

let appName = "OpenOthers"
let extensionBundleIdentifier = "jp.ez-net.OpenOthers.Extension"

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    @IBOutlet var appDescriptionLabel: NSTextField!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let appDescription: String?
        
        if let safariExtensionBundle = Bundle.main.safariExtensionBundle {
            
            appDescription = safariExtensionBundle.object(forInfoDictionaryKey: "NSHumanReadableDescription") as? String
        }
        else {
            
            appDescription = nil
        }
        
        appNameLabel.stringValue = appName
        appDescriptionLabel.stringValue = appDescription ?? ""
        
        Task {
            
            guard let state = try? await SFSafariExtensionManager.stateOfSafariExtension(withIdentifier: extensionBundleIdentifier) else {
                
                return
            }
            
            switch state.isEnabled {
                
            case true:
                appNameLabel.stringValue = "\(appName)'s extension is currently on."
                
            case false:
                appNameLabel.stringValue = "\(appName)'s extension is currently off. You can turn it on in Safari Extensions preferences."
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            guard error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }
            
            NSApplication.shared.terminate(nil)
        }
    }

}
