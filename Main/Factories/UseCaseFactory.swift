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
    
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = "https://clean-node-api.herokuapp.com/api"
    
    private static func makeUrl(path: String) -> URL {
        URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
    }
}
