//
//  SignUpIntegrationTest.swift
//  MainTests
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Main
import UI
import Validation

class SignUpComposerTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, addAccount) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignupViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAccount.completionWithError()
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func test_makeValidations_with_correct_validations() {
        let validations = SignUpComposer.makeValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "name", fieldLabel: "Name"))
        XCTAssertEqual(validations[1] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"))
        XCTAssertEqual(validations[4] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
        XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccount: AddAccountSpy) {
        let addAccount = AddAccountSpy()
        let sut = SignUpComposer.composeControllerWith(addAccount: MainQueueDispatchDecorator(instance: addAccount))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccount, file: file, line: line)
        return (sut, addAccount)
    }
}
