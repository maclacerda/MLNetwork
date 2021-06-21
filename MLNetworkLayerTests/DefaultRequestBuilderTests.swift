//
//  DefaultRequestBuilderTests.swift
//  MLNetworkLayerTests
//
//  Created by Marcos Lacerda on 18/06/21.
//

import XCTest
@testable import MLNetworkLayer

final class DefaultRequestBuilderTests: XCTestCase {
    
    func test_buildRequest_shouldExpectedURLRequest() {
        // Given
        guard let url = URL(string: "https://www.someurl.com/") else {
            XCTFail("Could not create URL")
            return
        }
        
        let sut: SimpleRequest = .init(url: url)
        let builder = DefaultRequestBuilder(request: sut)
        
        // When
        let request = try? builder.build()
        
        // Then
        XCTAssertNotNil(request, "Expected a valid request")
        
        XCTAssertEqual(url, request?.url, "Expected \(url), but got \(String(describing: request?.url))")
    }
    
    func test_buildRequestWithBody_shouldExpectedURLRequest() {
        // Given
        guard let url = URL(string: "https://www.someurl.com/") else {
            XCTFail("Could not create URL")
            return
        }
        
        let expectedMethod = "GET"
        let path = "path"
        let headers = ["header": "value"]
        let parameters = ["param": "paramValue"]
        
        // When
        let builder = DefaultRequestBuilder(with: url)
            .set(method: .get)
            .set(path: path)
            .set(headers: headers)
            .set(parameters: .body(parameters))
        
        guard let sut = try? builder.build() else {
            XCTFail("Could not build URLRequest with builder")
            return
        }
        
        // Then
        let cleanURL = sut.url?.absoluteString.replacingOccurrences(of: path, with: "")
        
        XCTAssertEqual(url.absoluteString, cleanURL, "Expected \(url), but got \(String(describing: sut.url))")
        
        XCTAssertEqual(expectedMethod, sut.httpMethod, "Expected \(String(describing: method)), but got \(String(describing: sut.httpMethod))")
        
        XCTAssertEqual(sut.url?.pathComponents.contains(path), true, "Expected \(path), but got \(String(describing: sut.url?.pathComponents))")
        
        XCTAssertEqual(headers, sut.allHTTPHeaderFields, "Expected \(headers), but got \(String(describing: sut.allHTTPHeaderFields))")
        
        guard let data = sut.httpBody, let body = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
        else {
            XCTFail("Could not get body dictionary from request body")
            return
        }
        
        XCTAssertEqual(parameters, body, "Expected \(parameters), but got \(data)")
    }
    
    func test_buildRequestWithQueryParameters_shouldExpectedURLRequest() {
        // Given
        guard let url = URL(string: "http://www.someurl.com/") else {
            XCTFail("Could not create URL")
            return
        }
        
        let expectedMethod = "GET"
        let path = "path"
        let urlParams = ["param": "paramValue"]
        let expectedAbsoluteStringURL = "http://www.someurl.com/path?param=paramValue"
        
        // When
        let builder = DefaultRequestBuilder(with: url)
            .set(method: .get)
            .set(path: path)
            .set(parameters: .url(urlParams))
        
        guard let sut = try? builder.build() else {
            XCTFail("Could not build URLRequest with builder")
            return
        }
        
        // Then
        XCTAssertEqual(expectedAbsoluteStringURL, sut.url?.absoluteString, "Expected \(expectedAbsoluteStringURL), but got \(String(describing: sut.url?.absoluteString))")
        
        XCTAssertEqual(expectedMethod, sut.httpMethod, "Expected \(String(describing: method)), but got \(String(describing: sut.httpMethod))")
        
        XCTAssertEqual(sut.url?.pathComponents.contains(path), true, "Expected \(path), but got \(String(describing: sut.url?.pathComponents))")
    }
    
}
