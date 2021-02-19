//
//  HttpPostCliente.swift
//  Data
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
