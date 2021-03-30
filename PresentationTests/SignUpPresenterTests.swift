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
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(password: nil))
        wait(for: [exp], timeout: 1)
        
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
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
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Email"))
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
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignupViewModel())
        addAccountSpy.completionWithError()
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_call_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(loadingViewSpy: loadingViewSpy)
        sut.signUp(viewModel: makeSignupViewModel())
        XCTAssertEqual(loadingViewSpy.viewModel, LoadingViewModel(isLoading: true))
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
    
    func makeSignupViewModel(name: String? = "any_name",
                             email: String? = "any_email",
                             password: String? = "any_password",
                             passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        AlertViewModel(title: "Erro", message: message)
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
    }

    class AlertViewSpy: AlertView {
        
        var emit: ((AlertViewModel) -> Void)?
        
        func observer(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            emit?(viewModel)
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var email: String?
        private var isValid: Bool = true
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail() {
            isValid = false
        }
    }
    
    class AddAccountSpy: AddAccount {
        
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completionWithError() {
            completion?(.failure(.unexpected))
        }
    }
    
    class LoadingViewSpy: LoadingView {

        var viewModel: LoadingViewModel?
        
        func display(viewModel: LoadingViewModel) {
            self.viewModel = viewModel
        }
        
    }
}
