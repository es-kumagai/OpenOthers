//
//  Workspace.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import AppKit

extension NSWorkspace {
    
    func openApplication(_ url: URL, with target: OpenTarget, completionHandler: ((_ result: Result<NSRunningApplication, OpenTarget.Error>) -> Void)? = nil) {

        guard let applicationURL = target.applicationURL else {
        
            completionHandler?(.failure(.notSupported))
            return
        }
        
        let arguments = target.arguments.map { argument -> String in
            
            switch argument {
            
            case .string(let string):
                return string
                
            case .targetURL:
                return url.absoluteString
            }
        }
        
        let configuration = OpenConfiguration()
        
        configuration.arguments = arguments
        configuration.createsNewApplicationInstance = target.createNewInstance
        
        openApplication(at: applicationURL, configuration: configuration) { application, error in
            
            switch (application, error) {
            
            case (let application?, nil):
                completionHandler?(.success(application))
                
            case (nil, let error?):
                completionHandler?(.failure(.failedToLaunch(description: error.localizedDescription)))
                
            case (nil, nil), (_?, _?):
                completionHandler?(.failure(.unexpected(description: "An unexpected result was detected while opening the target application.")))
            }
        }
    }
}
