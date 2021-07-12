//
//  ValidationComposite.swift
//  Validation
//
//  Created by Anderson Chagas on 12/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

public class ValidationComposite: Validation {
    
    public let validators: [Validation]
    
    public init(validators: [Validation]) {
        self.validators = validators
    }

    public func validate(data: [String : Any]?) -> String? {
        for validator in validators {
            if let errorMessage = validator.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
