//
//  Base64.swift
//  OpenOthers
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

import Foundation

final class Base64Decoder {
    
    func data(from string: String) -> Data? {
        
        Data(base64Encoded: string)
    }
    
    func string(from string: String) -> String? {
        
        data(from: string).flatMap { String(data: $0, encoding: .utf8) }
    }
    
    func url(from string: String) -> URL? {
        
        data(from: string).flatMap { URL(dataRepresentation: $0, relativeTo: nil) }
    }
}
