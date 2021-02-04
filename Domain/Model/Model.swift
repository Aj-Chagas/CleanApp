//
//  Model.swift
//  Domain
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol Model: Codable, Equatable {
}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
