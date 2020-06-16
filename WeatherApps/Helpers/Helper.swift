//
//  Helper.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {

    func showAlertWithTitle(msg:String,controller:UIViewController)
    {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

public extension NSObject {

    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

public func convertDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MM MMMM yyyy"
    let dateString = dateFormatter.string(from: date)

    return dateString
}

public func getDayFromUNIX(data: Int)-> String{
    let date = Date(timeIntervalSince1970: Double(data))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE"
    let strDate = dateFormatter.string(from: date)
    return strDate
}
