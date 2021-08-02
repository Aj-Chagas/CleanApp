//
//  AccountModelFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 04/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    AccountModel(accessToken: "any_token", name: "any_name")
}

func makeAddAccountModel() -> AddAccountModel {
    AddAccountModel(name: "any_name", email: "any_email@email.com", password: "any_password", passwordConfirmation: "any_password")
}

func makeAuthenticationModel() -> AuthenticationModel {
    AuthenticationModel(email: "any_email@gmail.com", password: "any_password")
}
