//
//  MLNetworkProtocolTests.swift
//  MLNetworkLayerTests
//
//  Created by Marcos Lacerda on 20/06/21.
//

import XCTest
@testable import MLNetworkLayer

final class MLNetworkProtocolTests: XCTestCase {
    
    func test_makeRequest_called() {
        // Given
        guard let url = URL(string: "https://www.someurl.com/") else {
            XCTFail("Could not create URL")
            return
        }
        
        let spy = MLNetworkProtocolSpy()
        
        let sut: SimpleRequest = .init(url: url)
        let builder = DefaultRequestBuilder(request: sut)
        
        // When
        _ = try? spy.makeRequest(with: builder, decodingType: String.self)
        
        // Then
        XCTAssertTrue(spy.makeRequestCalled, "The make request should have been called")
    }
    
}
