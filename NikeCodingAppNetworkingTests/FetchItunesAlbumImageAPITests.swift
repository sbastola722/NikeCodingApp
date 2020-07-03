//
//  NikeCodingAppNetworkingTests.swift
//  NikeCodingAppNetworkingTests
//
//  Created by Suraj Bastola on 7/2/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest
@testable import NikeCodingApp

class FetchItunesAlbumImageAPITests: XCTestCase {
	var backEndRouter: BackendRouter?
	var albumImageURLString: String?
	
	override func setUpWithError() throws {
		do {
			try super.setUpWithError()
		} catch {
			throw error
		}
		backEndRouter = BackendRouter(albumServicesAPI: AlbumServicesAPI(network: Network.shared))
		albumImageURLString =  "https://is5-ssl.mzstatic.com/image/thumb/Music114/v4/6d/a8/b4/6da8b446-96fc-ce4d-8dd3-97ba5821dac4/886448263777.jpg/200x200bb.png"
	}
	
	override func tearDownWithError() throws {
		backEndRouter = nil
		albumImageURLString = nil
		do {
			try super.tearDownWithError()
		} catch {
			throw error
		}
	}

	func testFetchAlbumImageAPIReturns() {
		if let albumImageURLString = albumImageURLString, let url =
			URL(string: albumImageURLString) {
			let promise = expectation(description: "Fetch itunes image API call returns successfully")
			
			if let network = backEndRouter?.albumServicesAPI.network {
				let dataTask = network.urlSession.dataTask(with: url) { (data, response, error) in
					promise.fulfill()
				}
				dataTask.resume()
			}
			
			wait(for: [promise], timeout: 5)
		}
	}
	
	func testFetchAlbumImageAPIFails() {
		if let albumImageURLString = albumImageURLString,
			let url = URL(string: albumImageURLString + "JKLJFKLDSJLJLKJSLDFJLKSDJFLKSJDFLKJSDLFKJSLKDFJSDLFKJLSDFJJLKSDJFK") { // Random String
			let promise = expectation(description: "Fetch itunes albums API call fails")
			
			if let network = backEndRouter?.albumServicesAPI.network {
				let dataTask = network.urlSession.dataTask(with: url) { (data, response, error) in
					if error != nil {
						promise.fulfill()
					} else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
						let successCodes = 200...299
						if !successCodes.contains(statusCode) {
							promise.fulfill()
						} else {
							XCTFail("Got success response code: \(statusCode)")
						}
					}
				}
				dataTask.resume()
			}
			wait(for: [promise], timeout: 5)
		}
	}
	
	func testFetchAlbumImageAPIReturns200StatusCode() {
		if let albumImageURLString = albumImageURLString,
			let url = URL(string: albumImageURLString) {
			let promise = expectation(description: "Fetch itunes image API call returned status code of 200")
			
			if let network = backEndRouter?.albumServicesAPI.network {
				let dataTask = network.urlSession.dataTask(with: url) { (data, response, error) in
					if let error = error {
						XCTFail("Error: \(error.localizedDescription)")
						return
					} else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
						if statusCode == 200 {
							promise.fulfill()
						} else {
							XCTFail("Status Code: \(statusCode)")
						}
					}
				}
				dataTask.resume()
			}
			
			wait(for: [promise], timeout: 5)
		}
	}
	
	func testFetchAlbumImageMethodReturnsValidImage() {
		if let albumImageURLString = albumImageURLString,
			let url = URL(string: albumImageURLString) {
			let promise = expectation(description: "Fetch itunes image API call returns valid image")
			
			var responseData: Data?
			var responseError: Error?
			
			backEndRouter?.fetchAlbumImage(from: url) { (data, error) in
				responseError = error
				responseData = data
				promise.fulfill()
			}
			
			wait(for: [promise], timeout: 5)
			XCTAssertNil(responseError)
			XCTAssertNotNil(UIImage(data: responseData ?? Data()), "Failed to get image from fetch itunes image API call")
		}
	}
}
