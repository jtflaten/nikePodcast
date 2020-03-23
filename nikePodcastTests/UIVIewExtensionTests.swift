//
//  UIVIewExtensionTests.swift
//  nikePodcastTests
//
//  Created by Jake Flaten on 3/8/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import XCTest
@testable import ShoeGaze

class UIVIewExtensionTests: XCTestCase {

    var sut: UIView?
    let arial = "ArialMT"
    
    override func setUp() {
        super.setUp()
        sut = UIView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetScaledFont_returnsReasonablySmallFont() {
        guard let sut = sut else {
            XCTFail()
            return
        }
        let traitCollect = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
        traitCollect.performAsCurrent {
            let font = sut.getScaledFont(forFont: arial, textStyle: .body)
            XCTAssertTrue(font.pointSize < 60)
        }
    }
    
    func testGetScaledFont_returnsReasonablyLargeFont() {
        guard let sut = sut else {
            XCTFail()
            return
        }
        let traitCollect = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
        traitCollect.performAsCurrent {
            let font = sut.getScaledFont(forFont: arial, textStyle: .body)
            XCTAssertTrue(font.pointSize > 16)
        }
    }

    

}
