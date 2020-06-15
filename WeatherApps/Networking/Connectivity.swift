//
//  Connectivity.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
