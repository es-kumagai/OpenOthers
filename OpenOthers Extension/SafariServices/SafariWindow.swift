//
//  SafariWindow.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices

extension SFSafariWindow {
    
    func getActivePageProperties(_ completionHandler: @escaping (_ result: Result<(page: SFSafariPage, properties: SFSafariPageProperties), SafariError>) -> Void) {
        
        getActiveTab { tab in
            
            guard let tab = tab else {
                
                return completionHandler(.failure(.tabNotFound(on: self)))
            }
            
            tab.getActivePageProperties(completionHandler)
        }
    }
}
