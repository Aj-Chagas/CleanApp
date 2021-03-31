//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 18/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(password: nil))
        wait(for: [exp], timeout: 1)
        
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(password: "any_password", passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(email: "invalid_email@gmail.com"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        let signUpViewModel = makeSignupViewModel(email: "email@gmail.com")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

    func test_signUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy)
        sut.signUp(viewModel: makeSignupViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }

    func test_signUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel())
        addAccountSpy.completionWithError()
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel())
        addAccountSpy.completionWithAccount(account: makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy, loadingViewSpy: loadingViewSpy)
        
        XCTContext.runActivity(named: "before calls addAccount isLoading should be true") { _ in
            let exp = expectation(description: "waiting")
            loadingViewSpy.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
                exp.fulfill()
            }
            sut.signUp(viewModel: makeSignupViewModel())
            wait(for: [exp], timeout: 1)
        }

        XCTContext.runActivity(named: "after calls addAccount isLoading should be false") { _ in
            let exp1 = expectation(description: "waiting")
            loadingViewSpy.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
                exp1.fulfill()
            }
            addAccountSpy.completionWithError()
            wait(for: [exp1], timeout: 1)
        }
    }

}

extension SignUpPresenterTests {

    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 addAccountSpy: AddAccountSpy = AddAccountSpy(),
                 loadingViewSpy: LoadingViewSpy = LoadingViewSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy,
                                  emailValidator: emailValidatorSpy,
                                  addAccount: addAccountSpy,
                                  loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
}
