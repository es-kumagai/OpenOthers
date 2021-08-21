//
//  URL.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Foundation

extension URL {

    var queries: Dictionary<String, String> {
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            
            return [:]
        }
        
        guard let queries = components.queryItems else {
            
            return [:]
        }
        
        return queries.reduce(into: [:]) { queries, query in

            queries[query.name] = query.value
        }
    }
}
