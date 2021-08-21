//
//  OpenTargetArgument.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

public enum OpenTargetArgument {
    
    case string(String)
    case targetURL
}

private extension OpenTargetArgument {

    init(_ codingData: CodingData) {
        
        switch codingData.dataType {
        
        case .string:
            self = .string(String(data: codingData.dataBody, encoding: .utf8)!)
            
        case .targetURL:
            self = .targetURL
        }
    }
}

extension OpenTargetArgument : Codable {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        let codingData = try container.decode(CodingData.self)
        
        self.init(codingData)
    }
    
    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        let codingData = CodingData(dataType: dataType, dataBody: dataBody)
        
        try container.encode(codingData)
    }
}

private extension OpenTargetArgument {
    
    struct CodingData : Codable {
    
        var dataType: CodingDataType
        var dataBody: Data
    }

    enum CodingDataType : Int, Codable {
        
        case string
        case targetURL
    }
}

private extension OpenTargetArgument {

    var dataType: OpenTargetArgument.CodingDataType {
        
        switch self {
        
        case .string:
            return .string
            
        case .targetURL:
            return .targetURL
        }
    }
    
    var dataBody: Data {
        
        switch self {
        
        case .string(let string):
            return string.data(using: .utf8)!
            
        case .targetURL:
            return Data()
        }
    }
}

extension OpenTargetArgument : ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        
        self = .string(value)
    }
}
