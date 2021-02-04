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
    return AccountModel(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
}
