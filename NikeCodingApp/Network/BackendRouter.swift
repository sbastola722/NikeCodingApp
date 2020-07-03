//
//  BackendRouter.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation
import UIKit

public struct BackendRouter {
	let albumServicesAPI: AlbumServicesAPI
	
	public func fetchAlbums(from url: URL, completion: @escaping (([Album]?, Error?) -> Void)) {
		DispatchQueue.global().async {
			self.albumServicesAPI.fetchAlbums(from: url) { (result) in
				switch result {
				case let .success(data):
					do {
						let albums = try data.convertedToAlbums()
						completion(albums, nil)
					} catch {
						completion(nil, error)
					}
				case let .failure(error):
					completion(nil, error)
				}
			}
		}
	}
	
	public func fetchAlbumImage(from url: URL, completion: @escaping ((Data?, Error?) -> Void)) {
		DispatchQueue.global().async {
			self.albumServicesAPI.fetchImage(from: url) { (result) in
				switch result {
				case let .success(data):
					completion(data, nil)
				case let .failure(error):
					completion(nil, error)
				}
			}
		}
	}
}
