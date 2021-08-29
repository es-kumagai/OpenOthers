//
//  ViewController.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Cocoa
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

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
        
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                if (state.isEnabled) {
                    self.appNameLabel.stringValue = "\(appName)'s extension is currently on."
                } else {
                    self.appNameLabel.stringValue = "\(appName)'s extension is currently off. You can turn it on in Safari Extensions preferences."
                }
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            guard error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
