//
//  RequestProtocol.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation

public protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: RequestParameters? { get }
}
