//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Anderson Chagas on 31/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteAddAccount(httpClient: HttpPostClient) -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "signup"), httpClient: httpClient)
    return MainQueueDispatchDecorator(instance: remoteAddAccount)
}
