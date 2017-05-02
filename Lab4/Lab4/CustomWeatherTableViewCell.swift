//
//  WeatherTableViewCell.swift
//  Lab2
//
//  Created by Admin on 19.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit

class CustomWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherStackView: UIStackView!
    @IBOutlet weak var sityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
