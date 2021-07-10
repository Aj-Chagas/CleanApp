//
//  Validation.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
