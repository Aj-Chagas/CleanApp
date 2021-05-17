//
//  UseCaseFactory.swift
//  Main
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain
import Data
import Infra

final class UseCaseFactory {
    static func makeRemoteAddAccount() -> AddAccount {
        let alamofireAdapter = AlamofireAdapter()
        return RemoteAddAccount(url: URL(string: "https://clean-node-api.herokuapp.com/api/signup")!, httpClient: alamofireAdapter)
    }
}
