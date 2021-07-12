//
//  EmailValidationTests.swift
//  Validation
//
//  Created by Anderson Chagas on 12/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

public class EmailValidation: Validation, Equatable {

    public let fieldName: String
    public let fieldLabel: String
    public let emailValidator: EmailValidator

    public init(fieldName: String,
         fieldLabel: String,
         emailValidator: EmailValidator) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }

    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            return "o campo \(fieldLabel) é inválido"
        }
        return nil
    }

    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
