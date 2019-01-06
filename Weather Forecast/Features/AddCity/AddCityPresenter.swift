//
//  AddCityPresenter.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/6/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

protocol AddCityPresenterDelegate: class {
    func displayCity(with city: City)
    func displayNotFound()
    func displayError(_ error: Error)
}

class AddCityPresenter {
    
    private weak var delegate: AddCityPresenterDelegate?
    
    func searchCity(city: String) {
        let cityName = city.replacingOccurrences(of: " ", with: "+")
        APIManager.searchCity(city: cityName, success: { weather in
            if weather.message == "city not found" {
                self.delegate?.displayNotFound()
            } else {
                guard let city = self.convertToCity(weather: weather) else { return }
                self.delegate?.displayCity(with: city)
            }
        }, failure: { error in
            self.delegate?.displayError(error)
        })
    }
    
    func convertToCity(weather: weatherSearch) -> City? {
        guard let id = weather.id, let name = weather.name, let status = weather.weather?.first?.main, let icon = weather.weather?.first?.icon, let temp = weather.main?.temp else { return nil}
        let city = City(id: Int(id), name: name)
        city.status = status
        city.iconStaus = icon
        city.temperature = String(format:"%.0f",temp-273.15)
        return city
    }
}

extension AddCityPresenter {
    func setDelegate(delegate: AddCityPresenterDelegate) {
        self.delegate = delegate
    }
}
