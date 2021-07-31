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
        let email = "\(UUID().uuidString)@gmail.com"
        let addAccountModel = AddAccountModel(name: "Anderson_reis", email: email, password: "123456", passwordConfirmation: "123456")
        
        // signup with a valid email
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
        
        // try signup with an email already used.
        
        let exp2 = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error):
                switch error {
                case .emailInUse:
                    XCTAssertNotNil(error)
                default:
                    XCTFail("Expect failure of type email in use got \(result) instead")
                }
            case .success:
                XCTFail("Expect failure got \(result) instead")
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 5)
    }

}
