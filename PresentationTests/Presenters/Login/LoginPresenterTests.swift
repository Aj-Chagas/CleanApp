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

    func test_login_should_show_generic_error_message_if_authentication_fails() {
        let authentication = AuthenticationSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, authentication: authentication)
        let exp = expectation(description: "waiting")
        alertView.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authentication.completionWithError()
        wait(for: [exp], timeout: 1)
    }

    func test_login_should_show_error_message_if_authentication_fails_completes_with_expired_session_error() {
        let authentication = AuthenticationSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, authentication: authentication)
        let exp = expectation(description: "waiting")
        alertView.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)."))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authentication.completionWithError(.expiredSession)
        wait(for: [exp], timeout: 1)
    }

    func test_login_should_show_success_message_if_authentication_succeeds() {
        let authentication = AuthenticationSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, authentication: authentication)
        let exp = expectation(description: "waiting")
        alertView.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login feito com sucesso."))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authentication.completionSucceds(with: makeAuthenticationModel())
        wait(for: [exp], timeout: 1)
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
