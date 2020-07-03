//
//  DataExtension.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation

extension Data {
	var toDictionary: [String: Any]? {
		guard let dictionary = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else { return nil }
		return dictionary
	}
	
	func convertedToAlbums() throws -> [Album]? {
		guard let jsonDict = toDictionary else {
			throw APIServiceError.jsonParsingError
		}
		guard let feed = jsonDict["feed"] as? [String: Any], let results = feed["results"] as? [[String: Any]] else {
			throw APIServiceError.invalidData
		}
		
		let albums = results.compactMap{Album(json: $0)}
		return albums
	}
}
