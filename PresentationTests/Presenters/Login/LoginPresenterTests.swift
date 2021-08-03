//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    func test_login_should_call_validation_with_correct_values() {
        let validation = ValidationSpy()
        let sut = makeSut(validation: validation)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssert(NSDictionary(dictionary: viewModel.toJson()!).isEqual(to: validation.data!))
    }

    func test_login_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validation = ValidationSpy()
        let sut = makeSut(validation: validation, alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }

        validation.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_call_addAccount_with_correct_values() {
        let authentication = AuthenticationSpy()
        let sut = makeSut(authentication: authentication)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(authentication.authenticationModel, makeAuthenticationModel())
    }
}

extension LoginPresenterTests {
    func makeSut(validation: Validation = ValidationSpy(),
                 alertView: AlertView = AlertViewSpy(),
                 authentication: Authentication = AuthenticationSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation, alertView: alertView, authentication: authentication)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
