//
//  City.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import Foundation

class City {
   
    let id: Int
    let name: String
    var status: String = ""
    var temperature: String = ""
    var iconStaus: String = ""
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
