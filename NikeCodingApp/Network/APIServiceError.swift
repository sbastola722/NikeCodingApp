//
//  HTTPError.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation

public typealias StatusCode = Int
public typealias ErrorCode = String

public enum APIServiceError: Error {
	case HTTPError(StatusCode, ErrorCode?)
	case jsonParsingError
	case invalidData
	case emptyData
	// Add more error types here
	
	var errorMessage: String {
		switch self {
		case let .HTTPError(statusCode, errorCode):
			var errorMessage = "Failed with status code: \(statusCode)"
			if let errorCode = errorCode {
				errorMessage += String(describing: errorCode)
			}
			return errorMessage
		case .jsonParsingError:
			return "Failed to parse JSON response"
		case .invalidData:
			return "Received invalid data from server"
		case .emptyData:
			return "Received empty data from server"
		}
	}
}
