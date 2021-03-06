//
//  AlbumDetailViewControllerTests.swift
//  nikePodcastTests
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import XCTest
@testable import ShoeGaze

class AlbumDetailViewControllerTests: XCTestCase {

    var sut: AlbumDetailViewController?
    
    override func setUp() {
        super.setUp()
        sut = AlbumDetailViewController()
        
    }
    
    override func tearDown() {
        sut?.album = nil
        sut = nil
        super.tearDown()
    }
    
    func testOnViewDidLoad_buttonSetsUp() {
          guard let sut = sut else {
            XCTFail()
            return
        }
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.buyButton.titleLabel?.text, "See in Apple Music")
        XCTAssertEqual(sut.buyButton.backgroundColor, .blue)
    }
    
    func testOnViewDidLoad_expectedNumberOfSubViewPresent() {
          guard let sut = sut else {
            XCTFail()
            return
        }
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.contentView.subviews.count, 7)
    }
    
    func testOnConfigure_genreStringBuilt(){
          guard let sut = sut else {
            XCTFail()
            return
        }
        let dummydata = MockAPI().fisrt
        
        sut.album = dummydata
        
        sut.configure()
        
        XCTAssertEqual(sut.genreLabel.text, "Soundtrack, Music")
        XCTAssertNotEqual(sut.genreLabel.text, "Soundtrack, Music, ")
    }

    func testOnConfigure_labelFilled(){
          guard let sut = sut else {
            XCTFail()
            return
        }
        let dummydata = MockAPI().fisrt
        
        sut.album = dummydata
        
        sut.configure()
        
        XCTAssertEqual(sut.artistLabel.text, "Various Artists")
        XCTAssertEqual(sut.albumLabel.text, "Birds of Prey: The Album")
        XCTAssertEqual(sut.releaseDateLabel.text, "2020-02-07")
        XCTAssertEqual(sut.copyrightLabel.text, "℗ 2020 Atlantic Recording Corporation and Warner Bros. Entertainment Inc.")
    }
}
