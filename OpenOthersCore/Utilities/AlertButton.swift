//
//  AlertButton.swift
//  OpenOthersCore
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import AppKit

extension NSAlert {
    
    public struct Button {

        public typealias Action = () -> Void
        
        public var style: Style
        public var action: Action? = nil
    }
}

public extension NSAlert.Button {
    
    enum Style {
        
        case ok
        case cancel
        case custom(String)
    }

    init(title: String, action: Action? = nil) {
    
        self.style = .custom(title)
        self.action = action
    }
    
    var title: String {
        
        switch style {
        
        case .ok:
            return "OK"
            
        case .cancel:
            return "Cancel"
            
        case .custom(let title):
            return title
        }
    }
    
    func invokeAction() {
        
        action?()
    }
}

extension NSAlert {
    
    func addButton(_ button: Button) {
        
        addButton(withTitle: button.title)
    }
}
