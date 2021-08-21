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
        
        let target: OpenTarget = GoogleChrome()
        
        window.getActivePageProperties { result in

            do {
                let (page, properties) = try result.get()
                
                guard let url = properties.url else {
                    
                    return page.dispatchMessageToScript(with: .urlNotFound())
                }

                NSWorkspace.shared.open(target, with: url) { result in
                    
                    switch result {
                    
                    case .success:
                        break
                    
                    case .failure(.notSupported):
                        page.dispatchMessageToScript(with: .targetNotSupported(target))
                        
                    case .failure(_):
                        page.dispatchMessageToScript(with: .failedToOpenTarget(target))
                    }
                }
            }
            catch SafariError.propertiesNotFound(in: let page?) {
                
                page.dispatchMessageToScript(with: .urlNotFound())
            }
            catch {
                
                fatalError("Failed to get properties in active page.")
            }
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
