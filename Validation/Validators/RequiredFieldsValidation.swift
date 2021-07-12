//
//  RequiredFieldsValidation.swift
//  Validation
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

public class RequiredFieldsValidation: Validation, Equatable {

    public let fieldName: String
    public let fieldLabel: String

    public init(fieldName: String,
         fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
              !fieldName.isEmpty else {
            return "o campo \(fieldLabel) é obrigatorio"
        }
        return nil
    }

    public static func == (lhs: RequiredFieldsValidation, rhs: RequiredFieldsValidation) -> Bool {
        lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
