//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Anderson Chagas on 04/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy: HttpPostClient {
    
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completionWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completionWithData(_ data: Data) {
        completion?(.success(data))
    }
}
