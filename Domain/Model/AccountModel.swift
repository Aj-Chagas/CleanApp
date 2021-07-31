//
//  AccountModel.swift
//  Domain
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    public var name: String

    public init(accessToken: String,
                name: String) {
        self.accessToken = accessToken
        self.name = name
    }
}
