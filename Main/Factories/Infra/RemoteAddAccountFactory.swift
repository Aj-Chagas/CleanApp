//
//  RemoteAddAccountFactory.swift
//  Main
//
//  Created by Anderson Chagas on 31/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

func makeApiUrl(path: String) -> URL {
    URL(string: "\(Environment.variable(.apiBaseUrl))/\(path)")!
}
