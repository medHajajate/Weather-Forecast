//
//  CityWeatherViewCell.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit

class CityWeatherViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        cityLabel.cornerRadius(7)
        tempLabel.cornerRadius(7)
    }

    func update(with city: City) {
        cityLabel.text = city.name
        tempLabel.text = city.temperature + " °C"
        statusLabel.text = city.status
        if city.iconStaus != "" {
            statusIcon.asyncSetImage(with: URL(string: "http://openweathermap.org/img/w/" + city.iconStaus + ".png"))
        }
    }

}
