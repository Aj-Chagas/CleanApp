//
//  InfraTests.swift
//  InfraTests
//
//  Created by Anderson Chagas on 06/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Alamofire
import Data

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void){
        session.request(url, method: .post, parameters: data?.toJson()).responseData { dataResponse in
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success: break
            }
        }
    }
    
}

class AlamofireAdapterTest: XCTestCase {

    func test_post_shold_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        testPostRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_shold_make_request_with_no_data() {
        testPostRequestFor(url: makeUrl(), data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    

}

extension AlamofireAdapterTest {
    
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut)
        return sut
    }
    
    func testPostRequestFor(url: URL, data: Data?,  action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        var request: URLRequest?
        URLProtocolStub.observeRequest { request = $0 }
        sut.post(to: url, with: data) { _ in exp.fulfill() }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?)) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeInvalidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)) : XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedSuccess), .success(let receivedSuccess)): XCTAssertEqual(expectedSuccess, receivedSuccess)
            default: XCTFail("expected \(expectedResult) got \(receivedResult) instead ")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

/*
 Esses são todo os casos que podem vir em um request, o alamofire já garante esse tratamento, por exemplo no caso de vir data, response e error, esse cenário deve retornar um erro, para a gente garantir isso, fazemos esses teste para ter certeza que o alamofire está realmente garantindo isso pra gente.
 
 Para cobrir esses testes a gente cria tres variaveis(data, request e error) na urlProtocolStub
 
 data response error. Validos
 ok     ok      x
 x      x       ok
 
                    invalido
 ok     ok      ok
 ok     x       ok
 ok     x       x
 x      ok      ok
 x      ok      x
 x      x       x
    
 */

class URLProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        URLProtocolStub.data = data
        URLProtocolStub.response = response
        URLProtocolStub.error = error
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override open func startLoading() {
        URLProtocolStub.emit?(request)
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override open func stopLoading() {
        
    }
}
