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
        let url = URL(string: "http://any-url.com")!
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
        let exp = expectation(description: "Waiting response")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expected erro receiced success instead.")
            }
            exp.fulfill()
        }
        httpClientSpy.completionWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_success_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "Waiting response")
        let expectedAccount = makeAccountModel()
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure: XCTFail("Expected success receiced \(result) instead.")
            case .success(let receivedAccount): XCTAssertEqual(receivedAccount, expectedAccount)
            }
            exp.fulfill()
        }
        httpClientSpy.completionWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "Waiting response")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expected erro receiced success instead.")
            }
            exp.fulfill()
        }
        httpClientSpy.completionWithData(Data("invalid_data".utf8))
        wait(for: [exp], timeout: 1)
    }
}

extension RemoteAddAccountTests {
    
    // Foi retornado uma tupla, pois tanto a instancia do remoteAddAccount, quanto o HttpclientSpy são necessárias para os testes
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy ){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
    }
    
    class HttpClientSpy: HttpPostClient {
        
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
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
}
