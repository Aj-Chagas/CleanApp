//
//  HttpError.swift
//  Data
//
//  Created by Anderson Chagas on 16/11/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbideen
}
