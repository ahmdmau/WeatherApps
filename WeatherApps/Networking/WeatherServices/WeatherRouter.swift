//
//  WeatherRouter.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter: BaseRouter {
    case fetchCurrentWeather(city: Int)
    case fetchForecast(city: Int)

    // MARK: - Path
    internal var path: String {
        switch self {
        case .fetchCurrentWeather:
            return "weather"
        case .fetchForecast:
            return "forecast/daily"
        }
    }

    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        case .fetchCurrentWeather(let city):
            params = ["id": city,"appid": "d78279fb7fe6de36ccb7ca738b93253e"]
        case .fetchForecast(let city):
            params = ["id": city,"cnt": 5, "appid": "60c6fbeb4b93ac653c492ba806fc346d"]
        }
        return params
    }

    // MARK: - Methods
    internal var method: HTTPMethod {
        return .get
    }
}
