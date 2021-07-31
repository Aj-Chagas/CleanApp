//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Anderson Chagas on 22/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account()  {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Anderson_reis", email: "anderson128@gmail.com", password: "123456", passwordConfirmation: "123456")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
