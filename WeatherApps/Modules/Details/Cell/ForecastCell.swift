//
//  ForecastCell.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var forecastImg: UIImageView!
    @IBOutlet weak var forecastDayLbl: UILabel!
    @IBOutlet weak var forecastTempDescLbl: UILabel!
    @IBOutlet weak var forecastTempLbl: UILabel!

    var dataList: List? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        let temperature = self.dataList?.temp?.max ?? 0.0
        let currentTemp = String(format: "%.0f", temperature - 273.15)

        forecastImg.image = UIImage(named: dataList?.weather?[0].main ?? "")
        forecastDayLbl.text = "\(getDayFromUNIX(data: dataList?.dt ?? 0))"
        forecastTempLbl.text = dataList?.weather?[0].weatherDescription ?? ""
        forecastTempLbl.text = "\(currentTemp)°"
    }
    

}
