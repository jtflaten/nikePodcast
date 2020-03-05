//
//  nikePodcastTests.swift
//  nikePodcastTests
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import XCTest
@testable import nikePodcast

class nikePodcastTests: XCTestCase {

        
        var sut: AlbumAPI!
        
        override func setUp() {
            sut = AlbumAPI()
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }
        
        func testAlbumApi_fetchesResults() {
            let exp = expectation(description: "Got API Results")
            sut.fetchAlbums() { result in
                exp.fulfill()
                switch result {
                case .success (let resp):
                    print("TEST RESULT: \(resp.feed.results.count)")
                    XCTAssert(resp.feed.results.count == 100)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
            wait(for: [exp], timeout: 5.0)
        }
}
