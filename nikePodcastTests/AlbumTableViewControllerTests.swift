//
//  AlbumTableViewControllerTests.swift
//  nikePodcastTests
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import XCTest
@testable import nikePodcast

class AlbumTableViewControllerTests: XCTestCase {
    
    var sut: AlbumTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = AlbumTableViewController()
        sut.albumClient = MockAPI()
    }

    override func tearDown() {
        sut.albums = []
        sut = nil
        super.tearDown()
    }

    func testOninit_noAblumsLoaded() {
        
        XCTAssertEqual(sut.albums.count, 0)
    }
    
    func testFetchAlbums_fetchesAlbums() {
        sut.fetchAblbums()
        XCTAssertEqual(sut.albums.count, 3)
    }

}

