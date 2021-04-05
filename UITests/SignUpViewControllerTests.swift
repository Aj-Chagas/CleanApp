//
//  UITests.swift
//  UITests
//
//  Created by Anderson Chagas on 05/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }

    func test_sut_implements_loadingView_Protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_AlertView_Protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }

    func test_saveButton_calls_signUp_on_tap() {
        var callsCount = 0
        let sut = makeSut(singUpSpy: { _ in callsCount += 1})
        sut.saveButton?.simulateTap()
        XCTAssertEqual(callsCount, 1)
    }

}

extension SignUpViewControllerTests {
    func makeSut(singUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = singUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {

    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
