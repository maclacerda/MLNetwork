//
//  HTTPMethod.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    public var name: String {
        return rawValue.uppercased()
    }
}
