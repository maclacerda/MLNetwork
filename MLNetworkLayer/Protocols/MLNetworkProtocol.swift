//
//  MLNetworkProtocol.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation
import Combine

public protocol MLNetworkProtocol {
    var session: URLSession { get }
    func makeRequest<T: Codable>(with builder: RequestBuilder, decodingType: T.Type, queue: DispatchQueue, retries: Int) throws -> AnyPublisher<T, Error>
}

extension MLNetworkProtocol {
    
    func makeRequest<T: Codable>(with builder: RequestBuilder, decodingType: T.Type, queue: DispatchQueue = .main, retries: Int = 0) throws -> AnyPublisher<T, Error> {
        do {
            let request = try builder.build()
            
            return session.dataTaskPublisher(for: request)
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                        throw APIError.responseUnsuccessful
                    }
                    
                    return $0.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: queue)
                .retry(retries)
                .eraseToAnyPublisher()
        } catch {
            throw APIError.requestFailed
        }
    }
    
}
