//
//  SafariExtensionViewController.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

@preconcurrency import SafariServices
import OpenOthersCore
import OpenOthersHelper

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    @IBOutlet var targetsController: NSArrayController!
    @IBOutlet var targetList: NSTableView!
    
    @objc var withSecretMode = false {
        
        didSet {
            updateTargetList()
        }
    }
    
//    let targetsState = TargetsState()
    
    static let shared: SafariExtensionViewController = {

        let shared = SafariExtensionViewController()

        shared.preferredContentSize = NSSize(width:350, height:260)
        return shared
    }()

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    deinit {
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
              
        guard let helperProxy = SafariWebExtensionHelper.default.proxy else {

            NSLog("Failed to get helper proxy.")
            return
        }
        
        Task {
            
            guard let window = await SFSafariApplication.activeWindow() else {
                NSLog("No active window.")
                return
            }
            
            let currentTargetMode = try? await window.activePageProperties.currentTargetMode
                        
            func includesTarget(_ target: OpenTarget) -> Bool {
                
                guard target.bundleIdentifier == AppleSafari.bundleIdentifier else {
                    
                    return true
                }
                
                return currentTargetMode == target.mode
            }
            
            NSLog("🌀🌀🌀 ここで Helper が OpenTarget をリターンしようとしたときに、正しく NSSecure でエンコードできない、呼び出し先から戻らなくなっています。")
            let selectableTargets = await helperProxy.selectableTargets()
                .filter { $0.mode == targetMode }
                .filter { includesTarget($0) }
                .sorted { $0.name < $1.name }
            
            NSLog("☀️☀️☀️ \(selectableTargets)")
            Task { @MainActor in
                
                let selectableTargetTableItems = await [TargetTableItem](from: selectableTargets)
                
                NSLog("☀️ \(selectableTargetTableItems)")
                targetsController.content = selectableTargetTableItems
            }
        }
    }
    
    func open(_ target: OpenTarget, withLocationInWindow window: SFSafariWindow) async {

        guard let page = try? await window.activePage else {
            
            NSLog("No active page in window.")
            return
        }

        do {
            guard let helperProxy = SafariWebExtensionHelper.default.proxy else {
                
                NSLog("Failed to get helper proxy.")
                page.dispatchMessageToScript(with: .failedToOpenTarget(target))
                return
            }

            guard let url = try await page.properties.url else {
                
                page.dispatchMessageToScript(with: .urlNotFound())
                return
            }
            
            guard target.bundleIdentifier != AppleSafari.bundleIdentifier else {
                
                await SFSafariApplication.openWindow(with: url)
                return
            }
            
            guard await helperProxy.open(target, pageURL: url) else {
                
                page.dispatchMessageToScript(with: .failedToOpenTarget(target))
                return
            }
        } catch {
            
            page.dispatchMessageToScript(with: .failedToOpenTarget(target))
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

        Task {
            if let window = await SFSafariApplication.activeWindow() {
                
                await open(target, withLocationInWindow: window)
            }
        }
    }
}
