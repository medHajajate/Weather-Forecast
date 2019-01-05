//
//  APIManager.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let urlAPI = "http://api.openweathermap.org/data/2.5/"
    static let apiKey = "cad58b62301f4d2769eee73e2979c44b"
    
    static func requestCitiesWeather(_ ids: [String], success:@escaping ([WeatherCity]) -> Void, failure:@escaping (Error) -> Void) {
        let citesId = ids.map{ $0 }.joined(separator: ",")
        let requestURL = APIManager.urlAPI + "group?id=" + citesId + "&appid=" + APIManager.apiKey
        print(requestURL)
        Alamofire.request(requestURL).responseJSON { (response) -> Void in
            
            let json = response.data
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherList.self, from: json!)
                success(response.list ?? [])
            }catch let error {
                failure(error)
            }
        }
    }
    
    static func getDetailWeather(cityId: String, success:@escaping ([WeatherCity]) -> Void, failure:@escaping (Error) -> Void) {
        let requestURL = APIManager.urlAPI + "forecast?id=" + cityId + "&cnt=40&appid=" + APIManager.apiKey
        print(requestURL)
        Alamofire.request(requestURL).responseJSON { (response) -> Void in
            
            let json = response.data
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherList.self, from: json!)
                success(response.list ?? [])
            }catch let error {
                failure(error)
            }
        }
    }
}
