//
//  Album.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation
import UIKit

public struct Album: Codable {
	let albumName: String
	let artistName: String
	let albumArtImageURL: URL
	var genre: String?
	var releaseDateString: String?
	var copyrightInfo: String?
	
	/*
	Assuming that these three fields to be displayed in AlbumTableViewController are required.
	And the additional fields to be displayed in AlbumDetailViewController are not.
	*/
	
	init?(json: [String: Any]) {
		guard let albumName = json["name"] as? String,
			let artistName = json["artistName"] as? String,
			let albumArtImageURLString = json["artworkUrl100"] as? String,
			let albumArtImageURL = URL(string: albumArtImageURLString) else { return nil }
		
		self.albumName = albumName
		self.artistName = artistName
		self.albumArtImageURL = albumArtImageURL
		
		if let genres = json["genres"] as? [[String: Any]] {
			var albumGenre = ""
			for genre in genres {
				if let musicGenre = genre["name"] as? String {
					albumGenre += musicGenre + " "
				}
			}
			self.genre = albumGenre
		}
		
		if let releaseDate = json["releaseDate"] as? String {
			self.releaseDateString = releaseDate
		}
		
		if let copyrightInfo = json["copyright"] as? String {
			self.copyrightInfo = copyrightInfo
		}
	}
}
