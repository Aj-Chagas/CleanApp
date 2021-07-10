//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: Validation {

    var data: [String: Any]?
    var error: String?

    func validate(data: [String: Any]?) -> String? {
        guard data != nil else { return nil }
        self.data = data
        return error
    }

    func simulateError() {
        self.error = "Erro"
    }

}
