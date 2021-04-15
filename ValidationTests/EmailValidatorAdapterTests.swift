//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 12/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Presentation
@testable import Validation

public final class EmailValidatorAdapter: EmailValidator {
    
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    public init() {}

    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    
//    public func isValid(email: String) -> Bool {
//     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
//    }
}

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "anderson@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "anderson@yahoo.com"))
        XCTAssertTrue(sut.isValid(email: "anderson@hotmail.com.br"))
    }

}
