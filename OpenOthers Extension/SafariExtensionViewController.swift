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
    @IBOutlet var targetList: NSTableView!
    
    @objc var withSecretMode = false {
        
        didSet {
            updateTargetList()
        }
    }
    
    let targetsState = TargetsState()
    
    static let shared: SafariExtensionViewController = {
    
        let shared = SafariExtensionViewController()
                
        shared.preferredContentSize = NSSize(width:350, height:260)
        return shared
    }()

    override func awakeFromNib() {
        
        super.awakeFromNib()

    }
}

extension SafariExtensionViewController {
    
    var targetMode: OpenTarget.Mode {

        withSecretMode ? .secret : .normal
    }
    
    var targets: [OpenTarget]! {
   
        guard let targets = targetsController.content as? [TargetTableItem] else {
            
            return nil
        }
        
        return targets.map(\.target)
    }

    func updateTargetList() {
        
        func updateContent(_ content: Array<TargetTableItem>) {

            DispatchQueue.main.async {
                
                self.targetsController.content = content
            }
        }
        
        SFSafariApplication.getActiveWindow { [unowned self] window in
        
            guard let window = window else {
                
                return updateContent([])
            }
            
            window.getActivePageProperties { result in
                
                let usesPrivateBrowsing = try? result.get().properties.usesPrivateBrowsing
                let currentTargetMode: OpenTarget.Mode? = usesPrivateBrowsing.map { $0 ? .secret : .normal }
                
                func includesTarget(_ target: OpenTarget) -> Bool {
                    
                    guard target.bundleIdentifier == AppleSafari.bundleIdentifier else {
                        
                        return true
                    }
                    
                    return currentTargetMode == target.mode
                }
                
                do {
                    
                    let selectableTargets = try targetsState.$selectableTargetListItems.read()
                    let selectableTargetTableItems = selectableTargets
                        .filter { $0.target.mode == targetMode }
                        .filter { includesTarget($0.target) }
                        .sorted { $0.target.name < $1.target.name }
                        .map(TargetTableItem.init)
                    
                    updateContent(selectableTargetTableItems)
                }
                catch {
                    
                    updateContent([])
                }
            }
        }
    }
    
    func open(_ target: OpenTarget, withLocationInWindow window: SFSafariWindow) {
        
        window.getActivePageProperties { result in

            do {
                let (page, properties) = try result.get()
                
                guard let url = properties.url else {
                    
                    return page.dispatchMessageToScript(with: .urlNotFound())
                }

                guard target.bundleIdentifier != AppleSafari.bundleIdentifier else {

                    return SFSafariApplication.openWindow(with: url)
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

        let tableView = notification.object as! NSTableView
        let selectedRow = tableView.selectedRow

        guard targets.indices.contains(selectedRow) else {

            return
        }
        
        let target = targets[selectedRow]

        SFSafariApplication.getActiveWindow { [unowned self] window in
            
            window.map {

                open(target, withLocationInWindow: $0)
            }
        }
    }
}
