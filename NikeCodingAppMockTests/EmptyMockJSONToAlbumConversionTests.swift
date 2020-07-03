//
//  NikeCodingAppMockTests.swift
//  NikeCodingAppMockTests
//
//  Created by Suraj Bastola on 7/3/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest
@testable import NikeCodingApp

class EmptyMockJSONToAlbumConversionTests: XCTestCase {
	var mockData: Data?
	
	override func setUpWithError() throws {
		do {
			try super.setUpWithError()
		} catch {
			throw error
		}
		
		if let mockResponsePath = Bundle(for: type(of: self)).path(forResource: "albumsAPIEmptyResponse", ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: mockResponsePath), options: .alwaysMapped)
				mockData = data
			} catch {
				throw error
			}
		}
	}
	
	override func tearDownWithError() throws {
		mockData = nil
		do {
			try super.tearDownWithError()
		} catch {
			throw error
		}
	}
	
	func testConvertingMockJSONToAlbumReturns10AlbumModels() throws {
		guard let mockData = mockData else {
			XCTFail("Invalid path to mock json")
			return
		}
		do {
			if let albums = try mockData.convertedToAlbums() {
				XCTAssertTrue(albums.isEmpty, "Albums count is not empty")
			}
		} catch {
			throw error
		}
	}
}
