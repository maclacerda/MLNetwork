//
//  MLNetworkProtocolSpy.swift
//  MLNetworkLayerTests
//
//  Created by Marcos Lacerda on 19/06/21.
//

import Combine
import MLNetworkLayer
import Foundation

final class MLNetworkProtocolSpy: MLNetworkProtocol {
    
    var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    private(set) var makeRequestCalled = false
    
    func makeRequest<T: Codable>(with builder: RequestBuilder, decodingType: T.Type, queue: DispatchQueue = .main, retries: Int = 0) throws -> AnyPublisher<T, Error> {
        makeRequestCalled = true
        
        return Just("" as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
