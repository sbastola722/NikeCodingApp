//
//  Network.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation

public class Network: NSObject {
    public static let shared = Network()
    private override init() {}
    
    lazy var urlSession: URLSession = {
        return URLSession.shared
    }()
	
	public static var defaultTimeoutInterval = {
		return TimeInterval(floatLiteral: 60.0)
	}()
    
	
	public func get(from url: URL, timeoutInterval: TimeInterval = Network.defaultTimeoutInterval, completion: @escaping (Result<Data, Error>) -> Void) {
		let request = buildRequest(for: url, httpMethod: HTTPMethod.get, timeOutInterval: timeoutInterval)
        performTask(for: request, completion: completion)
    }
    
    public func buildRequest(for url: URL, httpMethod: HTTPMethod, timeOutInterval: TimeInterval = defaultTimeoutInterval) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeOutInterval)
		request.httpMethod = httpMethod.rawValue
        return request
    }
    
    public func performTask(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
		urlSession.dataTask(with: request)
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
			if let error = error {
                completion(.failure(error))
                return
            }
			let successStatusCodes = 200...299
			if let response = response as? HTTPURLResponse, !successStatusCodes.contains(response.statusCode) {
				completion(.failure(APIServiceError.HTTPError(response.statusCode, nil)))
                return
            }
            
            if let data = data {
                completion(.success(data))
                return
            }
        })
        
        task.resume()
    }
}
