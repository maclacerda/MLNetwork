//
//  APIErrorTests.swift
//  MLNetworkLayerTests
//
//  Created by Marcos Lacerda on 19/06/21.
//

import XCTest
@testable import MLNetworkLayer

final class APIErrorTests: XCTestCase {
    
    func test_errorDescription_ShouldExpected() {
        let expectedMessage = "Invalid Data"
        let sut: APIError = .invalidData
        
        XCTAssertEqual(sut.localizedDescription, expectedMessage)
    }
    
}
