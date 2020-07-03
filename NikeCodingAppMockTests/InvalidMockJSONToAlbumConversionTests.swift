//
//  NikeCodingAppMockTests.swift
//  NikeCodingAppMockTests
//
//  Created by Suraj Bastola on 7/3/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest
@testable import NikeCodingApp

class InvalidMockJSONToAlbumConversionTests: XCTestCase {
	var mockData: Data?
	
	override func setUpWithError() throws {
		do {
			try super.setUpWithError()
		} catch {
			throw error
		}
		
		if let mockResponsePath = Bundle(for: type(of: self)).path(forResource: "albumsAPIInValidMockResponse", ofType: "json") {
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
	
	func testConvertingInvalidMockJSONToAlbumsThrowsError() throws {
		guard let mockData = mockData else {
			XCTFail("Invalid path to mock json")
			return
		}
		XCTAssertThrowsError(try mockData.convertedToAlbums())
	}
}
