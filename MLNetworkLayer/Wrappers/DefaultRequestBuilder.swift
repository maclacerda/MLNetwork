//
//  DefaultRequestBuilder.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation

public final class DefaultRequestBuilder: RequestBuilder {
    
    // MARK: - Private Properties
        
    private var baseURL: URL
    private var path: String?
    private var method: HTTPMethod = .get
    private var headers: [String: String]?
    private var parameters: RequestParameters?
        
    // MARK: - Initialization
        
    public init(request: RequestProtocol) {
        self.baseURL = request.baseURL
        self.path = request.path
        self.method = request.method
        self.headers = request.headers
        self.parameters = request.parameters
    }
        
    public init(with baseURL: URL, path: String? = nil) {
        self.baseURL = baseURL
        self.path = path
    }
        
    // MARK: - Builder methods
        
    @discardableResult
    public func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
        
    @discardableResult
    public func set(path: String?) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    public func set(headers: [String: String]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func set(parameters: RequestParameters?) -> Self {
        self.parameters = parameters
        return self
    }

    public func build() throws -> URLRequest {
        var url = baseURL
        
        if let path = self.path {
            url = baseURL.appendingPathComponent(path)
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100)
        
        urlRequest.httpMethod = method.name
        
        setupRequest(&urlRequest, with: parameters)
        
        headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return urlRequest
    }
        
    // MARK: - Private methods
    
    private func setupRequest(_ request: inout URLRequest, with parameters: RequestParameters?) {
        if let parameters = parameters {
            switch parameters {
                case .body(let bodyParameters):
                    configureBodyParameters(bodyParameters, for: &request)
                    
                case .url(let urlParameters):
                    configureURLParameters(urlParameters, for: &request)
            }
        }
    }
        
    private func configureBodyParameters(_ parameters: [String: Any]?, for request: inout URLRequest) {
        if let bodyParameters = parameters,
           let payload = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) {
            request.httpBody = payload
        }
    }
        
    private func configureURLParameters(_ parameters: [String: String]?, for request: inout URLRequest) {
        if let urlParameters = parameters,
           let url = request.url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value) }

            request.url = urlComponents.url
        }
    }
}
