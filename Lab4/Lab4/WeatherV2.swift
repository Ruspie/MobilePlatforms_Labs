//
//  Weather.swift
//  Lab3
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation

public class WeatherV2{
    
    private let defaultLongitude = Double(27.594933)
    private let defaultLatitude = Double(53.911850)
    
    var sity: String
    var temperature: Double
    var wind: Double
    var description: String
    var longitude: Double
    var latitude: Double
    
    init(){
        sity = String()
        temperature = Double()
        wind = Double()
        description = String()
        longitude = defaultLongitude
        latitude = defaultLatitude
    }
    
    init(sity: String, temperature: Double, wind: Double, description: String, longitude: Double, latitude: Double){
        self.sity = sity
        self.temperature = temperature
        self.wind = wind
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
    }
    
    func getSnippedInfo() -> String{
        return "temperature: " + String(temperature) + "°C\r\n" + "wind: " + String(wind) + "m/s\r\n" + "description: " + description
    }
    
}
