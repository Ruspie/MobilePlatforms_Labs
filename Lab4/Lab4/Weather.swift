//
//  Weather.swift
//  Lab2
//
//  Created by Admin on 19.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation

class Weather {
    
    var sity: String
    var temperature: Double
    var wind: String
    var main: String
    
    init(){
        sity = String()
        temperature = Double()
        wind = String()
        main = String()
    }
    
    init(sity: String, temperature: Double, wind: String, main: String){
        self.sity = sity
        self.temperature = temperature
        self.wind = wind
        self.main = main
    }
    
}
