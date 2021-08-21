//
//  SafariTab.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import SafariServices

extension SFSafariTab {
    
    func getActivePageProperties(_ completionHandler: @escaping (Result<(page: SFSafariPage, properties: SFSafariPageProperties), SafariError>) -> Void) {
        
        getActivePage { page in
            
            guard let page = page else {
                
                return completionHandler(.failure(.pageNotFound(on: self)))
            }
            
            page.getPropertiesWithCompletionHandler { properties in
                
                guard let properties = properties else {
                    
                    return completionHandler(.failure(.propertiesNotFound(in: page)))
                }
                
                completionHandler(.success((page, properties)))
            }
        }
    }
}
