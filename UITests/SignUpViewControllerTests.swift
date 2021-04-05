//
//  UITests.swift
//  UITests
//
//  Created by Anderson Chagas on 05/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }

}
