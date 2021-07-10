//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

func makeSignupViewModel(name: String? = "any_name",
                         email: String? = "any_email@email.com",
                         password: String? = "any_password",
                         passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
