//
//  WeatherNetwork.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import Alamofire

class WeatherNetwork: APIRequest {
    func fetchCurrentWeather(city: Int, completion: @escaping(Result<CurrentWeather, AFError>) -> Void) {
        request(request: WeatherRouter.fetchCurrentWeather(city: city), completion: completion)
    }

    func fetchForecast(city: Int, completion: @escaping(Result<ForecastData, AFError>) -> Void) {
        request(request: WeatherRouter.fetchForecast(city: city), completion: completion)
    }
}
