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

extension OpenTarget.Argument : Sendable {
    
}

extension OpenTarget.Argument : Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        
        switch (lhs, rhs) {
        
        case (.string(let lhsString), .string(let rhsString)):
            return lhsString == rhsString
            
        case (.targetURL, .targetURL):
            return true
            
        default:
            return false
        }
    }
}

extension OpenTarget.Argument {

    init(_ codingData: CodingData) {
        
        switch codingData.dataType {
        
        case .string:
            self = .string(String(data: codingData.dataBody, encoding: .utf8)!)
            
        case .targetURL:
            self = .targetURL
        }
    }
    
    var codingData: CodingData {
        
        CodingData(dataType: dataType, dataBody: dataBody)
    }
}

extension OpenTarget.Argument {
    
    @objc(ESOpenTargetArgumentCodingData)
    @objcMembers
    final class CodingData : NSObject {
    
        let dataType: CodingDataType
        let dataBody: Data
        
        init(dataType: CodingDataType, dataBody: Data) {

            self.dataType = dataType
            self.dataBody = dataBody
        }
    }

    enum CodingDataType : String {
        
        case string
        case targetURL
    }
}

extension OpenTarget.Argument {

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

extension OpenTarget.Argument.CodingData : NSSecureCoding {

    static var supportsSecureCoding = true
    
    convenience init?(coder: NSCoder) {
        
        guard let dataTypeRawValue = coder.decodeObject(of: NSString.self, forKey: "dataTypeRawValue") as? String, let dataType = OpenTarget.Argument.CodingDataType(rawValue: dataTypeRawValue), let dataBody = coder.decodeObject(of: NSData.self, forKey: "dataBody") as? Data else {
            
            return nil
        }
        
        self.init(dataType: dataType, dataBody: dataBody)
    }
    
    func encode(with coder: NSCoder) {

        coder.encode(dataType.rawValue, forKey: "dataTypeRawValue")
        coder.encode(dataBody, forKey: "dataBody")
    }
}
