//
//  AuthenticationSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

class AuthenticationSpy: Authentication {

    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?

    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }

    func completionWithError(_ errorType: DomainError = .unexpected) {
        completion?(.failure(errorType))
    }

    func completionSucceds(with authentication: AuthenticationModel) {
        completion?(.success(authentication))
    }
}

