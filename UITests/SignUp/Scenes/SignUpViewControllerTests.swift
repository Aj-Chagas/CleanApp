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
        var singUpViewModel: SignUpViewModel?
        let sut = makeSut(singUpSpy: { singUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        let signUpViewModelExpected = SignUpViewModel(name: sut.nameTextField?.text,
                                               email: sut.emailTextField?.text,
                                               password: sut.passwordTextField?.text,
                                               passwordConfirmation: sut.passwordConfirmationTextField?.text)
        XCTAssertEqual(singUpViewModel, signUpViewModelExpected)
    }

}

extension SignUpViewControllerTests {
    func makeSut(singUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instantiate()
        sut.signUp = singUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
