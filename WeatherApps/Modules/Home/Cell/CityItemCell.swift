//
//  CityItemCell.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 16/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import UIKit

class CityItemCell: UITableViewCell {

    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var cityIdLbl: UILabel!

    var city: ListCity? {
        didSet {
            self.configure()
        }
    }

    func configure() {
        cityNameLbl.text = city?.cityName
        cityIdLbl.text = "\(city?.idCity ?? 0)"
    }

    
}
