//
//  AlbumServicesAPI.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation

public struct AlbumServicesAPI {
	let network: Network

	public func fetchAlbums(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		fetchData(from: url, completion: completion)
	}
	
	public func fetchImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		fetchData(from: url, completion: completion)
	}
	
	fileprivate func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		let fetchRequest = network.buildRequest(for: url, httpMethod: HTTPMethod.get)
		network.performTask(for: fetchRequest, completion: completion)
	}
}
