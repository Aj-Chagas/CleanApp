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
    return AccountModel(accessToken: "any_token", name: "any_name")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name", email: "any_email@email.com", password: "any_password", passwordConfirmation: "any_password")
}
