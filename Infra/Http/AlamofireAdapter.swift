//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Anderson Chagas on 22/02/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Alamofire
import Data

class AlamofireAdapter: HttpPostClient {

    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void){
        session.request(url, method: .post, parameters: data?.toJson()).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbideen))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
    
}
