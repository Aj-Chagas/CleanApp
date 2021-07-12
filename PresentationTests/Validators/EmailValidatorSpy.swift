//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Validation

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
