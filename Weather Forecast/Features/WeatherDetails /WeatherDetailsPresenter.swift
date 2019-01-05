//
//  WeatherDetailsPresenter.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

protocol  WeatherDetailsPresenterDelegate: class {
    func reloadData()
    func startIndicator()
    func stopIndicator()
    func displayError(_ error: Error)
}

class WeatherDetailsPresenter {
    
    private weak var delegate: WeatherDetailsPresenterDelegate?
    
    var city: City?
    
    private var weatherDays = [WeatherCity]()
    
    private var detailsData = [DetailsViewData]()
    
    private func loadDetails() {
        guard let id = city?.id else { return }
        self.delegate?.startIndicator()
        APIManager.getDetailWeather(cityId: String(id), success: { weathers in
            if weathers.count > 0 {
                self.get5daysWeathers(weathers: weathers)
            }
            
        }, failure: { error in
            self.delegate?.stopIndicator()
            self.delegate?.displayError(error)
        })
    }
    
    private func get5daysWeathers( weathers: [WeatherCity]) {
        var index = 0
        while index < 40 {
            self.detailsData.append(DetailsViewData(weather: weathers[index]))
            index += 8
        }
        self.delegate?.stopIndicator()
        self.delegate?.reloadData()
    }
}

extension WeatherDetailsPresenter {
    func setDelegate(delegate: WeatherDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func weatherDaysCount() -> Int {
        return detailsData.count
    }
    
    func weatherDay(index: Int) -> DetailsViewData {
        return detailsData[index]
    }
    
    func viewDidLoad() {
        loadDetails()
    }
}
