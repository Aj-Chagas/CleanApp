//
//  EmailValidator.swift
//  Presentation
//
//  Created by Anderson Chagas on 18/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
