//
//  NikeCodingAppTests.swift
//  NikeCodingAppTests
//
//  Created by Suraj Bastola on 7/3/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest
@testable import NikeCodingApp

class DateConversionTests: XCTestCase {
	var releaseDateString = ""
	
	override func setUpWithError() throws {
		do {
			try super.setUpWithError()
		} catch {
			throw error
		}
		
		releaseDateString = "2020-05-01"
	}
	
	override func tearDownWithError() throws {
		releaseDateString = ""
		do {
			try super.tearDownWithError()
		} catch {
			throw error
		}
	}
	
	func testSuccessfulReleaseDateConversion() throws {
		if let releaseDate = DateFormatters.yyyymmddFormatter.date(from: releaseDateString) {
			let formattedDate = DateFormatters.mmmddyyyyFormatter.string(from: releaseDate)
			XCTAssertEqual(formattedDate, "Jan 01, 2020", "Converted date doesn't match expected date")
		} else {
			XCTFail("Could not convert release date string to date")
		}
	}
}
