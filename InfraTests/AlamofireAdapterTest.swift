//
//  InfraTests.swift
//  InfraTests
//
//  Created by Anderson Chagas on 06/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?){
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json).resume()
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
        sut.post(to: url, with: data)
        let exp = expectation(description: "waiting")
        URLProtocolStub.observeRequest { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

class URLProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override open func startLoading() {
        URLProtocolStub.emit!(request)
    }

    override open func stopLoading() {
        
    }
}
