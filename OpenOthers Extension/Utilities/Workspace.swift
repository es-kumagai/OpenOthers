//
//  Workspace.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import AppKit
import OpenTargets
import OpenOthersCore

extension NSWorkspace {

    func open(_ target: OpenTarget, with url: URL, completionHandler: ((Result<Void, OpenTarget.Error>) -> Void)? = nil) {
        
        do {
            
            let encoder = JSONEncoder()
            let targetData = try encoder.encode(target).base64EncodedString()
            let urlData = url.dataRepresentation.base64EncodedString()
            
            let url = URL(string: "\(basicScheme)://open?target=\(targetData)&url=\(urlData)")!
            
            NSWorkspace.shared.open(url)
            
            completionHandler?(.success(()))
        }
        catch let error as EncodingError {
            
            completionHandler?(.failure(.invalidTarget(target, description: error.localizedDescription)))
        }
        catch {
            
            completionHandler?(.failure(.unexpected(description: error.localizedDescription)))
        }
    }
}
