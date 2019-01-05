//
//  DetailsViewData.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/5/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

class DetailsViewData {
    var status: String = ""
    var urlIconStatus: String = ""
    var day: String = ""
    var temperature: String = ""
    var humidity: String = ""
    var wind: String = ""
    var pressure: String = ""
    
    init(weather: WeatherCity) {
        guard let main = weather.main, let status = weather.weather?.first, let wind = weather.wind else { return }
        if let status = status.main { self.status = status }
        if let stamp = weather.dt { self.day = convertStampToDay(stamp: stamp) }
        if let speed = wind.speed { self.wind = String(format:"%.02f", speed) + " m/s"}
        if let humd = main.humidity { self.humidity = String(format:"%.0f", humd) + " %" }
        if let temp = main.temp { self.temperature = String(format:"%.0f", temp-273.15) + " °C"}
        if let pres = main.pressure { self.pressure = String(format:"%.02f", pres) + " hPa"}
        if let icon = status.icon { self.urlIconStatus = "http://openweathermap.org/img/w/" + icon + ".png" }
    }
    
    private func convertStampToDay(stamp: Double) -> String {
        let date = Date(timeIntervalSince1970: stamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
}
