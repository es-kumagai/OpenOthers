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
        
        let task = Process()
        
        task.launchPath = "/usr/bin/open"
        task.arguments = arguments
        task.launch()
        
        task.waitUntilExit()
        
//        let output = Pipe()
//        let applicationName = applicationURL.deletingPathExtension().lastPathComponent
//        let getPIDTask = Process()
//
//        getPIDTask.launchPath = "/usr/bin/pgrep"
//        getPIDTask.arguments = [
//            "-nx",
//            applicationName,
//        ]
//        getPIDTask.standardOutput = output
//        getPIDTask.launch()
//        getPIDTask.waitUntilExit()  // FIXME: ここで応答が返ってこない。
//
//        let processIDData = output.fileHandleForReading.readDataToEndOfFile()
//        let processIDString = String(data: processIDData, encoding: .ascii)!
//        let processID = Int(processIDString)!
//        let pid = pid_t(processID)
//
//        // FIXME: プロセス ID を取得して、completionHandler を呼ぶ必要がある。
//        guard let application = NSRunningApplication(processIdentifier: pid) else {
//
//            completionHandler?(.failure(.failedToLaunch(description: "Task did not start.")))
//            return
//        }
//
//        completionHandler?(.success(application))
    }
}
