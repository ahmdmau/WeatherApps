//
//  APIRequest.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
    func request<T: Decodable>(request: URLRequestConvertible, completion: @escaping(Result<T, AFError>) -> Void)
}

extension APIRequest {
    func request<T: Decodable>(request: URLRequestConvertible, completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(request).validate().responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
