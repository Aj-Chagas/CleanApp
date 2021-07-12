//
//  RequiredFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Validation

class RequiredFieldsValidationTests: XCTestCase {

    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "MyName"])
        XCTAssertEqual(errorMessage, "o campo Email é obrigatorio")
    }

    func test_validate_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "MyName"])
        XCTAssertEqual(errorMessage, "o campo Idade é obrigatorio")
    }

    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "nome", fieldLabel: "Nome")
        let errorMessage = sut.validate(data: ["nome": "My Name"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "nome", fieldLabel: "Nome")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "o campo Nome é obrigatorio")
    }

}

extension RequiredFieldsValidationTests {
    func makeSut(fieldName: String,
                 fieldLabel: String,
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RequiredFieldsValidation {
        let sut = RequiredFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
