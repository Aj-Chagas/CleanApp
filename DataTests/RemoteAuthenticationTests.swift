//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 02/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {

    func test_auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }

    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpClientSpy.completionWithError(.noConnectivity)
        })
    }

    func test_auth_should_complete_with_expired_session_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, expectedResult: .failure(.expiredSession), when: {
            httpClientSpy.completionWithError(.unauthorized)
        })
    }

    func test_auth_should_complete_with_success_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectedAccount = makeAccountModel()
        expect(sut, expectedResult: .success(expectedAccount), when: {
            httpClientSpy.completionWithData(expectedAccount.toData()!)
        })
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!,
                 file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
    }

    func expect(_ sut: RemoteAuthentication,
                expectedResult: Authentication.Result,
                when action: () -> Void,  file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case(.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }

}
