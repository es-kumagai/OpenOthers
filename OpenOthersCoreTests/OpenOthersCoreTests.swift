//
//  OpenOthersCoreTests.swift
//  OpenOthersCoreTests
//
//  Created by Tomohiro Kumagai on 2021/08/22.
//

import XCTest
@testable import OpenOthersCore

class OpenOthersCoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSecureCoding() throws {

        func test(target: OpenTarget) throws {
            
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: target, requiringSecureCoding: true)
            let decodedTarget = try NSKeyedUnarchiver.unarchivedObject(ofClass: OpenTarget.self, from: encodedData)

            XCTAssertEqual(decodedTarget?.name, target.name)
            XCTAssertEqual(decodedTarget?.bundleIdentifier, target.bundleIdentifier)
            XCTAssertEqual(decodedTarget?.mode, target.mode)
            XCTAssertEqual(decodedTarget?.arguments, target.arguments)
            XCTAssertEqual(decodedTarget?.createNewInstance, target.createNewInstance)
        }
        
        try test(target: .appleSafari)
        try test(target: .appleSafariSecretMode)
        try test(target: .brave)
        try test(target: .braveSecretMode)
        try test(target: .googleChrome)
        try test(target: .googleChromeSecretMode)
        try test(target: .microsoftEdge)
        try test(target: .microsoftEdgeSecretMode)
        try test(target: .mozillaFirefox)
        try test(target: .mozillaFirefoxSecretMode)
        try test(target: .operaNeon)
        try test(target: .operaNeonSecretMode)
        try test(target: .vivaldi)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
