//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: Model {

    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    func toAddAccountModel() -> AddAccountModel {
        AddAccountModel(name: name!,
                        email: email!,
                        password: password!,
                        passwordConfirmation: passwordConfirmation!)
    }
}
