//
//  EmailValidationtTests.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 12/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
import Validation

class EmailValidationtTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidator)
        emailValidator.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "o campo Email é inválido")
    }

    func test_validate_should_return_error_with_correct_field_label() {
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidator)
        emailValidator.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "o campo Email2 é inválido")
    }

    func test_validate_should_no_return_error_if_valid_email_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "valid_email@gmail.com"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "o campo Email é inválido")
    }

}

extension EmailValidationtTests {
    func makeSut(fieldName: String,
                 fieldLabel: String,
                 emailValidator: EmailValidator = EmailValidatorSpy()) -> EmailValidation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut)
        return sut
    }
}

