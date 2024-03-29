//
//  DataTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 9/13/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import XCTest
import Domain
import Data 

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpClientSpy.completionWithError(.noConnectivity)
        })
    }

    func test_add_should_complete_with_email_in_use_error_if_client_completes_with_forbideen() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, expectedResult: .failure(.emailInUse), when: {
            httpClientSpy.completionWithError(.forbideen)
        })
    }
    
    func test_add_should_complete_with_success_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectedAccount = makeAccountModel()
        expect(sut, expectedResult: .success(expectedAccount), when: {
            httpClientSpy.completionWithData(expectedAccount.toData()!)
        })
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpClientSpy.completionWithData(makeInvalidData())
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeUrl(), httpClient: httpClientSpy)
        var result: AddAccount.Result?
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpClientSpy.completionWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTests {
        
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy ){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, expectedResult: Result<AccountModel, DomainError>, when action: () -> Void,  file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
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
