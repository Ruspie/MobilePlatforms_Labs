//
//  Film.swift
//  Lab2
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation

class Film {
    var name: String
    var releaseDate: String
    var rating: String
    var description: String
    var imageName: String
    
    init(name: String, releaseDate: String, rating: String, description: String, imageName: String) {
        self.name = name
        self.releaseDate = releaseDate
        self.rating = rating
        self.description = description
        self.imageName = imageName
    }
    
    init(){
        self.name = String("")
        self.releaseDate = String("")
        self.rating = String("")
        self.description = String("")
        self.imageName = String("")
    }
}
