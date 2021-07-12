//
//  ValidatorSpy.swift
//  ValidationTests
//
//  Created by Anderson Chagas on 12/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

class ValidatorSpy: Validation {
    
    var errorMessage: String?
    var data: [String: Any]?

    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }

    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
