//
//  Weather.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct WeatherCity: Codable {
    let dt: Double?
    let main: Temperature?
    let weather: [Weather]?
    let wind: Wind?
    let id: Int?
    let name: String?
    let cod: String?
}

struct WeatherList: Codable {
    let cnt: Int?
    let cod: String?
    let list: [WeatherCity]?
}

struct Temperature: Codable {
    let temp: Double?
    let pressure: Double?
    let humidity: Double?
    let temp_min: Double?
    let temp_max: Double?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}

struct weatherSearch: Codable {
    let id: Double?
    let message: String?
    let name: String?
    let weather: [Weather]?
    let main: Temperature?
}
