//
//  SignUpIntegrationTest.swift
//  MainTests
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import XCTest
import Main

class SignUpComposerTests: XCTestCase {
    func test_ui_presentation_integration() {
        debugPrint(Environment.variable(.apiBaseUrl))
        let sut = SignUpComposer.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
