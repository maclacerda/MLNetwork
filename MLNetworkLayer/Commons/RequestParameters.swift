//
//  RequestParameters.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

import Foundation

public enum RequestParameters {
    case body(_: [String: Any]?)
    case url(_: [String: String]?)
}
