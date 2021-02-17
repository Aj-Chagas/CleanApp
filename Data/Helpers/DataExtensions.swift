//
//  DataExtensions.swift
//  Data
//
//  Created by Anderson Chagas on 03/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation


public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }

}
