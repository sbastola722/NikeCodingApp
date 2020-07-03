//
//  NikeCodingAppNetworkingTests.swift
//  NikeCodingAppNetworkingTests
//
//  Created by Suraj Bastola on 7/2/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import XCTest
@testable import NikeCodingApp

class FetchItunesAlbumsAPITests: XCTestCase {
	var backEndRouter: BackendRouter?
	
	override func setUpWithError() throws {
		do {
			try super.setUpWithError()
		} catch {
			throw error
		}
		backEndRouter = BackendRouter(albumServicesAPI: AlbumServicesAPI(network: Network.shared))
	}
	
	override func tearDownWithError() throws {
		backEndRouter = nil
		do {
			try super.tearDownWithError()
		} catch {
			throw error
		}
	}
	
	func testFetchAlbumAPIReturns() {
		if let url =
			URL(string: ServicesEndPoint.albumFetchURL.rawValue) {
			let promise = expectation(description: "Fetch itunes albums API call returns successfully")
			
			if let network = backEndRouter?.albumServicesAPI.network {
				let dataTask = network.urlSession.dataTask(with: url) { (data, response, error) in
					promise.fulfill()
				}
				dataTask.resume()
			}
			
			wait(for: [promise], timeout: 5)
		}
	}
	
	func testFetchAlbumAPIFails() {
		if let url =
			URL(string: ServicesEndPoint.albumFetchURL.rawValue + "FDJKJDFKJDSLKFJDLSKFJLDKSJFLDSJFLKJKDSLFLDKJSFLKJLSDJF") { // Random String
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
	
	func testFetchAlbumAPIReturns200StatusCode() {
		if let url =
			URL(string: ServicesEndPoint.albumFetchURL.rawValue) {
			let promise = expectation(description: "Fetch itunes albums API call returned status code of 200")
			
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
	
	func testFetchAlbumMethodReturnsValidAlbums() {
		if let url =
			URL(string: ServicesEndPoint.albumFetchURL.rawValue) {
			let promise = expectation(description: "Fetch itunes albums API call returns valid albums")
			
			var responseAlbums = [Album]()
			var responseError: Error?
			
			backEndRouter?.fetchAlbums(from: url, completion: { (albums, error) in
				responseError = error
				if let albums = albums {
					responseAlbums = albums
				}
				promise.fulfill()
			})
			
			wait(for: [promise], timeout: 5)
			XCTAssertNil(responseError)
			XCTAssertFalse(responseAlbums.isEmpty, "Response albums from fetch itunes album API call is empty")
		}
	}
}
