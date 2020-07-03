//
//  DisplayErrorMessagesTests.swift
//  NikeCodingAppTests
//
//  Created by Suraj Bastola on 7/3/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest

@testable import NikeCodingApp

class DisplayErrorMessagesTests: XCTestCase {
	
	override func setUpWithError() throws {
	}
	
	override func tearDownWithError() throws {
	}
	
	func testHTTPErrorDisplayErrorMessage() throws {
		let error = APIServiceError.HTTPError(404, "Not found")
		let displayErrorMessage = "Failed with status code: 404Not found"
		XCTAssertEqual(error.errorMessage, displayErrorMessage, "HTTP Error Messages don't match")
	}
	
	func testJSONParsingDisplayErrorMessage() throws {
		let error = APIServiceError.jsonParsingError
		let displayErrorMessage = "Failed to parse JSON response"
		XCTAssertEqual(error.errorMessage, displayErrorMessage, "JSON Parsing Error Messages don't match")
	}
	
	func testInvalidDataDisplayErrorMessage() throws {
		let error = APIServiceError.invalidData
		let displayErrorMessage = "Received invalid data from server"
		XCTAssertEqual(error.errorMessage, displayErrorMessage, "Invalid Data Error Messages don't match")
	}
	
	func testDisplayErrorMessageFor() throws {
		let error = APIServiceError.emptyData
		let displayErrorMessage = "Received empty data from server"
		XCTAssertEqual(error.errorMessage, displayErrorMessage, "Empty Data Error Messages don't match")
	}
}
