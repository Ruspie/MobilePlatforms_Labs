//
//  CustomWeatherTableViewCell.swift
//  Lab3
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit

class CustomWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var sityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
