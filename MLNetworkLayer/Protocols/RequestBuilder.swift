//
//  RequestBuilder.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation

public protocol RequestBuilder {
    init(request: RequestProtocol)
    init(with baseURL: URL, path: String?)
    
    @discardableResult
    func set(method: HTTPMethod) -> Self
    
    @discardableResult
    func set(path: String?) -> Self
    
    @discardableResult
    func set(headers: [String: String]?) -> Self
    
    @discardableResult
    func set(parameters: RequestParameters?) -> Self
    
    func build() throws -> URLRequest
}
