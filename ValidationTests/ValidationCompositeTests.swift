//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 12/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() {
        let validatorSpy = ValidatorSpy()
        let sut = ValidationComposite(validators: [validatorSpy])
        validatorSpy.errorMessage = "erro 1"
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "erro 1")
    }

    func test_validate_should_return_correct_error_message() {
        let validatorSpy = ValidatorSpy()
        let sut = ValidationComposite(validators: [validatorSpy])
        validatorSpy.errorMessage = "erro 2"
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "erro 2")
    }
    
    func test_validate_should_return_the_first_error_message() {
        let validatorSpy1 = ValidatorSpy()
        let validatorSpy2 = ValidatorSpy()
        let validatorSpy3 = ValidatorSpy()
        let sut = ValidationComposite(validators: [validatorSpy1, validatorSpy2, validatorSpy3])
        validatorSpy2.simulateError("erro 2")
        validatorSpy3.simulateError("erro 3")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "erro 2")
    }

    func test_validate_should_return_nil_if_validation_succeds() {
        let sut = ValidationComposite(validators: [ValidatorSpy()])
        let errorMessage = sut.validate(data: ["nome": "any_name"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_call_validation_with_correct_data() {
        let validator = ValidatorSpy()
        let sut = ValidationComposite(validators: [validator])
        let data = ["nome": "any_name"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validator.data!).isEqual(to: data))
    }
}
