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
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
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
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
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

    func test_signUp_should_call_validation_with_correct_values() {
        let validation = ValidationSpy()
        let sut = makeSut(validation: validation)
        let viewModel = makeSignupViewModel()
        sut.signUp(viewModel: makeSignupViewModel())
        XCTAssert(NSDictionary(dictionary: viewModel.toJson()!).isEqual(to: validation.data!))
    }

    func test_signUp_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validation = ValidationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, validation: validation)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }

        validation.simulateError()
        sut.signUp(viewModel: makeSignupViewModel())
        wait(for: [exp], timeout: 1)
    }

}

extension SignUpPresenterTests {

    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 addAccountSpy: AddAccountSpy = AddAccountSpy(),
                 loadingViewSpy: LoadingViewSpy = LoadingViewSpy(),
                 validation: Validation = ValidationSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy,
                                  addAccount: addAccountSpy,
                                  loadingView: loadingViewSpy,
                                  validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

}
