//
//  APIError.swift
//  MLNetworkLayer
//
//  Created by Marcos Lacerda on 18/06/21.
//

public enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
            case .requestFailed: return "Request Failed"
            case .invalidData: return "Invalid Data"
            case .responseUnsuccessful: return "Response Unsuccessful"
            case .jsonParsingFailure: return "JSON Parsing Failure"
            case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
    
}
