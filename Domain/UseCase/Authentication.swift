//
//  Authentication.swift
//  Domain
//
//  Created by Anderson Chagas on 02/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func auth(addAccountModel: AuthenticationModel, completion: @escaping (Result) -> Void)
}

public struct AuthenticationModel: Model {
    public var email: String
    public var password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
