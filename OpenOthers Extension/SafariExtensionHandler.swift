//
//  SafariExtensionHandler.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices
import OpenOthersCore
import OpenOthersHelper

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }

    override func toolbarItemClicked(in window: SFSafariWindow) {

    }
    
    @MainActor
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        Task {
            do {
                let _ = try await window.activePageProperties
                validationHandler(true, "")
            } catch {
                validationHandler(false, "")
            }
        }
    }
    
    @MainActor
    override func popoverViewController() -> SafariExtensionViewController {
        SafariExtensionViewController.shared
    }

    @MainActor
    override func popoverWillShow(in window: SFSafariWindow) {
        SafariExtensionViewController.shared.updateTargetList()
    }
}
