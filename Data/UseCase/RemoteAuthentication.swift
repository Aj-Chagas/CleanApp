//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Anderson Chagas on 02/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

// implements protocol
public final class RemoteAuthentication {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(authenticationModel: AuthenticationModel) {
        httpClient.post(to: url, with: authenticationModel.toData(), completion: { _ in })
    }
}
