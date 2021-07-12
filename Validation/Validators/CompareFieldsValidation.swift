//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

public class CompareFieldsValidation: Validation, Equatable {
    
    public let fieldName: String
    public let fieldNameToCompare: String
    public let fieldLabel: String
    
    
    public init(fieldName: String,
                fieldNameToCompare: String,
                fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
              !fieldName.isEmpty,
              let fieldNameToCompare = data?[fieldNameToCompare] as? String,
              fieldName == fieldNameToCompare else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
    
    public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        lhs.fieldName == rhs.fieldName && lhs.fieldNameToCompare == rhs.fieldNameToCompare &&  lhs.fieldLabel == rhs.fieldLabel
    }

}

