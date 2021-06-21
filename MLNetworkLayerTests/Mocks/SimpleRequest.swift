//
//  SimpleRequest.swift
//  MLNetworkLayerTests
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation
import MLNetworkLayer

struct SimpleRequest: RequestProtocol {
    
    public var baseURL: URL
    public var path: String?
    public var method: HTTPMethod
    public var parameters: RequestParameters?
    public var headers: [String : String]?
    
    public init(url: URL, method: HTTPMethod = .get) {
        self.baseURL = url
        self.method = method
    }
    
}
