//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

class AddAccountSpy: AddAccount {

    var addAccountModel: AddAccountModel?
    var completion: ((AddAccount.Result) -> Void)?

    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }

    func completionError(with errorType: DomainError = .unexpected) {
        completion?(.failure(errorType))
    }

    func completionWithAccount(account: AccountModel) {
        completion?(.success(account))
    }
}
