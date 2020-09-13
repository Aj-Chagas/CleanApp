//
//  AddAccount.swift
//  Domain
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: Result<AccountModel, Error>)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
