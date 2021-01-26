//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: addAccountModel.toData()) { result in
            completion(.failure(.unexpected))
        }
    }
}
