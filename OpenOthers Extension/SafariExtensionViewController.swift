//
//  SafariExtensionViewController.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices
import OpenOthersCore
import OpenTargets

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    @IBOutlet var targetsController: NSArrayController!
    @IBOutlet weak var targetList: NSTableView!
    
    let targetsState = TargetsState()
    
    static let shared: SafariExtensionViewController = {
    
        let shared = SafariExtensionViewController()
                
        shared.preferredContentSize = NSSize(width:350, height:378)
        return shared
    }()

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let targets = targetsState.selectableTargetListItems
        
        targetsController.content = targets.map(TargetTableItem.init)
    }
}

extension SafariExtensionViewController {
    
    var targets: [OpenTarget]! {
   
        guard let targets = targetsController.content as? [TargetTableItem] else {
            
            return nil
        }
        
        return targets.map(\.target)
    }

    func open(_ target: OpenTarget, withLocationInWindow window: SFSafariWindow) {
        
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
}

extension SafariExtensionViewController : NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {

        dismissPopover()

        let tableView = notification.object as! NSTableView
        let selectedRow = tableView.selectedRow

        guard targets.indices.contains(selectedRow) else {

            return
        }
        
        let target = targets[selectedRow]

        SFSafariApplication.getActiveWindow { window in
            
            window.map {

                self.open(target, withLocationInWindow: $0)
            }
        }
    }
}
