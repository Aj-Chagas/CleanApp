//
//  AddAccount.swift
//  Domain
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: Result<AccountModel, Error>)
}

public struct AddAccountModel: Model {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}

