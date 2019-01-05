//
//  CitiesListPresenter.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

protocol  CitiesListPresenterDelegate: class {
    func reloadData()
    func startIndicator()
    func stopIndicator()
    func displayError(_ error: Error)
    func endRefreshing()
}

class CitiesListPresenter {
    
    private var cities = [City(id: 7456416, name: "Rabat"), City(id: 6547294, name: "Casablanca"), City(id: 2530335, name: "Tangier"), City(id: 6547285, name: "Marrakech"), City(id: 2548885, name: "Fes")]
    
    private weak var  delegate: CitiesListPresenterDelegate?
    
    private  func loadList() {
        self.delegate?.startIndicator()
        let idsCities = cities.map{ String($0.id) }
        APIManager.requestCitiesWeather(idsCities, success: { weathers in
            self.setupStatusCities(weathers: weathers)
        }, failure: { error in
            self.delegate?.stopIndicator()
            self.delegate?.displayError(error)
        })
    }
    
    private func setupStatusCities(weathers: [WeatherCity]) {
        for weather in weathers {
            guard let index = cities.index(where: { $0.id == weather.id }), let status = weather.weather?.first,
                let  temp = weather.main?.temp else { return }
            cities[index].status = status.main ?? ""
            cities[index].temperature = String(format:"%.0f",temp-273.15)
            cities[index].iconStaus = status.icon ?? ""
        }
        self.delegate?.stopIndicator()
        delegate?.reloadData()
    }
    
    private func refreshList() {
        let idsCities = cities.map{ String($0.id) }
        APIManager.requestCitiesWeather(idsCities, success: { weathers in
            self.setupStatusCities(weathers: weathers)
            self.delegate?.endRefreshing()
        }, failure: { error in
            self.delegate?.displayError(error)
            self.delegate?.endRefreshing()
        })

    }
}

extension CitiesListPresenter {
    
    func setDelegate(delegate: CitiesListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func citiesCount() -> Int {
        return cities.count
    }
    
    func city(index: Int) -> City {
        return cities[index]
    }
    
    func viewDidLoad() {
        loadList()
    }
    
    func refreshData() {
        refreshList()
    }
}

