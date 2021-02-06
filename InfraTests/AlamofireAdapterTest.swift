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
    
    func post(to url: URL){
        session.request(url, method: .post).resume()
    }
    
}

class AlamofireAdapterTest: XCTestCase {

    func test() {
        let url = makeUrl()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        let exp = expectation(description: "waiting")
        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
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
