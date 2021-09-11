//
//  SafariExtensionHandler.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices
import OpenTargets

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }

    override func toolbarItemClicked(in window: SFSafariWindow) {

    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        window.getActivePageProperties { result in

            switch result {
            
            case .success:
                validationHandler(true, "")
                
            case .failure:
                validationHandler(false, "")
            }
        }
    }
    
    override func popoverViewController() -> SafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

    override func popoverDidClose(in window: SFSafariWindow) {
        
    }
    override func popoverWillShow(in window: SFSafariWindow) {
        
        SafariExtensionViewController.shared.updateTargetList()
    }
}
