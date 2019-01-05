//
//  DetailsViewCell.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/5/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit

class DetailsViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColorView.cornerRadius(10)
        backgroundColorView.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.7058823529, blue: 0.9803921569, alpha: 1)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func update(with data: DetailsViewData) {
        self.dayLabel.text = data.day
        self.statusLabel.text = data.status
        self.windLabel.text = data.wind
        self.humidityLabel.text = data.humidity
        self.temperatureLabel.text = data.temperature
        self.pressureLabel.text = data.pressure
        self.statusIcon.asyncSetImage(with: URL(string: data.urlIconStatus))
    }
}
