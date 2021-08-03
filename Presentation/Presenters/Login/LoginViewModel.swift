//
//  LoginViewModel.swift
//  Presentation
//
//  Created by Anderson Chagas on 03/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

public struct LoginViewModel: Model {
    public let email: String?
    public let password: String?
    
    public init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
    
    public func toAuthenticationModel() -> AuthenticationModel {
        AuthenticationModel(email: email!,
                            password: password!)
    }
}
