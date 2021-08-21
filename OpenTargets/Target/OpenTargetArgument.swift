//
//  OpenTargetArgument.swift
//  OpenOthers Extension
//
//  Created by Tomohiro Kumagai on 2021/08/21.
//

extension OpenTarget {

    public enum Argument {
    
        case string(String)
        case targetURL
    }
}

private extension OpenTarget.Argument {

    init(_ codingData: CodingData) {
        
        switch codingData.dataType {
        
        case .string:
            self = .string(String(data: codingData.dataBody, encoding: .utf8)!)
            
        case .targetURL:
            self = .targetURL
        }
    }
}

extension OpenTarget.Argument : Codable {
    
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

private extension OpenTarget.Argument {
    
    struct CodingData : Codable {
    
        var dataType: CodingDataType
        var dataBody: Data
    }

    enum CodingDataType : Int, Codable {
        
        case string
        case targetURL
    }
}

private extension OpenTarget.Argument {

    var dataType: CodingDataType {
        
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

extension OpenTarget.Argument : ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        
        self = .string(value)
    }
}
