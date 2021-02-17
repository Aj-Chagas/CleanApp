//
//  TestFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 04/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

func makeInvalidData() -> Data {
    Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    Data("{\"name\": \"Anderson\"}".utf8)
}

func makeUrl() -> URL {
    URL(string: "http://any-url.com")!
}

func makeError() -> NSError {
    NSError(domain: "any_erroe", code: 0)
}
