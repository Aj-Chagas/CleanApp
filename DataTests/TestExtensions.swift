//
//  TextExtensions.swift
//  DataTests
//
//  Created by Anderson Chagas on 04/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
