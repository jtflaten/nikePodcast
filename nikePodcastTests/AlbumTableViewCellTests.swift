//
//  AlbumTableViewCellTests.swift
//  nikePodcastTests
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import XCTest
@testable import nikePodcast

class AlbumTableViewCellTests: XCTestCase {
    
    var sut: AlbumTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = AlbumTableViewCell()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testOnConfigure_setsLabels(){
        let dummydata = MockAPI().second
        
        sut.configure(with:dummydata)
        
        XCTAssertEqual(sut.titleLabel.text, "Hood Life Krisis Vol. 1")
        XCTAssertEqual(sut.artistLabel.text, "J.I the Prince of N.Y")
        
        
    }
}

