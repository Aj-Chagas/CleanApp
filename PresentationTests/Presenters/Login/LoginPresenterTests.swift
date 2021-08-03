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

}

extension LoginPresenterTests {
    func makeSut(validation: Validation = ValidationSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
