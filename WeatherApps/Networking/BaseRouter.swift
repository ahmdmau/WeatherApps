//
//  BaseRouter.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRouter: URLRequestConvertible {
    var mainURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
    var headers: [String: String]? { get }
}


extension BaseRouter {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var mainURL: URL  {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }

    var headers: [String : String]? {
        let httpHeader = [
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
        return httpHeader
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers?.forEach({ request.addValue($0.value, forHTTPHeaderField: $0.key) })
        return request
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}

