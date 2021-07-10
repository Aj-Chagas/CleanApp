//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 12/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "anderson@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "anderson@yahoo.com"))
        XCTAssertTrue(sut.isValid(email: "anderson@hotmail.com.br"))
    }

}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        EmailValidatorAdapter()
    }
}
